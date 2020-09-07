package com.albedo.java.modules.biz.service.task;

import org.springframework.context.ApplicationEvent;

import com.albedo.java.modules.biz.domain.Video;

import lombok.Getter;
import lombok.Setter;

/**
 * @author arronshentu
 */
public class VideoEncodeTask extends ApplicationEvent {

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

  public VideoEncodeTask(Video video) {
    super(video);
  }

  public VideoEncodeTask(Object source, String audioPath, String outputPath, String orderId) {
    super(source);
    this.audioPath = audioPath;
    this.outputPath = outputPath;
    this.orderId = orderId;
  }
}
