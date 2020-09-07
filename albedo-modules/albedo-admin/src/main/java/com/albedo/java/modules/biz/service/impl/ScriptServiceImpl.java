package com.albedo.java.modules.biz.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.biz.domain.Script;
import com.albedo.java.modules.biz.repository.ScriptRepository;
import com.albedo.java.modules.biz.service.ScriptService;

/**
 * @author arronshentu
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ScriptServiceImpl extends BaseServiceImpl<ScriptRepository, Script> implements ScriptService {

}
