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
 * 开票请求管理Dto 开票请求
 * @author admin
 * @version 2020-10-03 16:15:33
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class TInvoiceRequestDto extends DataDto<String> {

	private static final long serialVersionUID = 1L;
	/** F_TOTALAMOUNT total_amount  :  开票金额 */
	public static final String F_TOTALAMOUNT = "totalAmount";
	/** F_RECORDIDS record_ids  :  开票记录id */
	public static final String F_RECORDIDS = "recordIds";
	/** F_INVOICEID invoice_id  :  抬头id */
	public static final String F_INVOICEID = "invoiceId";
	/** F_TYPE type  :  0未开 1已开 */
	public static final String F_TYPE = "type";


	/** totalAmount 开票金额 */
 @NotNull 
	private Double totalAmount;
	/** recordIds 开票记录id */
 @NotBlank @Size(max=65535)
	private String recordIds;
	/** invoiceId 抬头id */
 @NotBlank @Size(max=32)
	private String invoiceId;
	/** type 0未开 1已开 */
 @NotBlank @Size(max=1)
	private String type;


}
