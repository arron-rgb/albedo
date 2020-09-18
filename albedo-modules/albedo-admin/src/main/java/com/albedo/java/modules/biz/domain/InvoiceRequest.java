/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain;

import java.math.BigDecimal;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * 管理Entity 开票请求
 *
 * @author arronshentu
 * @version 2020-09-18 22:41:18
 */
@TableName(value = "t_invoice_request")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class InvoiceRequest extends IdEntity<InvoiceRequest> {

  private static final long serialVersionUID = 1L;
  /** F_INVOICEID invoice_id : 抬头 */
  public static final String F_INVOICEID = "invoiceId";
  /** F_RECORDIDS record_ids : 开票的订单 */
  public static final String F_RECORDIDS = "recordIds";
  /** F_TOTALAMOUNT total_amount : 开票金额 */
  public static final String F_TOTALAMOUNT = "totalAmount";

  /** invoiceId 抬头 */
  @Size(max = 32)
  @TableField("invoice_id")
  private String invoiceId;
  /** recordIds 开票的订单 */
  @Size(max = 65535)
  @TableField("record_ids")
  private String recordIds;
  /** totalAmount 开票金额 */
  @NotNull
  @TableField("total_amount")
  private BigDecimal totalAmount;
  /**
   * 0未开 1已开
   */
  private Integer type;

}
