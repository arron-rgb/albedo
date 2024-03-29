package com.albedo.java.common.core.constant;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author arronshentu
 */
public interface BusinessConstants {

  List<String> ADMIN_IDS = new ArrayList<>(Arrays.asList("3570f348af7214a976e5d6bfbdd97df1", "1", "2"));

  String DOUBLE_ANCHOR = "双人主播";
  String SINGLE_ANCHOR = "单人主播";
  String ACCELERATE_STR = "加速服务";

  /**
   * 用户满意
   */
  String SATISFIED = "1";

  /**
   * 用户不满意
   */
  String DISSATISFIED = "0";

  Integer UPLOAD_AUDIO = 0;

  String PLUS_SERVICE = "1";

  String ALIBABA_ID = "ALIBABA_ID";
  String ALIBABA_SECRET = "ALIBABA_SECRET";
  String TENCENT_ID = "TENCENT_ID";
  String TENCENT_SECRET = "TENCENT_SECRET";

  Integer ADD = 1;
  Integer DEL = 0;

  /**
   * 订单类型 加速单
   */
  String ACCELERATE = "1";
  /**
   * 订单类型 普通单
   * 普通用户可见配置
   */
  String COMMON = "0";
  /**
   * 订单类型 配音单
   */
  String DUBBING = "2";

  /**
   * 支付类型 订单 配音
   */
  String DUBBING_TYPE = "2";
  /**
   * 支付类型 订单 视频
   */
  String ORDER_TYPE = "1";
  /**
   * 支付类型 套餐
   */
  String PLAN_TYPE = "0";

  String PERSONAL_TYPE = "1";
  String ENTERPRISE_TYPE = "2";

  // 订单状态
  /**
   * 创建未付款
   */
  Integer UNPAID_ORDER = 0;
  /**
   * 付款未制作
   */
  Integer NOT_STARTED = 1;
  /**
   * 员工接单，制作中
   */
  Integer IN_PRODUCTION = 2;
  /**
   * 视频已上传
   */
  Integer PRODUCTION_COMPLETED = 3;
  /**
   * 商品、logo、贴片
   */
  Integer NOT_UPDATED = 4;
  /**
   * 有效期内
   */
  Integer VALID = 5;
  /**
   * 结单
   */
  Integer FINISHED = 6;
  /**
   * 支付超时关闭订单
   */
  Integer COMPLETED_BY_CLOSE = 6;

  /**
   * 个人用户
   */
  String PERSONAL_USER_ROLE_ID = "904a870be22c6b84845dbd1699655b4a";
  /**
   * 企业普通用户
   */
  String BUSINESS_COMMON_ROLE_ID = "49dbe45a4e2a06a56730851e0c87f166";
  /**
   * 企业管理员
   */
  String BUSINESS_ADMIN_ROLE_ID = "cdff3f167ae3dfc7984cd6e36976ddf8";
  /**
   * 个人用户所属部门
   */
  String PUBLIC_DEPT_ID = "4d20ae207d9c836a732480429af58273";

  /**
   * 消耗表的type 订单次数、子账号数量、存储空间
   */
  Integer ORDER_TIMES = 0;
  Integer CHILD_ACCOUNT = 1;
  Integer STORAGE = 2;

  // 支付宝相关
  /**
   * 支付宝常量字段
   */
  String PRODUCT_CODE = "FAST_INSTANT_TRADE_PAY";
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
}
