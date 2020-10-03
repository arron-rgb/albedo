/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.*;

/**
 * 开票请求管理QueryCriteria 开票请求
 * @author admin
 * @version 2020-10-03 16:15:33
 */
@Data
public class TInvoiceRequestQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_CREATEDDATE created_date  :  created_date */
	@Query(propName = "created_date")
	private List<Date> createdDate;
	/** F_CREATEDBY created_by  :  created_by */
	@Query(propName = "created_by")
	private String createdBy;
	/** F_TOTALAMOUNT total_amount  :  开票金额 */
	@Query(propName = "total_amount")
	private Double totalAmount;
	/** F_RECORDIDS record_ids  :  开票记录id */
	@Query(propName = "record_ids")
	private String recordIds;
	/** F_TYPE type  :  0未开 1已开 */
	@Query()
	private String type;

}