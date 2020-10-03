/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain;

import lombok.*;
import com.baomidou.mybatisplus.annotation.*;
import com.albedo.java.common.persistence.domain.IdEntity;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import com.albedo.java.common.core.annotation.DictType;


import javax.validation.constraints.*;

/**
 * 开票请求管理Entity 开票请求
 * @author admin
 * @version 2020-10-03 16:15:33
 */
@TableName(value = "t_invoice_request")
@Data @ToString @NoArgsConstructor @AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class TInvoiceRequest extends IdEntity<TInvoiceRequest> {

	private static final long serialVersionUID = 1L;
	/** F_TOTALAMOUNT total_amount  :  开票金额 */
	public static final String F_TOTALAMOUNT = "totalAmount";
	/** F_RECORDIDS record_ids  :  开票记录id */
	public static final String F_RECORDIDS = "recordIds";
	/** F_INVOICEID invoice_id  :  抬头id */
	public static final String F_INVOICEID = "invoiceId";
	/** F_TYPE type  :  0未开 1已开 */
	public static final String F_TYPE = "type";


	/** totalAmount 开票金额 */@NotNull 
	@TableField("total_amount")
	private Double totalAmount;
	/** recordIds 开票记录id */@NotBlank @Size(max=65535)
	@TableField("record_ids")
	private String recordIds;
	/** invoiceId 抬头id */@NotBlank @Size(max=32)
	@TableField("invoice_id")
	private String invoiceId;
	/** type 0未开 1已开 */@NotBlank @Size(max=1)
	
	private String type;

}
