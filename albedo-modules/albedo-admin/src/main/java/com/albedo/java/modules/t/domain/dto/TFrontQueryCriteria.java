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
 * 控制前端页面内容QueryCriteria t_front
 * @author admin
 * @version 2020-08-12 10:47:45
 */
@Data
public class TFrontQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_NAME name  :  前端页面名字 */
	@Query(operator = Query.Operator.like)
	private String name;

}