package com.albedo.java.modules.biz.util;

import java.io.IOException;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;

/**
 * @author arronshentu
 */
@Component
@Slf4j
public class FfmpegUtil {

  static FFprobe ffprobe;
  static FFmpeg ffmpeg;

  static {
    try {
      ffprobe = new FFprobe("/usr/local/bin/ffprobe");
      ffmpeg = new FFmpeg("/usr/local/bin/ffmpeg");
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public FFmpegProbeResult getVideoMetadata(String filePath) {
    try {
      return ffprobe.probe(filePath);
    } catch (IOException e) {
      // 打印ffmpeg返回的错误
      log.info(e.getMessage());
      return null;
    }
  }

  // todo 启用gpu的逻辑
}
