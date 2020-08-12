/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.service.impl;

import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.t.service.TInvoiceHistoryService;
import com.albedo.java.modules.t.domain.TInvoiceHistory;
import com.albedo.java.modules.t.domain.dto.TInvoiceHistoryDto;
import com.albedo.java.modules.t.repository.TInvoiceHistoryRepository;

/**
 * 查看发票申请历史ServiceImpl t_invoice_history
 * @author admin
 * @version 2020-08-12 11:02:01
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TInvoiceHistoryServiceImpl extends DataServiceImpl<TInvoiceHistoryRepository, TInvoiceHistory, TInvoiceHistoryDto, String> implements TInvoiceHistoryService{
	@Override
	public void saveOrUpdate(TInvoiceHistoryDto tInvoiceHistoryDto) {
												super.saveOrUpdate(tInvoiceHistoryDto);
	}

}