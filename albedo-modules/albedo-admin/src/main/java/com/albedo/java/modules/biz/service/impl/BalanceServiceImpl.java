package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.CommonConstants.BUSINESS_ADMIN_ROLE_ID;
import static com.albedo.java.common.core.constant.CommonConstants.PERSONAL_USER_ROLE_ID;

import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;

import com.albedo.java.common.core.exception.TimesOverspendException;
import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.repository.BalanceRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.UserRole;
import com.albedo.java.modules.sys.service.UserRoleService;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

/**
 * @author arronshentu
 */
@Service
public class BalanceServiceImpl extends BaseServiceImpl<BalanceRepository, Balance> implements BalanceService {

  @Override
  public void addTimes(int times, String userId) {
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
  public int leftTimes() {
    String userId = SecurityUtil.getUser().getId();
    String deptId = SecurityUtil.getUser().getDeptId();
    // 1. 个人用户直接返回
    if (deptId.equals(PERSONAL_USER_ROLE_ID)) {
      Balance balance = baseMapper.selectOne(Wrappers.<Balance>query().eq("user_id", userId));
      if (balance != null) {
        return balance.getTimes();
      }
    }
    List<String> userIds = userService.list(Wrappers.<User>query().eq("dept_id", deptId)).stream().map(User::getId)
      .collect(Collectors.toList());
    List<Balance> users = baseMapper.selectList(Wrappers.<Balance>query().in("user_id", userIds));
    // 整个公司
    return users.stream().mapToInt(Balance::getTimes).sum();
  }

  @Override
  public void consumeTimes() throws TimesOverspendException {
    String deptId = SecurityUtil.getUser().getDeptId();
    // 1. 个人用户直接扣
    if (deptId.equals(PERSONAL_USER_ROLE_ID)) {
      consumeStaffTimes();
      return;
    }
    // 2. 企业用户默认扣公司 公司不够再扣个人
    // 先获取deptId来获得所有员工id
    List<String> userIds = userService.list(Wrappers.<User>query().eq("dept_id", deptId)).stream().map(User::getId)
      .collect(Collectors.toList());
    // userRole中找到这些员工中role为admin的员工
    List<UserRole> list =
      userRoleService.list(Wrappers.<UserRole>query().eq("role_id", BUSINESS_ADMIN_ROLE_ID).in("user_id", userIds));
    // 扣这个负责人的次数，负责人次数不够再扣自己 自己不够就return
    if (CollectionUtils.isNotEmpty(list)) {
      String adminId = list.get(0).getUserId();
      try {
        consumeTimes(adminId);
      } catch (TimesOverspendException e) {
        consumeStaffTimes();
      }
    }

  }

  private boolean consumeTimes(String userId) throws TimesOverspendException {
    Balance balance = baseMapper.selectOne(Wrappers.<Balance>query().eq("user_id", userId));
    if (balance.getTimes() > 1) {
      balance.setTimes(balance.getTimes() - 1);
    } else {
      throw new TimesOverspendException("次数已耗尽");
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
  UserRoleService userRoleService;
}
