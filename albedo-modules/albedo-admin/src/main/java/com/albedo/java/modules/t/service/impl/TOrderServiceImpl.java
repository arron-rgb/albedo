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
import com.albedo.java.modules.t.service.TOrderService;
import com.albedo.java.modules.t.domain.TOrder;
import com.albedo.java.modules.t.domain.dto.TOrderDto;
import com.albedo.java.modules.t.repository.TOrderRepository;

/**
 * 订单管理ServiceImpl t_order
 * @author admin
 * @version 2020-08-12 15:36:12
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TOrderServiceImpl extends DataServiceImpl<TOrderRepository, TOrder, TOrderDto, String> implements TOrderService{
	@Override
	public void saveOrUpdate(TOrderDto tOrderDto) {
																		super.saveOrUpdate(tOrderDto);
	}

}