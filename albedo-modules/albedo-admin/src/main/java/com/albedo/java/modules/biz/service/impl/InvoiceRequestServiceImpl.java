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
import com.albedo.java.modules.biz.service.InvoiceRequestService;
import com.albedo.java.modules.biz.domain.InvoiceRequest;
import com.albedo.java.modules.biz.domain.dto.InvoiceRequestDto;
import com.albedo.java.modules.biz.repository.InvoiceRequestRepository;

/**
 * 管理ServiceImpl 开票请求
 * @author arronshentu
 * @version 2020-09-18 22:41:18
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class InvoiceRequestServiceImpl extends DataServiceImpl<InvoiceRequestRepository, InvoiceRequest, InvoiceRequestDto, String> implements InvoiceRequestService{
	@Override
	public void saveOrUpdate(InvoiceRequestDto invoiceRequestDto) {
													super.saveOrUpdate(invoiceRequestDto);
	}

}