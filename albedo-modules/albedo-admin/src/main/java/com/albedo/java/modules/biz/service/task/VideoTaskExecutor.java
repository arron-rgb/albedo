package com.albedo.java.modules.biz.service.task;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.scheduling.annotation.Async;

import com.albedo.java.modules.biz.util.FfmpegUtil;
import com.albedo.java.modules.tool.util.OssSingleton;

import lombok.extern.slf4j.Slf4j;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFprobe;

/**
 * @author arronshentu
 */
@Slf4j
public class VideoTaskExecutor {

  static FFprobe ffprobe;
  static FFmpeg ffmpeg;

  static {
    try {
      ffprobe = new FFprobe("/usr/local/bin/ffprobe");
      ffmpeg = new FFmpeg("/usr/local/bin/ffmpeg");
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  /**
   * @param event
   *          含有video的信息
   */
  @Async
  @Order
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
   *
   * @param event
   *          含有video的信息
   * @throws IOException
   */
  @Async
  @Order
  @EventListener(VideoEncodeTask.class)
  public void concatAudio(VideoEncodeTask event) throws IOException {
    ffmpegUtil.concatAudio(event.video);
    event.setStatus("end");
  }

  @Resource
  OssSingleton ossSingleton;
  @Resource
  FfmpegUtil ffmpegUtil;
}
