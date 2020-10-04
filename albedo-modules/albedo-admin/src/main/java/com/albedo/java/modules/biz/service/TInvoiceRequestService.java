/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.biz.domain.TInvoiceRequest;
import com.albedo.java.modules.biz.domain.dto.TInvoiceRequestDto;

/**
 * 开票请求管理Service 开票请求
 * @author admin
 * @version 2020-10-03 16:15:33
 */
public interface TInvoiceRequestService extends DataService<TInvoiceRequest, TInvoiceRequestDto, String>{

}