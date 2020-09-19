package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.ExceptionNames.PURCHASE_RECORD_NOT_FOUND;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.domain.dto.PlanDto;
import com.albedo.java.modules.biz.repository.PlanRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.sys.domain.UserRole;
import com.albedo.java.modules.sys.service.UserRoleService;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;

/**
 * @author arronshentu
 */
@Service
public class PlanServiceImpl extends DataServiceImpl<PlanRepository, Plan, PlanDto, String> implements PlanService {

  @Resource
  AliPayUtils aliPayUtils;
  @Resource
  AliPayService aliPayService;
  @Resource
  PurchaseRecordService recordService;

  @Override
  public String purchase(String planId) {
    Plan plan = baseMapper.selectById(planId);
    TradePlus trade = TradePlus.builder().outTradeNo(aliPayUtils.getOrderCode()).totalAmount(plan.getPrice().toString())
      .subject(plan.getName()).build();
    // 购买记录本地不区分支付状态，需要验证时通过aliPayService去查询
    PurchaseRecord record = PurchaseRecord.buildPlan(trade, trade.getOutTradeNo());
    recordService.save(record);
    try {
      return aliPayService.toPayAsPc(trade);
    } catch (Exception e) {
      e.printStackTrace();
      throw new RuntimeMsgException("生成支付链接时发生异常");
    }
  }

  @Override
  public boolean callback(String outTradeNo) {
    String status = "";
    status = aliPayService.queryOrderStatus(outTradeNo);
    if (StringUtils.equals(TRADE_FINISHED, status) || StringUtils.equals(TRADE_SUCCESS, status)) {
      PurchaseRecord record =
        recordService.getOne(Wrappers.<PurchaseRecord>lambdaQuery().eq(PurchaseRecord::getType, PLAN_TYPE)
          .eq(PurchaseRecord::getOutTradeNo, outTradeNo).orderByAsc(PurchaseRecord::getCreatedDate));
      record.setStatus(TRADE_FINISHED);
      recordService.updateById(record);
      Assert.notNull(record, PURCHASE_RECORD_NOT_FOUND);
      String outerId = record.getOuterId();
      Plan plan = baseMapper.selectById(outerId);
      if (plan == null) {
        return false;
      }
      Balance balance;
      balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", SecurityUtil.getUser().getId()));
      if (balance != null) {
        balance.setTimes(balance.getTimes() + plan.getTimes());
      } else {
        balance = Balance.builder().accountAvailable(plan.getChildAccount()).userId(SecurityUtil.getUser().getId())
          .times(plan.getTimes()).storage(Double.valueOf(plan.getStorage())).build();
      }
      balanceService.save(balance);
      // 买了套餐默认将他更新为企业管理员角色
      // todo PUBLIC_DEPT_ID是否会影响 目测不会
      if (!SecurityUtil.getRoles().contains(BUSINESS_ADMIN_ROLE_ID)) {
        userRoleService.update(Wrappers.<UserRole>update().eq("role_id", PERSONAL_USER_ROLE_ID)
          .eq("user_id", SecurityUtil.getUser().getId()).set("role_id", BUSINESS_ADMIN_ROLE_ID));
      }
      return true;
    }
    return false;
  }

  @Resource
  UserRoleService userRoleService;
  @Resource
  BalanceService balanceService;

}
