/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.t.domain.TInvoice;
import com.albedo.java.modules.t.domain.dto.TInvoiceDto;

/**
 * 管理发票抬头Service t_invoice
 * @author admin
 * @version 2020-08-12 11:17:40
 */
public interface TInvoiceService extends DataService<TInvoice, TInvoiceDto, String>{

}