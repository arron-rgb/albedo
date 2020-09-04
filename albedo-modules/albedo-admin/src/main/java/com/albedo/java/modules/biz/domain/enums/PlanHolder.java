package com.albedo.java.modules.biz.domain.enums;

import java.math.BigDecimal;

import com.albedo.java.modules.biz.domain.Plan;

/**
 * @author arronshentu
 */
@Deprecated
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

  /**
   * 对应数据库中的实体，内存与数据库同步情况待定
   *
   * @param id
   *          主键
   * @return 实体
   */
  public static Plan getPlan(String id) {
    switch (id) {
      case "3c734f2104ab77ecdaba2bb96baa929c":
        return PLUS.entity;
      case "44fb4bc69ff88e3e7113c597b0fa99cb":
        return CUSTOMIZED.entity;
      case "71af84e41a0e9783f4a21f4a5ea2bdd0":
        return FLAGSHIP.entity;
      case "6d89ea978f83243c3a137f3d25d9f10e":
        return STANDARD.entity;
      default:
        return null;
    }
  }

}
