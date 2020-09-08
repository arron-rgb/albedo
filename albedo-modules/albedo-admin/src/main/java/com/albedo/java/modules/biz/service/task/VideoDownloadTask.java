package com.albedo.java.modules.biz.service.task;

import org.springframework.context.ApplicationEvent;

import com.albedo.java.modules.biz.domain.Video;

import lombok.Getter;
import lombok.Setter;

/**
 * todo 是否需要
 *
 * @author arronshentu
 */
public class VideoDownloadTask extends ApplicationEvent {

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

  public VideoDownloadTask(Video video) {
    super(video);
  }

}
