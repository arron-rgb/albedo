package com.albedo.java.modules.biz.service;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Video;

/**
 * @author arronshentu
 */
public interface VideoService extends BaseService<Video> {

  /**
   * 验证用户oss存储空间是否已满
   *
   * @return 满 true
   */
  boolean storageState(Double byteSize, String userId);

  /**
   * 工作人员上传视频
   *
   * @param orderId
   *          订单id
   * @param file
   *          流
   * @exception IOException
   *              IO异常
   */
  void uploadVideo(String orderId, MultipartFile file) throws IOException;

  /**
   * 给某条video添加配音处理
   *
   * @param videoId
   *          视频id
   */
  void addAudio(String videoId);

}
