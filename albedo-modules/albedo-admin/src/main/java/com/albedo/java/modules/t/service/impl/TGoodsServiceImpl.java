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
import com.albedo.java.modules.t.service.TGoodsService;
import com.albedo.java.modules.t.domain.TGoods;
import com.albedo.java.modules.t.domain.dto.TGoodsDto;
import com.albedo.java.modules.t.repository.TGoodsRepository;

/**
 * 商品管理ServiceImpl t_goods
 * @author admin
 * @version 2020-08-12 15:55:52
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TGoodsServiceImpl extends DataServiceImpl<TGoodsRepository, TGoods, TGoodsDto, String> implements TGoodsService{
	@Override
	public void saveOrUpdate(TGoodsDto tGoodsDto) {
																		super.saveOrUpdate(tGoodsDto);
	}

}