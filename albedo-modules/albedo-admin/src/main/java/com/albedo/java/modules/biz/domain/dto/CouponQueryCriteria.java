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
 * 增删改查QueryCriteria 优惠券
 * @author admin
 * @version 2020-10-04 08:44:10
 */
@Data
public class CouponQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_CODE code  :  优惠码编号 */
	@Query(operator = Query.Operator.like)
	private String code;
	/** F_STATUS status  :  使用状态 */
	@Query()
	private String status;

}