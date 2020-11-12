package com.albedo.java.common.core.constant.enums;

public enum OrderStatus {
  /**
   *
   */
  UNPAID_ORDER("未付款", "0"),
  /**
  *
  */
  NOT_STARTED("已付款", "1"),
  /**
   *
   */
  IN_PRODUCTION("已接单", "2"),
  /**
   *
   */
  PRODUCTION_COMPLETED("已制作", "3"),
  /**
   *
   */
  NOT_UPDATED("等待用户更新订单", "4"),
  /**
   *
   */
  VALID("可配音", "5"),
  /**
   *
   */
  FINISHED("结单", "6");

  OrderStatus(String cn, String code) {
    this.cn = cn;
    this.code = code;
  }

  private String cn;
  private String code;

  public String getCn() {
    return cn;
  }

  public void setCn(String cn) {
    this.cn = cn;
  }

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

}
