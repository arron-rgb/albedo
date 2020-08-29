package com.albedo.java.common.core.constant;

/**
 * @author arronshentu
 */
public interface BusinessConstants {

  String PERSONAL_TYPE = "1";
  String ENTERPRISE_TYPE = "2";

  // 支付宝支付状态
  /**
   * 交易创建，等待买家付款
   */
  String WAIT_BUYER_PAY = "WAIT_BUYER_PAY";
  /**
   * 在指定时间段内未支付时关闭的交易或在交易完成全额退款成功时关闭的交易
   */
  String TRADE_CLOSED = "TRADE_CLOSED";
  /**
   * 商户签约的产品支持退款功能的前提下，买家付款成功
   */
  String TRADE_SUCCESS = "TRADE_SUCCESS";
  /**
   * 商户签约的产品不支持退款功能的前提下，买家付款成功；或者，商户签约的产品支持退款功能 的前提下，交易已经成功并且已经超过可退款期限。
   */
  String TRADE_FINISHED = "TRADE_FINISHED";

  // 订单状态
  /**
   * 创建未付款
   */
  Integer ORDER_STATE_0 = 0;
  /**
   * 付款未制作
   */
  Integer ORDER_STATE_1 = 1;
  /**
   * 员工接单，制作中
   */
  Integer ORDER_STATE_2 = 2;
  /**
   * 视频已上传
   */
  Integer ORDER_STATE_3 = 3;
  /**
   * 商品、logo、贴片
   */
  Integer ORDER_STATE_4 = 4;
  /**
   * 结单
   */
  Integer ORDER_STATE_5 = 5;

}
