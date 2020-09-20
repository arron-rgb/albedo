package com.albedo.java.modules.biz.util;

import static com.albedo.java.common.core.util.FileUtil.generateFilePath;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.albedo.java.modules.biz.domain.Video;

import cn.hutool.core.io.FileUtil;
import lombok.extern.slf4j.Slf4j;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;
import net.bramp.ffmpeg.job.FFmpegJob;
import net.bramp.ffmpeg.probe.FFmpegFormat;
import net.bramp.ffmpeg.progress.ProgressListener;

/**
 * @author arronshentu
 */
@Component
@Slf4j
public class FfmpegUtil {

  static String gpuParam = "-hwaccel cuvid";

  static FFprobe ffprobe;
  static FFmpeg ffmpeg;
  static FFmpegExecutor executor;

  static {
    try {
      ffprobe = new FFprobe("/usr/local/bin/ffprobe");
      ffmpeg = new FFmpeg("/usr/local/bin/ffmpeg");
      executor = new FFmpegExecutor(ffmpeg, ffprobe);
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public FFmpegFormat getVideoMetadata(String filePath) {
    try {
      return ffprobe.probe(filePath).getFormat();
    } catch (IOException e) {
      // 打印ffmpeg返回的错误
      log.info(e.getMessage());
      return null;
    }
  }

  String output = "";

  /**
   * 给视频添加音频 时间填充
   *
   */
  public String concatAudio(Video video) {
    String audioPath = video.getAudioUrl();
    String videoPath = video.getOriginUrl();
    // String videoPath = concatFilePath("upload", video.getOriginUrl());
    String extName = FileUtil.extName(videoPath);
    return concatAudioWithGpu(audioPath, videoPath, generateFilePath(extName), false);
    // concatAudioWithGpu(audioPath, videoPath, "", false);
  }

  public String concatAudioWithGpu(String audioPath, String videoPath, String outputPath, boolean gpuFlag) {
    String extName = FileUtil.extName(audioPath);
    String audioTempOutput = generateFilePath(extName);
    String codec = "copy";

    // 计算需要多少段配音
    double duration = getVideoMetadata(audioPath).duration;
    List<String> list = new ArrayList<>();
    double videoDuration = getVideoMetadata(videoPath).duration;
    int v = (int)(videoDuration / duration);
    for (int i = 0; i < v; i++) {
      list.add(audioPath);
    }

    // 先合成拼接的mp3
    FFmpegBuilder builder = new FFmpegBuilder();
    builder.addInput(concatMp3(list));
    builder.addOutput(audioTempOutput).setAudioCodec(codec).done();
    run(builder);
    log.info("合成总mp3，合成路径{}", audioTempOutput);

    // 拼接结果放进mp4
    builder = new FFmpegBuilder().addInput(videoPath);
    builder.addInput(audioTempOutput);
    // if (gpuFlag) {
    // builder.addExtraArgs(gpuParam);
    // }
    builder.addOutput(outputPath).setVideoCodec("libx264").setAudioBitRate(16000L).setAudioCodec("aac")
      .setVideoCodec(codec).done();
    run(builder);
    log.info("注入音频");

    deleteFile(audioTempOutput);
    log.info("结束，文件路径:{}", outputPath);
    return outputPath;
  }

  /**
   * 构造音频参数
   *
   * @param audioPaths
   *          音频路径list
   * @return
   */
  public String concatMp3(List<String> audioPaths) {
    // ffmpeg -i "concat:test1.mp3|test2.mp3" -acodec copy output.mp3
    String concat = "concat:%s";
    StringBuilder builder = new StringBuilder();
    for (String path : audioPaths) {
      builder.append(path).append("|");
    }
    builder.deleteCharAt(builder.length() - 1);
    return String.format(concat, builder.toString());
  }

  private String videoFilter(String logoPath, String axis) {
    return "movie=" + logoPath + "[watermark];[in][watermark]overlay=" + axis + "[out]";
  }

  public void run(FFmpegBuilder builder) {
    run(builder, null);
  }

  public void run(FFmpegBuilder builder, ProgressListener listener) {
    FFmpegJob job;
    job = executor.createJob(builder, listener);
    job.run();
  }

  public static void deleteFile(String path) {
    File file = new File(path);
    // 路径为文件且不为空则进行删除
    if (file.isFile() && file.exists()) {
      file.delete();
    }
  }

}
