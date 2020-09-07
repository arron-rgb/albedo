/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.biz.domain.Dub;
import com.albedo.java.modules.biz.repository.DubRepository;
import com.albedo.java.modules.biz.service.DubService;

/**
 * 配音表单配置ServiceImpl 配音表单配置
 *
 * @author admin
 * @version 2020-09-07 18:24:16
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class DubServiceImpl extends BaseServiceImpl<DubRepository, Dub> implements DubService {

}
