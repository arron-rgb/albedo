package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.ADD;
import static com.albedo.java.common.core.constant.BusinessConstants.ORDER_TIMES;
import static com.albedo.java.common.core.constant.CommonConstants.PERSONAL_USER_ROLE_ID;

import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.albedo.java.common.core.exception.TimesOverspendException;
import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.BalanceRecord;
import com.albedo.java.modules.biz.repository.BalanceRecordRepository;
import com.albedo.java.modules.biz.repository.BalanceRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.sys.domain.User;
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
    Balance one = baseMapper.selectOne(Wrappers.<Balance>query().eq("user_id", userId));
    // 不存在的话直接返回
    if (one == null) {
      return;
    }
    int update = one.getTimes() + times;
    one.setTimes(update);
    baseMapper.updateById(one);
    BalanceRecord record =
      BalanceRecord.builder().type(ADD).amount(times).dimension(ORDER_TIMES).userId(userId).build();
    recordRepository.insert(record);

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
    String adminId = userService.getOutTradeNosByUserId(deptId);
    try {
      consumeTimes(adminId);
    } catch (TimesOverspendException e) {
      consumeStaffTimes();
    }
  }

  @Resource
  BalanceRecordRepository recordRepository;

  private boolean consumeTimes(String userId) throws TimesOverspendException {
    // 消耗传入的userId的次数
    Balance balance = baseMapper.selectOne(Wrappers.<Balance>query().eq("user_id", userId));
    if (balance.getTimes() > 1) {
      balance.setTimes(balance.getTimes() - 1);
    } else {
      throw new TimesOverspendException("次数已耗尽");
    }
    boolean flag = baseMapper.updateById(balance) > 0;
    if (flag) {
      // 记录使用者的id
      BalanceRecord record =
        BalanceRecord.builder().amount(1).dimension(ORDER_TIMES).userId(SecurityUtil.getUser().getId()).build();
      recordRepository.insert(record);
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
