package com.albedo.java.modules.biz.service.impl;

import org.springframework.stereotype.Service;

import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.biz.domain.Advice;
import com.albedo.java.modules.biz.repository.AdviceRepository;
import com.albedo.java.modules.biz.service.AdviceService;

/**
 * @author arronshentu
 */
@Service
public class AdviceServiceImpl extends BaseServiceImpl<AdviceRepository, Advice> implements AdviceService {

}
