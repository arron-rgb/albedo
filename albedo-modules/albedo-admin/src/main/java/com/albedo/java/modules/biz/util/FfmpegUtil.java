package com.albedo.java.modules.biz.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.albedo.java.modules.biz.domain.Video;

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
   * todo 需要负责编码的格式
   *
   */
  public void concatAudio(Video video) {
    String audioPath = video.getAudioUrl();
    String videoPath = video.getOriginUrl();
    String outPut = "";
    concatAudioWithGpu(audioPath, videoPath, outPut, false);
  }

  public void concatAudioWithGpu(String audioPath, String videoPath, String outPut, boolean gpuFlag) {

    String audioTempOutput = "";
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
    FFmpegBuilder builder = new FFmpegBuilder().addInput(videoPath);
    builder.addInput(concatMp3(list));
    builder.addOutput(audioTempOutput).setAudioCodec(codec).done();
    run(builder);

    // 拼接结果放进mp4
    builder = new FFmpegBuilder().addInput(videoPath);
    builder.addInput(audioTempOutput);
    if (gpuFlag) {
      builder.addExtraArgs(gpuParam);
    }
    builder.addOutput(outPut).setVideoCodec(codec).setAudioCodec(codec).done();
    run(builder);

    deleteFile(audioTempOutput);
    // todo 执行完毕后更新订单情况及视频信息
  }

  /**
   * 构造音频参数
   *
   * @param audioPaths
   *          音频路径list
   * @return
   */
  private String concatMp3(List<String> audioPaths) {
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

  /**
   * 加水印
   *
   * @param videoPath
   *          视频路径
   * @param logoPath
   *          水印路径
   * @param axis
   *          水印坐标
   */
  public void addWatermark(String videoPath, String logoPath, String axis) {
    FFmpegBuilder builder = new FFmpegBuilder().addInput(videoPath);
    builder.setAudioFilter(videoFilter(logoPath, axis));
    builder.addOutput(output).done();
    run(builder);
  }

  public void run(FFmpegBuilder builder) {
    run(builder, null);
  }

  public void run(FFmpegBuilder builder, ProgressListener listener) {
    FFmpegJob job = executor.createJob(builder);
    executor.createJob(builder, listener);
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
