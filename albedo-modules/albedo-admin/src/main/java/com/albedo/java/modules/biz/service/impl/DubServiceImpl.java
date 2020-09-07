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
import com.albedo.java.modules.biz.service.DubService;
import com.albedo.java.modules.biz.domain.Dub;
import com.albedo.java.modules.biz.domain.dto.DubDto;
import com.albedo.java.modules.biz.repository.DubRepository;

/**
 * 配音表单配置ServiceImpl 配音表单配置
 * @author admin
 * @version 2020-09-07 18:24:16
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class DubServiceImpl extends DataServiceImpl<DubRepository, Dub, DubDto, String> implements DubService{
	@Override
	public void saveOrUpdate(DubDto dubDto) {
												super.saveOrUpdate(dubDto);
	}

}