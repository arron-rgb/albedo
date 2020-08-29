package com.albedo.java.modules.biz.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.albedo.java.common.core.constant.BusinessConstants;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.domain.dto.PlanDto;
import com.albedo.java.modules.biz.repository.PlanRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.alipay.api.AlipayApiException;

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
  public String purchase(Plan plan) {
    TradePlus trade = TradePlus.builder().outTradeNo(aliPayUtils.getOrderCode()).totalAmount(plan.getPrice().toString())
      .subject(plan.getName()).build();
    PurchaseRecord record = PurchaseRecord.builder().userId(SecurityUtil.getUser().getId())
      .totalAmount(trade.getTotalAmount()).outTradeNo(trade.getOutTradeNo()).outerId(plan.getId()).build();
    recordService.save(record);
    try {
      return aliPayService.toPayAsPc(trade);
    } catch (Exception ignored) {
    }
    return "";
  }

  @Override
  public String updateTimes() {
    String status = "";
    try {
      status = aliPayService.queryOrderStatus("");
    } catch (AlipayApiException ignored) {
    }
    if (BusinessConstants.TRADE_FINISHED.equals(status)) {
      // todo 查询消费记录确定增加的次数；用户id如何确定
      balanceService.addTimes(1, SecurityUtil.getUser().getId());
    }
    return "";
  }

  @Resource
  BalanceService balanceService;
}
