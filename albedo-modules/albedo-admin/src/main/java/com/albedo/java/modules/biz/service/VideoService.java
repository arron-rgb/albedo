package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.VideoMaterial;

import java.io.IOException;
import java.util.List;

/**
 * @author arronshentu
 */
public interface VideoService extends BaseService<Video> {

  /**
   * 工作人员上传视频
   *
   * @param orderId  订单id
   * @param tempPath 本地文件路径
   * @throws IOException IO异常
   */
  void uploadVideo(String orderId, String tempPath) throws IOException;

  /**
   * 给某条video添加配音处理
   *
   * @param videoId 视频id
   */
  void addAudio(String videoId);

  Video getOneByOrderId(String orderId);

  List<VideoMaterial> getMaterials(String orderId);

  void removeOldestVideo(String userId);
}
