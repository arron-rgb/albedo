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
import com.albedo.java.modules.biz.service.ContactInfoService;
import com.albedo.java.modules.biz.domain.ContactInfo;
import com.albedo.java.modules.biz.domain.dto.ContactInfoDto;
import com.albedo.java.modules.biz.repository.ContactInfoRepository;

/**
 * 联系单ServiceImpl 联系单
 * @author arronshentu
 * @version 2020-09-02 13:51:29
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ContactInfoServiceImpl extends DataServiceImpl<ContactInfoRepository, ContactInfo, ContactInfoDto, String> implements ContactInfoService{
	@Override
	public void saveOrUpdate(ContactInfoDto contactInfoDto) {
														super.saveOrUpdate(contactInfoDto);
	}

}