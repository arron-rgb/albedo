/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.biz.domain.Invoice;
import com.albedo.java.modules.biz.domain.dto.InvoiceDto;

/**
 * 发票抬头管理Service 发票抬头
 * @author arronshentu
 * @version 2020-08-16 16:19:02
 */
public interface InvoiceService extends DataService<Invoice, InvoiceDto, String>{

}