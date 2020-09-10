package com.albedo.java.modules.biz.service.task;

import com.albedo.java.modules.biz.domain.Video;

import lombok.Getter;
import lombok.Setter;

/**
 * @author arronshentu
 */
public class VideoUploadTask extends VideoTask {
  @Getter
  @Setter
  String bucketName;

  public VideoUploadTask(Video video) {
    super(video);
  }

  public VideoUploadTask(Video video, String bucketName) {
    super(video);
    this.bucketName = bucketName;
  }

}
