package com.albedo.java.modules.biz.service;

import java.io.InputStream;

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
   * @return 满 true
   */
  boolean storageState();

  /**
   * 创bucket
   *
   * @param userId
   *          用户
   */
  void createBucket(String userId);

  /**
   * 工作人员上传视频
   *
   * @param orderId
   *          订单id
   * @param inputStream
   *          流
   */
  void uploadVideo(String orderId, InputStream inputStream);
}
