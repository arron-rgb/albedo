package com.albedo.java.modules.tool.domain.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author arronshentu
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TradeQueryPlus {
  /**
   * 订单支付时传入的商户订单号,和支付宝交易号不能同时为空。
   * trade_no,out_trade_no如果同时存在优先取trade_no
   */
  String outTradeNo;
  /**
   * 支付宝交易号，和商户订单号不能同时为空
   */
  String tradeNo;

  /**
   * 查询选项，商户通过上送该参数来定制同步需要额外返回的信息字段，数组格式。如：
   * ["trade_settle_info","fund_bill_list","voucher_detail_list","discount_goods_detail"]
   */
  List<String> queryOptions = new ArrayList<>(2);
}
