/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service.impl;

import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.service.TInvoiceRequestService;
import com.albedo.java.modules.biz.domain.TInvoiceRequest;
import com.albedo.java.modules.biz.domain.dto.TInvoiceRequestDto;
import com.albedo.java.modules.biz.repository.TInvoiceRequestRepository;

/**
 * 开票请求管理ServiceImpl 开票请求
 * @author admin
 * @version 2020-10-03 16:15:33
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TInvoiceRequestServiceImpl extends DataServiceImpl<TInvoiceRequestRepository, TInvoiceRequest, TInvoiceRequestDto, String> implements TInvoiceRequestService{
	@Override
	public void saveOrUpdate(TInvoiceRequestDto tInvoiceRequestDto) {
														super.saveOrUpdate(tInvoiceRequestDto);
	}

}