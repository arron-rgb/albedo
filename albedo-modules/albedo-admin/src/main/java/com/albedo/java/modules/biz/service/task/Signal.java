package com.albedo.java.modules.biz.service.task;

import org.springframework.context.ApplicationEvent;

import lombok.Getter;
import lombok.Setter;

/**
 * @author arronshentu
 */
public class Signal extends ApplicationEvent {
  @Getter
  @Setter
  private String videoId;

  public Signal(String videoId) {
    super(videoId);
    this.videoId = videoId;
  }
}
