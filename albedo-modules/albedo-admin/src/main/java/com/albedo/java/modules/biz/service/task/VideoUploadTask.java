package com.albedo.java.modules.biz.service.task;

import org.springframework.context.ApplicationEvent;

import com.albedo.java.modules.biz.domain.Video;

import lombok.Getter;
import lombok.Setter;

/**
 * @author arronshentu
 */
public class VideoUploadTask extends ApplicationEvent {

  @Getter
  @Setter
  private String videoPath;
  @Getter
  @Setter
  private String audioPath;
  @Getter
  @Setter
  private String outputPath;
  @Getter
  @Setter
  private String orderId;

  public VideoUploadTask(Video video) {
    super(video);
  }

}
