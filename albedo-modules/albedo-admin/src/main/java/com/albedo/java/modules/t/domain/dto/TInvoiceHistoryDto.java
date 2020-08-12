/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.domain.dto;

import com.albedo.java.common.core.vo.DataDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 查看发票申请历史Dto t_invoice_history
 * @author admin
 * @version 2020-08-12 11:02:01
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class TInvoiceHistoryDto extends DataDto<String> {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	public static final String F_USERID = "userId";
	/** F_INVOICEID invoice_id  :  发票id(数量统计用后台加一下就好) */
	public static final String F_INVOICEID = "invoiceId";


	/** userId 用户id */
 @NotBlank @Size(max=32)
	private String userId;
	/** invoiceId 发票id(数量统计用后台加一下就好) */
 @Size(max=32)
	private String invoiceId;


}
