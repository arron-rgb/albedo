package com.albedo.java.modules.biz.service.task;

import static com.albedo.java.common.core.constant.BusinessConstants.COMPLETED_SUCCESS;

import java.io.File;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;

import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.biz.util.FfmpegUtil;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;

import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Slf4j
public class VideoTaskExecutor {
  public VideoTaskExecutor() {}

  /**
   * @param event
   *          含有video的信息
   */
  @Async
  @EventListener(VideoUploadTask.class)
  public void uploadVideoToOss(VideoUploadTask event) {
    String videoPath = event.video.getOriginUrl();
    File file = new File(videoPath);
    if (!file.exists() || file.isDirectory()) {
      return;
    }
    ossSingleton.uploadFile(file, event.getBucketName());
  }

  /**
   * 将音频与视频合成
   * 合成完毕后 1. 将视频上传至oss 2. 更新video表字段 3. 更新订单表字段
   *
   * @param event
   *          含有video的信息
   */
  @Async
  @EventListener(VideoEncodeTask.class)
  public void concatAudio(VideoEncodeTask event) {
    Video video = event.video;
    String outputUrl = ffmpegUtil.concatAudio(video);
    event.setStatus("end");
    // 更新video表
    File file = new File(outputUrl);
    String userId = video.getUserId();
    userId = userService.getBucketName(userId);
    ossSingleton.uploadFile(file, file.getName(), userId);
    video.setOutputUrl(ossSingleton.getFileUrl());
    videoService.updateById(video);
    // 更新订单状态
    String orderId = event.getOrderId();
    Order order = orderService.getById(orderId);
    order.setState(COMPLETED_SUCCESS);
    orderService.updateById(order);

  }

  @Resource
  OrderService orderService;
  @Resource
  VideoService videoService;
  @Resource
  UserService userService;
  @Resource
  OssSingleton ossSingleton;
  @Resource
  FfmpegUtil ffmpegUtil;
}
