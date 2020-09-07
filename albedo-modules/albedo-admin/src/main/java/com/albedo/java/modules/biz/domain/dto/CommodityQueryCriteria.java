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
 * 商品管理QueryCriteria 商品管理
 * @author arronshentu
 * @version 2020-09-07 14:58:36
 */
@Data
public class CommodityQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_NAME name  :  名称 */
	@Query(operator = Query.Operator.like)
	private String name;

}