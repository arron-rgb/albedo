package com.albedo.java.modules.biz.service.task;

import org.springframework.context.ApplicationEvent;

import com.albedo.java.modules.biz.domain.Video;

/**
 * @author arronshentu
 */
public class VideoEncodeTask extends ApplicationEvent {

  Video video;

  public VideoEncodeTask(Video video) {
    super(video);
    this.video = video;
  }

}
