/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.t.domain.TInvoiceHistory;
import com.albedo.java.modules.t.domain.dto.TInvoiceHistoryDto;

/**
 * 查看发票申请历史Service t_invoice_history
 * @author admin
 * @version 2020-08-12 11:02:01
 */
public interface TInvoiceHistoryService extends DataService<TInvoiceHistory, TInvoiceHistoryDto, String>{

}