package com.albedo.java.modules.biz.service.task;

import java.io.File;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;

import com.albedo.java.modules.biz.util.FfmpegUtil;
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
    log.info("开始合成音频");
    ffmpegUtil.concatAudio(event.video);
    event.setStatus("end");
    log.info("结束");
  }

  @Resource
  OssSingleton ossSingleton;
  @Resource
  FfmpegUtil ffmpegUtil;
}
