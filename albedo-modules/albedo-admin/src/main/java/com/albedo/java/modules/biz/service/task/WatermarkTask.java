package com.albedo.java.modules.biz.service.task;

import com.albedo.java.modules.biz.domain.Video;

import lombok.Getter;
import lombok.Setter;

/**
 * @author arronshentu
 */
public class WatermarkTask extends VideoTask {

  @Getter
  @Setter
  private String axis;

  public WatermarkTask(Video video) {
    super(video);
  }

  public WatermarkTask(Video video, String axis) {
    super(video);
    this.axis = axis;
  }
}
