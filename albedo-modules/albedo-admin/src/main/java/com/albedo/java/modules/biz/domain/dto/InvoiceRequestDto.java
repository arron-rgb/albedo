/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain.dto;

import com.albedo.java.common.core.vo.DataDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 管理Dto 开票请求
 * @author arronshentu
 * @version 2020-09-18 22:41:18
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class InvoiceRequestDto extends DataDto<String> {

	private static final long serialVersionUID = 1L;
	/** F_INVOICEID invoice_id  :  抬头 */
	public static final String F_INVOICEID = "invoiceId";
	/** F_RECORDIDS record_ids  :  开票的订单 */
	public static final String F_RECORDIDS = "recordIds";
	/** F_TOTALAMOUNT total_amount  :  开票金额 */
	public static final String F_TOTALAMOUNT = "totalAmount";


	/** invoiceId 抬头 */
 @Size(max=32)
	private String invoiceId;
	/** recordIds 开票的订单 */
 @Size(max=65535)
	private String recordIds;
	/** totalAmount 开票金额 */
 @NotNull 
	private Double totalAmount;


}
