package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Video;

/**
 * @author arronshentu
 */
public interface VideoService extends BaseService<Video> {

  /**
   * 员工上传视频至OSS
   * 1. 往数据库中插入视频链接
   * 2. 在order中更新视频id
   * 3. 更新order状态
   *
   *
   */
  void uploadVideoToOss();

  /**
   * 验证用户oss存储空间是否已满
   *
   * @return 是否已满
   */
  boolean storageState();
}
