package com.albedo.java.modules.biz.domain.enums;

import java.math.BigDecimal;

import com.albedo.java.modules.biz.domain.Plan;

/**
 * @author arronshentu
 */
public enum PlanHolder {
  /**
   * 标准版套餐
   */
  STANDARD(new BigDecimal("0.0"), 100, 2, 3, -1, 1, 3, 3, -1, -1, 3),
  /**
   * 升级
   */
  PLUS(new BigDecimal("0.0"), 200, 2, 3, -1, 3, 6, 6, -1, -1, 3),
  /**
   * 旗舰
   */
  FLAGSHIP(new BigDecimal("0.0"), Integer.MAX_VALUE, 4, 5, 1, 6, 12, 12, 1, 1, 3),
  /**
   * 大客户
   */
  CUSTOMIZED(new BigDecimal("0.0"), Integer.MAX_VALUE, Integer.MAX_VALUE, 5, 3, Integer.MAX_VALUE, 3, 3, 1, 1, 3);

  Plan entity;

  PlanHolder(BigDecimal price, Integer goodsQuality, Integer videoTime, Integer childAccount, Integer editTime,
    Integer storage, Integer anchorAmount, Integer envAmount, Integer anchorAmountPlus, Integer envAmountPlus,
    Integer times) {
    this.entity = Plan.builder().childAccount(childAccount).editTime(editTime).storage(storage)
      .goodsQuantity(goodsQuality).price(price).videoTime(videoTime).anchorAmount(anchorAmount)
      .anchorAmountPlus(anchorAmountPlus).envAmount(envAmount).envAmountPlus(envAmountPlus).times(times).build();
  }

  public Plan getEntity() {
    return this.entity;
  }

}
