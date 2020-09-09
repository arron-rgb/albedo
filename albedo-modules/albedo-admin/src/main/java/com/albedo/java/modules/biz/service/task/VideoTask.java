package com.albedo.java.modules.biz.service.task;

import org.springframework.context.ApplicationEvent;

import com.albedo.java.modules.biz.domain.Video;

import lombok.Getter;
import lombok.Setter;

/**
 * @author arronshentu
 */
public class VideoTask extends ApplicationEvent {

  @Getter
  @Setter
  String status;

  @Getter
  @Setter
  String orderId;
  Video video;

  public VideoTask(Video video) {
    super(video);
    this.video = video;
    this.status = "start";
  }

}
