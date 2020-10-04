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
 * 联系单QueryCriteria 联系单
 * @author arronshentu
 * @version 2020-09-02 13:51:29
 */
@Data
public class ContactInfoQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_COMPANYNAME company_name  :  企业名称 */
	@Query(propName = "company_name", operator = Query.Operator.like)
	private String companyName;
	/** F_NAME name  :  姓名 */
	@Query(operator = Query.Operator.like)
	private String name;

	@Query(operator = Query.Operator.like)
	private String phone;

}
