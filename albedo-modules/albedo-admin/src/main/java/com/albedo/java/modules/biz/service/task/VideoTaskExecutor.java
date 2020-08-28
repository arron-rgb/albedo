package com.albedo.java.modules.biz.service.task;

import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.scheduling.annotation.Async;

/**
 * @author arronshentu
 */
public class VideoTaskExecutor {

  @Async
  @Order
  @EventListener(VideoTask.class)
  public void uploadVideoToOss(VideoTask event) {
    String filePath = event.getFilePath();
    // OssSingleton.uploadFileStream();
  }
}
