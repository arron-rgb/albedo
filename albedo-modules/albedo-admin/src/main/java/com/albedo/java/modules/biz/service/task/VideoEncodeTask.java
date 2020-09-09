package com.albedo.java.modules.biz.service.task;

import com.albedo.java.modules.biz.domain.Video;

import lombok.Getter;
import lombok.Setter;

/**
 * @author arronshentu
 */
public class VideoEncodeTask extends VideoTask {

  @Getter
  @Setter
  private boolean gpuFlag = false;

  public VideoEncodeTask(Video video) {
    super(video);
  }

  public VideoEncodeTask(Video video, boolean gpuFlag) {
    super(video);
    this.gpuFlag = gpuFlag;
  }

}
