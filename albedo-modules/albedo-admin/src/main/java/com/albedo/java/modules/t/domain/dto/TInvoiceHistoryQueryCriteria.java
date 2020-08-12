/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.*;

/**
 * 查看发票申请历史QueryCriteria t_invoice_history
 * @author admin
 * @version 2020-08-12 11:02:01
 */
@Data
public class TInvoiceHistoryQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	@Query(propName = "user_id")
	private String userId;
	/** F_INVOICEID invoice_id  :  发票id(数量统计用后台加一下就好) */
	@Query(propName = "invoice_id")
	private String invoiceId;

}