package com.albedo.java.modules.biz.domain;

import javax.validation.constraints.Size;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * 购买记录Entity PurchaseRecord
 *
 * @author arronshentu
 * @version 2020-08-29 23:58:02
 */
@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName(value = "t_purchase_record")
public class PurchaseRecord extends IdEntity<PurchaseRecord> {

  private static final long serialVersionUID = 1L;
  public static final String F_OUT_TRADE_NO = "out_trade_no";

  /**
   * userId 购买的用户id
   */
  @Size(max = 64)
  private String userId;
  /**
   * outTradeNo 对接支付宝id
   */
  @Size(max = 64)
  private String outTradeNo;
  /**
   * type 购买类型 0 套餐 1 订单
   */
  @Size(max = 2)
  private String type;
  /**
   * outerId 购买的套餐/订单id
   */
  @Size(max = 500)
  private String outerId;
  /**
   * totalAmount 支付金额
   */
  @Size(max = 30)
  private String totalAmount;
  /**
   * 商户号
   */
  private String sellerId;
  /**
   * 消费状态 对齐支付宝字段
   */
  private String status;

  // @ApiField("merchant_order_no")
  // private String merchantOrderNo;
  // @ApiField("trade_no")
  // private String tradeNo;
}
