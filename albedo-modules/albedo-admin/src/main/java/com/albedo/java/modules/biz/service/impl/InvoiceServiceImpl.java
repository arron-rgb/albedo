/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.domain.Invoice;
import com.albedo.java.modules.biz.domain.dto.InvoiceDto;
import com.albedo.java.modules.biz.repository.InvoiceRepository;
import com.albedo.java.modules.biz.service.InvoiceService;

/**
 * 发票抬头管理ServiceImpl 发票抬头
 *
 * @author arronshentu
 * @version 2020-08-16 16:19:02
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class InvoiceServiceImpl extends DataServiceImpl<InvoiceRepository, Invoice, InvoiceDto, String>
  implements InvoiceService {

  @Override
  public void saveOrUpdate(InvoiceDto invoiceDto) {
    super.saveOrUpdate(invoiceDto);
  }

}
