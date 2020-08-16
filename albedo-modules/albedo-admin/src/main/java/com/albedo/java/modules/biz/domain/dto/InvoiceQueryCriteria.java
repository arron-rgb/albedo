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
 * 发票抬头管理QueryCriteria 发票抬头
 * @author arronshentu
 * @version 2020-08-16 16:19:02
 */
@Data
public class InvoiceQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_NAME name  :  企业名称/个人名称 */
	@Query(operator = Query.Operator.like)
	private String name;

}