package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.PERSONAL_USER_ROLE_ID;

import java.util.List;
import java.util.Objects;
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
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
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
    String id = SecurityUtil.getUser().getId();
    String deptId = SecurityUtil.getUser().getDeptId();
    Balance balance = getByUserId(id);
    if (balance == null) {
      balance = initBalance(balance, id);
    }
    BalanceDto dto = new BalanceDto();
    dto.setTimes(balance.getTimes());
    dto.setAccountAvailable(balance.getChildAccount());
    int amount = commodityService.count(Wrappers.<Commodity>query().eq("created_by", id));
    dto.setCommodity(amount);
    dto.setPlanName(balance.getPlanType());
    dto.setStorage(balance.getStorage());
    QueryWrapper<User> wrapper = Wrappers.query();
    wrapper.and(innerWrapper -> {
      innerWrapper.ne("id", id);
      innerWrapper.eq("dept_id", deptId);
    });
    List<String> users = userService.list(wrapper).stream().map(User::getUsername).collect(Collectors.toList());
    dto.setAccountIds(users);
    Plan plan = planService.getById(balance.getPlanId());
    Assert.notNull(plan, "未查询到旧套餐记录");
    if (balance.getChildAccount() == -1) {
      dto.setAccountAmount(0);
      dto.setAccountAvailable(0);
    } else {
      dto.setAccountAmount(plan.getChildAccount());
    }
    dto.setAllowedCommodity(plan.getGoodsQuantity());
    dto.setAllowedStorage(plan.getStorage().doubleValue());
    dto.setAudioTime(balance.getAudioTime());
    dto.setVideoTime(balance.getVideoTime());
    dto.setEditTimes(balance.getEditTimes());
    return dto;
  }

  @Override
  public Balance getByUserId(String userId) {
    Balance balance = getOne(Wrappers.<Balance>lambdaQuery().eq(Balance::getUserId, userId));
    if (balance == null) {
      // 初始化本人的套餐信息
      initBalance(balance, userId);
      UserDto user = userService.getOneDto(userId);
      if (user != null && !PUBLIC_DEPT_ID.equals(user.getDeptId())) {
        String adminId = userService.getAdminIdByDeptId(user.getDeptId());
        Balance adminBalance = getOne(Wrappers.<Balance>lambdaQuery().eq(Balance::getUserId, adminId));
        if (adminBalance != null) {
          return adminBalance;
        }
      }
    }
    return balance;
  }

  @Override
  public Balance initBalance(Balance balance, String userId) {
    // todo 似乎不需要balance参数
    if (Objects.isNull(balance)) {
      Plan plan = planService.getById("6d89ea978f83243c3a137f3d25d9f10e");
      plan.setCustomTimes(0);
      plan.setVideoTime(2);
      balance = planService.copyPlan(userId, plan);
      balance.setTimes(0);
      balance.setChildAccount(-1);
      // 给账号初始化套餐信息
      balance.insert();
      return balance;
    }
    return balance;
  }

  @Resource
  PlanService planService;
  @Resource
  CommodityService commodityService;

}
