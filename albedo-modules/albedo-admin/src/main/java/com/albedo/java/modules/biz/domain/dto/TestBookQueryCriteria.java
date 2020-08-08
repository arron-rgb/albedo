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
 * testQueryCriteria test
 * @author admin
 * @version 2020-08-08 21:20:40
 */
@Data
public class TestBookQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_TITLE title_  :  标题 */
	@Query(propName = "title_", operator = Query.Operator.like)
	private String title;
	/** F_NAME name  :  名称 */
	@Query(operator = Query.Operator.like)
	private String name;

}