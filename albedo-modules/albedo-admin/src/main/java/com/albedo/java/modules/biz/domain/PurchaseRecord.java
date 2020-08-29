/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain;

import javax.validation.constraints.Size;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
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
  /** F_USERID user_id : 购买的用户id */
  public static final String F_USERID = "userId";
  /** F_OUTTRADENO out_trade_no : 对接支付宝id */
  public static final String F_OUT_TRADE_NO = "outTradeNo";
  /** F_TYPE type : 购买类型 */
  public static final String F_TYPE = "type";
  /** F_OUTERID outer_id : 购买id */
  public static final String F_OUTERID = "outerId";
  /** F_TOTALAMOUNT total_amount : 支付金额 */
  public static final String F_TOTALAMOUNT = "totalAmount";

  /** userId 购买的用户id */
  @Size(max = 64)
  @TableField("user_id")
  private String userId;
  /** outTradeNo 对接支付宝id */
  @Size(max = 64)
  @TableField("out_trade_no")
  private String outTradeNo;
  /** type 购买类型 0 套餐 1 订单 */
  @Size(max = 2)
  private String type;
  /** outerId 购买id */
  @Size(max = 500)
  @TableField("outer_id")
  private String outerId;
  /** totalAmount 支付金额 */
  @Size(max = 30)
  @TableField("total_amount")
  private String totalAmount;

}
