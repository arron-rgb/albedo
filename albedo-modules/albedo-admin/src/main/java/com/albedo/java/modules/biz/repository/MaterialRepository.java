package com.albedo.java.modules.biz.repository;

import org.apache.ibatis.annotations.Mapper;

import com.albedo.java.modules.biz.domain.VideoMaterial;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

@Mapper
public interface MaterialRepository extends BaseMapper<VideoMaterial> {

}
