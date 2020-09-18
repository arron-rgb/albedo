/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.biz.domain.InvoiceRequest;
import com.albedo.java.modules.biz.domain.dto.InvoiceRequestDto;

/**
 * 管理Service 开票请求
 * @author arronshentu
 * @version 2020-09-18 22:41:18
 */
public interface InvoiceRequestService extends DataService<InvoiceRequest, InvoiceRequestDto, String>{

}