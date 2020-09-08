package com.albedo.java.modules.biz.domain.dto;

import javax.validation.constraints.Size;

import com.albedo.java.common.core.vo.DataDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 购买记录Dto PurchaseRecord
 *
 * @author admin
 * @version 2020-08-29 23:58:02
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseRecordDto extends DataDto<String> {

  private static final long serialVersionUID = 1L;
  /** F_USERID user_id : 购买的用户id */
  public static final String F_USERID = "userId";
  /** F_OUTTRADENO out_trade_no : 对接支付宝id */
  public static final String F_OUTTRADENO = "outTradeNo";
  /** F_TYPE type : 购买类型 */
  public static final String F_TYPE = "type";
  /** F_OUTERID outer_id : 购买id */
  public static final String F_OUTERID = "outerId";
  /** F_TOTALAMOUNT total_amount : 支付金额 */
  public static final String F_TOTALAMOUNT = "totalAmount";

  /** userId 购买的用户id */
  @Size(max = 64)
  private String userId;
  /** outTradeNo 对接支付宝id */
  @Size(max = 64)
  private String outTradeNo;
  /** type 购买类型 */
  @Size(max = 2)
  private String type;
  /** outerId 购买id */
  @Size(max = 500)
  private String outerId;
  /** totalAmount 支付金额 */
  @Size(max = 30)
  private String totalAmount;

}
