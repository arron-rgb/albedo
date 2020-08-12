/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.*;

/**
 * 管理短信QueryCriteria sys_sms
 * @author admin
 * @version 2020-08-12 15:46:27
 */
@Data
public class SysSmsQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_PHONENUMBER phone_number  :  phone_number */
	@Query(propName = "phone_number")
	private Long phoneNumber;
	/** F_USERID user_id  :  开发票的userid */
	@Query(propName = "user_id")
	private String userId;
	/** F_TYPE type  :  类型？ */
	@Query()
	private String type;
	/** F_TEMPLATECODE template_code  :  模板代码？ */
	@Query(propName = "template_code")
	private String templateCode;
	/** F_TEMPLATEPARAM template_param  :  template_param */
	@Query(propName = "template_param")
	private String templateParam;

}