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
 * 管理发票抬头QueryCriteria t_invoice
 * @author admin
 * @version 2020-08-12 11:17:40
 */
@Data
public class TInvoiceQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	@Query(propName = "user_id")
	private String userId;
	/** F_TYPE type  :  0-个人，1-企业 */
	@Query()
	private String type;
	/** F_NAME name  :  企业名称/个人名称 */
	@Query(operator = Query.Operator.like)
	private String name;
	/** F_TAXNUM tax_num  :  公司税号 */
	@Query(propName = "tax_num")
	private String taxNum;
	/** F_COMPANYLOCATION company_location  :  注册地址 */
	@Query(propName = "company_location")
	private String companyLocation;
	/** F_COMPANYPHONE company_phone  :  公司电话 */
	@Query(propName = "company_phone")
	private String companyPhone;
	/** F_ACCOUNTBANK account_bank  :  开户公司 */
	@Query(propName = "account_bank")
	private String accountBank;

}