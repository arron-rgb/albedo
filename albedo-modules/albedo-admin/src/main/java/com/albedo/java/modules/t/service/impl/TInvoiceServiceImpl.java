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
import com.albedo.java.modules.t.service.TInvoiceService;
import com.albedo.java.modules.t.domain.TInvoice;
import com.albedo.java.modules.t.domain.dto.TInvoiceDto;
import com.albedo.java.modules.t.repository.TInvoiceRepository;

/**
 * 管理发票抬头ServiceImpl t_invoice
 * @author admin
 * @version 2020-08-12 11:17:40
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TInvoiceServiceImpl extends DataServiceImpl<TInvoiceRepository, TInvoice, TInvoiceDto, String> implements TInvoiceService{
	@Override
	public void saveOrUpdate(TInvoiceDto tInvoiceDto) {
																		super.saveOrUpdate(tInvoiceDto);
	}

}