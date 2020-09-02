package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.persistence.domain.GeneralEntity.F_SQL_CREATED_DATE;
import static com.albedo.java.modules.biz.domain.PurchaseRecord.F_OUT_TRADE_NO;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.albedo.java.common.core.constant.BusinessConstants;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.domain.dto.PlanDto;
import com.albedo.java.modules.biz.domain.enums.PlanHolder;
import com.albedo.java.modules.biz.repository.PlanRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.sys.domain.UserRole;
import com.albedo.java.modules.sys.service.UserRoleService;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.alipay.api.AlipayApiException;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

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
  public String callback(String outTradeNo) {
    String status = "";
    try {
      status = aliPayService.queryOrderStatus(outTradeNo);
    } catch (AlipayApiException ignored) {
    }
    if (BusinessConstants.TRADE_FINISHED.equals(status)) {
      PurchaseRecord record = recordService
        .getOne(Wrappers.<PurchaseRecord>query().eq(F_OUT_TRADE_NO, outTradeNo).orderByAsc(F_SQL_CREATED_DATE));
      if (StringUtils.equals(record.getType(), PLAN)) {
        String outerId = record.getOuterId();
        Plan plan = PlanHolder.getPlan(outerId);
        if (plan == null) {
          return "";
        }
        balanceService.addTimes(plan.getTimes(), record.getUserId());

        userRoleService.update(Wrappers.<UserRole>update().eq("role_id", PERSONAL_USER_ROLE_ID)
          .eq("user_id", SecurityUtil.getUser().getId()).set("role_id", BUSINESS_ADMIN_ROLE_ID));
      }
    }
    return "";
  }

  @Resource
  UserRoleService userRoleService;
  @Resource
  BalanceService balanceService;

}
