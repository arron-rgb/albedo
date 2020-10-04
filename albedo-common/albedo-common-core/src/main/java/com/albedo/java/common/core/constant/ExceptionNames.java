package com.albedo.java.common.core.constant;

/**
 * @author arronshentu
 */
public interface ExceptionNames {
  String PRICE_FIELD_NOT_FOUND = "价格字段缺失";

  String ORDER_ERROR = "订单状态异常";

  String ORDER_NOT_FOUND = "未查询到订单信息";

  String PRICE_ERROR = "订单价格异常";

  String PRICE_NOT_FOUND = "系统中未查询到价格信息";

  String ORDER_PARSE_ERROR = "订单格式错误，价格计算失败";

  String CONSUME_NOT_PERMITTED = "非后台员工无法认领订单";
  String VIEW_NOT_PERMITTED = "非后台员工无法查看订单内容";

  String ORDER_VIDEO_NOT_FOUNT = "未查询到订单相关的视频信息";

  String VIDEO_NOT_FOUND = "未查询到视频信息";
  String VIDEO_DATA_NOT_FOUND = "未查询到视频源数据信息";
  String PURCHASE_RECORD_NOT_FOUND = "未查询到购买记录";
  String AUDIO_NOT_FOUND = "未查询到音频信息";

  String ALIPAY_ERROR = "调用支付链接时发生错误";

  String EMPTY_STORAGE = "该账号下无任何存储空间";

  String STORAGE_NOT_SATISFIED = "该账号下存储空间不足以容纳该视频";

  String BALANCE_NOT_FOUND = "当前用户或企业未购买任何套餐";

  String TIMES_OVERSPEND = "当前用户未购买任何套餐或次数已耗尽";

  // String BALANCE_NOT_FOUND = "未查询到任何套餐信息";
  String ENTERPRISE_ADMIN_NOT_FOUND = "未查询到当前用户企业的管理员";

  String ANCHOR_NUM_ERROR = "主播数量异常";

  String PAY_METHOD_ERROR = "支付方式异常";
  String WECHAT_PAY_ERROR = "暂不支持微信支付";

  String INVALID_COUPON = "优惠码无效";
  String CURRENT_ORDER_EXIST = "当前仍有订单未完成，无法创建新订单";
}
