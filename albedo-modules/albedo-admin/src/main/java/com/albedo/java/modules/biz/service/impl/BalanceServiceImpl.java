package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.CommonConstants.BUSINESS_ADMIN_ROLE_ID;

import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;

import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.repository.BalanceRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.UserRole;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.service.UserRoleService;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author arronshentu
 */
@Service
public class BalanceServiceImpl extends BaseServiceImpl<BalanceRepository, Balance> implements BalanceService {
  // todo 对接支付宝的逻辑均无，默认使用在支付接口验证完毕后的业务方法

  @Override
  public void addTimes() {
    // 直接充进个人账号即可
    String userId = SecurityUtil.getUser().getId();
    int times = 0;
    Balance balance = new Balance();
    // 判断有无
    List<Balance> users = baseMapper.selectList(Wrappers.<Balance>query().eq("user_id", userId));
    if (users.size() == 1) {
      balance = users.get(0);
      balance.setTimes(balance.getTimes() + times);
      baseMapper.updateById(balance);
    } else {
      balance.setTimes(times);
      baseMapper.insert(balance);
    }
  }

  @Override
  public void leftTimes() {
    // String userId = SecurityUtil.getUser().getId();
    String deptId = SecurityUtil.getUser().getDeptId();
    List<String> userIds = userService.list(Wrappers.<User>query().eq("dept_id", deptId)).stream().map(User::getId)
      .collect(Collectors.toList());
    List<Balance> users = baseMapper.selectList(Wrappers.<Balance>query().in("user_id", userIds));
    // 整个公司
    int leftTimes = users.stream().mapToInt(Balance::getTimes).sum();
  }

  @Override
  public void consumeTimes() {
    // 默认扣公司 公司不够再扣个人
    String deptId = SecurityUtil.getUser().getDeptId();
    // 确定部门后可以确定角色
    // 找到公司负责人
    List<String> userIds = userService.list(Wrappers.<User>query().eq("dept_id", deptId)).stream().map(User::getId)
      .collect(Collectors.toList());
    List<UserRole> list =
      userRoleService.list(Wrappers.<UserRole>query().eq("role_id", BUSINESS_ADMIN_ROLE_ID).in("user_id", userIds));
    // 扣负责人的次数，负责人次数不够再扣自己 自己不够就return
    if (CollectionUtils.isNotEmpty(list)) {
      String adminId = list.get(0).getUserId();
      try {
        consumeTimes(adminId);
        return;
      } catch (TimesOverspendException ignored) {
      }
    }

    try {
      consumeStaffTimes();
    } catch (TimesOverspendException ignored) {
      // todo 返回次数不够的消息
    }

  }

  @AllArgsConstructor
  class TimesOverspendException extends Exception {
    @Getter
    private final String msg;
  }

  private boolean consumeTimes(String userId) throws TimesOverspendException {
    Balance balance = baseMapper.selectOne(Wrappers.<Balance>query().eq("user_id", userId));
    if (balance.getTimes() > 1) {
      balance.setTimes(balance.getTimes() - 1);
    } else {
      throw new TimesOverspendException("");
    }
    boolean flag = baseMapper.updateById(balance) > 0;
    if (flag) {
      // todo 记录进balanceHistory中追溯
    }
    return flag;
  }

  private void consumeStaffTimes() throws TimesOverspendException {
    consumeTimes(SecurityUtil.getUser().getId());
  }

  @Resource
  UserService userService;
  @Resource
  DeptService deptService;
  @Resource
  UserRoleService userRoleService;
}
