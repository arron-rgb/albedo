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
import com.albedo.java.modules.t.service.TFrontService;
import com.albedo.java.modules.t.domain.TFront;
import com.albedo.java.modules.t.domain.dto.TFrontDto;
import com.albedo.java.modules.t.repository.TFrontRepository;

/**
 * 控制前端页面内容ServiceImpl t_front
 * @author admin
 * @version 2020-08-12 10:47:45
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TFrontServiceImpl extends DataServiceImpl<TFrontRepository, TFront, TFrontDto, String> implements TFrontService{
	@Override
	public void saveOrUpdate(TFrontDto tFrontDto) {
													super.saveOrUpdate(tFrontDto);
	}

}