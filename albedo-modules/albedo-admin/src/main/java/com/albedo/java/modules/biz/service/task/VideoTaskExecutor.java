package com.albedo.java.modules.biz.service.task;

import static com.albedo.java.common.core.constant.BusinessConstants.COMPLETED_SUCCESS;
import static com.albedo.java.common.core.constant.ExceptionNames.AUDIO_NOT_FOUND;
import static com.albedo.java.common.core.constant.ExceptionNames.VIDEO_NOT_FOUND;

import java.io.File;
import java.util.List;

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
import com.baomidou.mybatisplus.core.toolkit.Assert;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

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
    List<Video> videos = videoService.list(Wrappers.<Video>query().eq("order_id", video.getOrderId()));
    Assert.notEmpty(videos, VIDEO_NOT_FOUND);
    String audioUrl = video.getAudioUrl();
    Assert.notEmpty(audioUrl, AUDIO_NOT_FOUND);
    audioUrl = ossSingleton.urlToLocalPath(audioUrl);
    String outputUrl = ffmpegUtil.newConcatAudio(audioUrl, videos);
    event.setStatus("end");
    // 更新video表
    File file = new File(outputUrl);
    String userId = video.getUserId();
    userId = userService.getBucketName(userId);
    // 上传视频
    ossSingleton.uploadFile(file, file.getName(), userId);
    video.setOutputUrl(file.getAbsolutePath());
    videoService.updateById(video);
    // 更新订单状态
    String orderId = video.getOrderId();
    Order order = orderService.getById(orderId);
    order.setState(COMPLETED_SUCCESS);
    orderService.updateById(order);
    ffmpegUtil.deleteFile(audioUrl);
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

  @Async
  @EventListener(Signal.class)
  public void signal(Signal signal) {
    videoService.addAudio(signal.getVideoId());
  }
}
