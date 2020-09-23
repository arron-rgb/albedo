package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.PERSONAL_USER_ROLE_ID;

import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.albedo.java.common.core.constant.ExceptionNames;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.exception.TimesOverspendException;
import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.BalanceRecord;
import com.albedo.java.modules.biz.domain.Commodity;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.domain.dto.BalanceDto;
import com.albedo.java.modules.biz.repository.BalanceRecordRepository;
import com.albedo.java.modules.biz.repository.BalanceRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.CommodityService;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;

/**
 * @author arronshentu
 */
@Service
public class BalanceServiceImpl extends BaseServiceImpl<BalanceRepository, Balance> implements BalanceService {

  @Resource
  UserService userService;
  @Resource
  BalanceRecordRepository recordRepository;

  @Override
  public void addTimes(int times, String userId) {
    Balance balance = baseMapper.selectOne(Wrappers.<Balance>query().eq("user_id", userId));
    // 不存在的话直接返回
    Assert.notNull(balance, ExceptionNames.BALANCE_NOT_FOUND);
    int update = balance.getTimes() + times;
    balance.setTimes(update);
    baseMapper.updateById(balance);
    BalanceRecord record =
      BalanceRecord.builder().type(ADD).amount(times).dimension(ORDER_TIMES).userId(userId).build();
    recordRepository.insert(record);

  }

  @Override
  public Integer leftTimes() {
    String userId = SecurityUtil.getUser().getId();
    String deptId = SecurityUtil.getUser().getDeptId();
    // 1. 个人用户直接返回
    if (deptId.equals(PERSONAL_USER_ROLE_ID)) {
      Balance balance = baseMapper.selectOne(Wrappers.<Balance>query().eq("user_id", userId));
      if (balance != null) {
        return balance.getTimes();
      } else {
        return null;
      }
    }
    // todo 企业用户返回自己的 or 返回企业下员工总和
    List<String> userIds = userService.list(Wrappers.<User>query().eq("dept_id", deptId)).stream().map(User::getId)
      .collect(Collectors.toList());
    List<Balance> users = baseMapper.selectList(Wrappers.<Balance>query().in("user_id", userIds));
    // 整个公司
    return users.stream().mapToInt(Balance::getTimes).sum();
  }

  @Override
  public void consumeTimes() throws TimesOverspendException {
    String deptId = SecurityUtil.getUser().getDeptId();
    String userId = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();
    // 1. 个人角色 && 公共部门 直接扣
    if (deptId.equals(PUBLIC_DEPT_ID) && roles.contains(PERSONAL_USER_ROLE_ID)) {
      consumeStaffTimes();
      return;
    }
    // 2. 企业用户默认扣公司 公司不够再扣个人
    if (roles.contains(BUSINESS_ADMIN_ROLE_ID) || roles.contains(BUSINESS_COMMON_ROLE_ID)) {
      String adminId = userService.getAdminIdByDeptId(deptId);
      Assert.notEmpty(adminId, ExceptionNames.ENTERPRISE_ADMIN_NOT_FOUND);

      try {
        if (!consumeTimes(adminId)) {
          throw new RuntimeMsgException("扣费失败");
        }
      } catch (TimesOverspendException e) {
        consumeStaffTimes();
      }
    }
    // 既不是个人 也不是企业 但有次数的情况 todo 方便测试 或 产生了脏数据
    List<Balance> balances = baseMapper.selectList(Wrappers.<Balance>query().eq("user_id", userId));
    if (balances.size() == 1) {
      consumeStaffTimes();
    } else {
      throw new RuntimeMsgException("当前用户余量出现问题");
    }

  }

  private void consumeStaffTimes() throws TimesOverspendException {
    consumeTimes(SecurityUtil.getUser().getId());
  }

  private boolean consumeTimes(String userId) throws TimesOverspendException {
    // 消耗传入的userId的次数
    Balance balance = baseMapper.selectOne(Wrappers.<Balance>query().eq("user_id", userId));
    Assert.notNull(balance, ExceptionNames.BALANCE_NOT_FOUND);
    Assert.isTrue(balance.getTimes() > 0, ExceptionNames.TIMES_OVERSPEND);
    balance.setTimes(balance.getTimes() - 1);
    boolean flag = baseMapper.updateById(balance) > 0;
    if (flag) {
      // 记录使用者的id
      BalanceRecord record =
        BalanceRecord.builder().amount(1).dimension(ORDER_TIMES).userId(SecurityUtil.getUser().getId()).build();
      recordRepository.insert(record);
    }
    return flag;
  }

  @Override
  public BalanceDto getBalanceInfo() {
    Balance balance = getOne(Wrappers.<Balance>query().eq("user_id", SecurityUtil.getUser().getId()));
    Assert.notNull(balance, "用户未购买任何套餐");
    BalanceDto dto = new BalanceDto();
    dto.setTimes(balance.getTimes());
    dto.setAccountAvailable(balance.getAccountAvailable());
    int amount = commodityService.count(Wrappers.<Commodity>query().eq("created_by", SecurityUtil.getUser().getId()));
    dto.setCommodity(amount);
    dto.setPlanName(balance.getPlanType());
    dto.setStorage(balance.getStorage());
    String deptId = SecurityUtil.getUser().getDeptId();
    List<String> users = userService.list(Wrappers.<User>query().eq("dept_id", deptId)).stream().map(User::getUsername)
      .collect(Collectors.toList());
    dto.setAccountIds(users);
    Plan plan = planService.getById(balance.getPlanId());
    Assert.notNull(plan, "未查询到旧套餐记录");
    dto.setAccountAmount(plan.getChildAccount());
    dto.setAllowedCommodity(plan.getGoodsQuantity());
    dto.setAllowedStorage(plan.getStorage().doubleValue());
    // recordRepository.selectOne()
    return dto;
  }

  @Resource
  PlanService planService;
  @Resource
  CommodityService commodityService;

}
