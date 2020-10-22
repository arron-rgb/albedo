package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.STR_NO;
import static com.albedo.java.common.core.constant.CommonConstants.STR_YES;
import static com.albedo.java.common.core.constant.ExceptionNames.INVALID_COUPON;
import static com.albedo.java.common.core.constant.ExceptionNames.PURCHASE_RECORD_NOT_FOUND;

import java.math.BigDecimal;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.Coupon;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.domain.dto.PlanDto;
import com.albedo.java.modules.biz.repository.PlanRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.CouponService;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.math.Money;

/**
 * @author arronshentu
 */
@Service
public class PlanServiceImpl extends DataServiceImpl<PlanRepository, Plan, PlanDto, String> implements PlanService {

  @Resource
  CouponService couponService;
  @Resource
  AliPayService aliPayService;
  @Resource
  PurchaseRecordService recordService;

  @Override
  public String purchase(String planId, String couponCode) {
    Plan plan = baseMapper.selectById(planId);
    BigDecimal price = plan.getPrice();
    if (StringUtils.isNotEmpty(couponCode)) {
      Money money = new Money(price);
      Coupon code = couponService.getOne(Wrappers.<Coupon>query().eq("code", couponCode).eq("status", STR_YES));
      Assert.notNull(code, INVALID_COUPON);
      String discount = code.getDiscount();
      money.multiplyBy(Double.parseDouble(discount));
      price = money.getAmount();
      code.setUserId(SecurityUtil.getUser().getId());
      code.setOrderId(plan.getId());
      code.setStatus(STR_NO);
      code.updateById();
    }
    TradePlus trade = TradePlus.build(price.toPlainString(), plan.getName());
    // 购买记录本地不区分支付状态，需要验证时通过aliPayService去查询
    PurchaseRecord record = PurchaseRecord.buildPlan(trade, planId);
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
      Assert.notNull(record, PURCHASE_RECORD_NOT_FOUND);
      String planId = record.getOuterId();
      String userId = record.getUserId();
      Plan plan = baseMapper.selectById(planId);
      if (plan == null) {
        return false;
      }
      Balance balance;
      balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
      if (balance != null) {
        Plan oldPlan = baseMapper.selectById(balance.getPlanId());
        Assert.notNull(oldPlan, "未查询到旧套餐记录");
        int compare = plan.compareTo(oldPlan);
        Integer oldStorage = plan.getStorage();
        Double usedStorage = oldStorage - balance.getStorage();
        // 更新为高级套餐记录
        if (compare > 0) {
          updateBalance(balance, plan);
        }
        // 添加次数
        addBalance(balance, plan);
        Integer full = plan.getStorage();
        balance.setStorage(full - usedStorage);
      } else {
        balance = copyPlan(userId, plan);
      }
      return balanceService.saveOrUpdate(balance);
    }
    return false;
  }

  @Override
  public Balance copyPlan(String userId, Plan plan) {
    Balance balance = new Balance();
    // 写入新余量
    BeanUtils.copyProperties(plan, balance);
    balance.setPlanType(plan.getName());
    balance.setPlanId(plan.getId());
    balance.setStorage(plan.getStorage().doubleValue());
    balance.setUserId(userId);
    return balance;
  }

  @Override
  public void addBalance(Balance balance, Plan plan) {
    Integer editTime = plan.getEditTime();
    Integer times = plan.getTimes();
    Integer audioTime = plan.getAudioTime();
    Integer customTimes = plan.getCustomTimes();
    balance.setEditTimes(balance.getEditTimes() + editTime);
    balance.setTimes(balance.getTimes() + times);
    balance.setAudioTime(balance.getAudioTime() + audioTime);
    balance.setCustomTimes(balance.getCustomTimes() + customTimes);
  }

  private void updateBalance(Balance balance, Plan plan) {
    String name = plan.getName();
    Integer childAccount = plan.getChildAccount();
    Integer storage = plan.getStorage();
    Integer goodsQuantity = plan.getGoodsQuantity();
    String id = plan.getId();
    Integer videoTime = plan.getVideoTime();

    balance.setPlanType(name);
    balance.setChildAccount(childAccount);

    // todo 原有的存储容量 需要更新一下
    balance.setStorage(storage.doubleValue());
    balance.setVideoTime(videoTime);
    balance.setPlanId(id);
    balance.setGoodsQuantity(goodsQuantity);
  }

  @Resource
  BalanceService balanceService;

}
