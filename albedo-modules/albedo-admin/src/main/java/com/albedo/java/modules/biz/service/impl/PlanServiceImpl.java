package com.albedo.java.modules.biz.service.impl;

import java.math.BigDecimal;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.domain.dto.PlanDto;
import com.albedo.java.modules.biz.repository.PlanRepository;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.tool.domain.vo.TradeVo;
import com.albedo.java.modules.tool.service.AliPayService;

/**
 * @author arronshentu
 */
@Service
public class PlanServiceImpl extends DataServiceImpl<PlanRepository, Plan, PlanDto, String> implements PlanService {

  @Resource
  AliPayService aliPayService;

  @Override
  public String purchase(Plan plan) {
    TradeVo trade = new TradeVo();
    BigDecimal price = plan.getPrice();
    trade.setBody(plan.getDescription());
    trade.setSubject(plan.getName());
    trade.setState("");
    trade.setTotalAmount(price.toPlainString());
    try {
      aliPayService.toPayAsPc(trade);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
}
