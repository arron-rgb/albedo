/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.domain.OrderForm;
import com.albedo.java.modules.biz.domain.dto.OrderFormDto;
import com.albedo.java.modules.biz.repository.OrderFormRepository;
import com.albedo.java.modules.biz.service.OrderFormService;

/**
 * 表单ServiceImpl OrderForm
 *
 * @author admin
 * @version 2020-08-18 10:19:40
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class OrderFormServiceImpl extends DataServiceImpl<OrderFormRepository, OrderForm, OrderFormDto, String>
  implements OrderFormService {
  @Override
  public void saveOrUpdate(OrderFormDto orderFormDto) {
    super.saveOrUpdate(orderFormDto);
  }

}
