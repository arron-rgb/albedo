/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.sys.domain.SysSms;
import com.albedo.java.modules.sys.domain.dto.SysSmsDto;

/**
 * 管理短信Service sys_sms
 * @author admin
 * @version 2020-08-12 15:46:27
 */
public interface SysSmsService extends DataService<SysSms, SysSmsDto, String>{

}