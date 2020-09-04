package com.albedo.java.modules.biz.service.impl;

import org.springframework.stereotype.Service;

import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.biz.domain.Config;
import com.albedo.java.modules.biz.repository.ConfigRepository;
import com.albedo.java.modules.biz.service.ConfigService;

/**
 * @author arronshentu
 */
@Service
public class ConfigServiceImpl extends BaseServiceImpl<ConfigRepository, Config> implements ConfigService {

}
