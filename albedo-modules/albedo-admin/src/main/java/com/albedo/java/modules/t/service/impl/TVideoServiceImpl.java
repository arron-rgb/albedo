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
import com.albedo.java.modules.t.service.TVideoService;
import com.albedo.java.modules.t.domain.TVideo;
import com.albedo.java.modules.t.domain.dto.TVideoDto;
import com.albedo.java.modules.t.repository.TVideoRepository;

/**
 * 视频管理ServiceImpl t_video
 * @author admin
 * @version 2020-08-12 15:59:38
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class TVideoServiceImpl extends DataServiceImpl<TVideoRepository, TVideo, TVideoDto, String> implements TVideoService{
	@Override
	public void saveOrUpdate(TVideoDto tVideoDto) {
																super.saveOrUpdate(tVideoDto);
	}

}