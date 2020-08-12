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
 * 视频管理QueryCriteria t_video
 * @author admin
 * @version 2020-08-12 15:59:38
 */
@Data
public class TVideoQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_NAME name  :  视频名字 */
	@Query(operator = Query.Operator.like)
	private String name;
	/** F_ORIGINURL origin_url  :  origin_url */
	@Query(propName = "origin_url")
	private String originUrl;

}