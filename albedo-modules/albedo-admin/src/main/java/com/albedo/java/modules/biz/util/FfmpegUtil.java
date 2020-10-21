package com.albedo.java.modules.biz.util;

import static com.albedo.java.common.core.util.FileUtil.generateFilePath;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.albedo.java.modules.biz.domain.Video;
import com.baomidou.mybatisplus.core.toolkit.Assert;

import cn.hutool.core.io.FileUtil;
import lombok.extern.slf4j.Slf4j;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;
import net.bramp.ffmpeg.job.FFmpegJob;
import net.bramp.ffmpeg.probe.FFmpegFormat;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;
import net.bramp.ffmpeg.progress.ProgressListener;

/**
 * @author arronshentu
 */
@Component
@Slf4j
public class FfmpegUtil {

  static String gpuParam = "-hwaccel cuvid";

  public static FFprobe ffprobe;
  public static FFmpeg ffmpeg;
  static FFmpegExecutor executor;

  public FfmpegUtil(@Value("${path.ffprobe}") String ffprobePath, @Value("${path.ffmpeg}") String ffmpegPath) {
    try {
      ffprobe = new FFprobe(ffprobePath);
      ffmpeg = new FFmpeg(ffmpegPath);
      executor = new FFmpegExecutor(ffmpeg, ffprobe);
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public static FFmpegFormat getVideoMetadata(String filePath) {
    try {
      FFmpegProbeResult probe = ffprobe.probe(filePath);
      return probe.getFormat();
    } catch (IOException e) {
      // 打印ffmpeg返回的错误
      log.info(e.getMessage());
      return new FFmpegFormat();
    }
  }

  public static boolean hasAudio(String filePath) {
    try {
      FFmpegProbeResult result = ffprobe.probe(filePath);
      Map<String, String> tags = result.getFormat().tags;
      return Boolean.parseBoolean(tags.getOrDefault("hasAudio", "false"));
    } catch (IOException e) {
      log.error("{}", e.getMessage());
      return false;
    }
  }

  private static final String COPY = "copy";

  public static String delAudio(String mediaPath) {
    FFmpegBuilder builder = new FFmpegBuilder();
    log.info("原视频路径{}", mediaPath);
    builder.addInput(mediaPath);
    String parentPath = new File(mediaPath).getParent();
    log.info("母文件路径{}", parentPath);
    String extName = FileUtil.extName(mediaPath);
    String outputPath = generateFilePath(extName);
    builder.addOutput(outputPath).setVideoCodec(COPY).addExtraArgs("-an").done();
    log.info("导出静音视频至{}", outputPath);
    run(builder);
    return outputPath;
  }

  public String newConcatAudio(String audioUrl, List<Video> videos) {
    String tempOutput = shuffleList(videos);

    String outputPath = loopOrCut(audioUrl, tempOutput);
    deleteFile(tempOutput);
    return outputPath;
  }

  /**
   * 构造音频参数
   *
   * @param mediaPaths
   *          音频路径list
   * @return
   */
  public static String concatMedia(List<String> mediaPaths) {
    // ffmpeg -i "concat:test1.mp3|test2.mp3" -acodec copy output.mp3
    String concat = "\"concat:%s";
    StringBuilder builder = new StringBuilder();
    for (String path : mediaPaths) {
      builder.append(path).append("|");
    }
    builder.deleteCharAt(builder.length() - 1);
    builder.append("\"");
    return String.format(concat, builder.toString());
  }

  public static void run(FFmpegBuilder builder) {
    run(builder, null);
  }

  public static void run(FFmpegBuilder builder, ProgressListener listener) {
    FFmpegJob job;
    job = executor.createJob(builder, listener);
    job.run();
  }

  public void deleteFile(String path) {
    File file = new File(path);
    // 路径为文件且不为空则进行删除
    if (file.isFile() && file.exists()) {
      file.delete();
    }
  }

  /**
   * 1. 打乱顺序
   * 2. 拼接小片段成一级循环
   *
   * @param videoList
   * @return
   */
  public String shuffleList(List<Video> videoList) {
    Assert.notEmpty(videoList, "");
    Collections.shuffle(videoList);
    List<String> videoPaths = videoList.stream().map(Video::getOriginUrl).collect(Collectors.toList());
    String extName = FileUtil.extName(videoPaths.get(0));
    String videoOutputPath = generateFilePath(extName);
    FFmpegBuilder builder = new FFmpegBuilder();
    builder.addInput(concatMedia(videoPaths));
    builder.addOutput(videoOutputPath).setVideoCodec(COPY).setStrict(FFmpegBuilder.Strict.EXPERIMENTAL).done();
    run(builder);
    return videoOutputPath;
  }

  /**
   * 以优先级高的为标准，对inferior进行切割或循环
   * 使用场景: video与audio的合成
   * 在输出完毕后需要对导出的结果再进一步cut处理
   *
   * 1. 将一级循环与音频对接
   * 2. 这里是二级循环
   * 3. 清除一级循环的中间文件及拼接的文本文件
   *
   * @param prior
   * @param inferior
   */
  public String loopOrCut(String prior, String inferior) {
    FFmpegBuilder builder;
    String extName = FileUtil.extName(inferior);
    String videoOutputPath = generateFilePath(extName);
    Double priorityDuration = getVideoMetadata(prior).duration;
    Double inferiorityDuration = getVideoMetadata(inferior).duration;
    // 不管谁大谁小 都得先循环再切
    List<String> paths = new LinkedList<>();
    double times = Math.ceil(priorityDuration / inferiorityDuration);
    for (int i = 0; i < (int)times; i++) {
      paths.add(inferior);
    }
    // 合成video
    builder = new FFmpegBuilder();
    String tempTxt = generateTempTxt(paths);
    builder.addInput(tempTxt).addExtraArgs("-f", "concat", "-safe", "0");
    String tempExtName = FileUtil.extName(inferior);
    String tempOutput = generateFilePath(tempExtName);
    builder.addOutput(tempOutput).setVideoCodec(COPY).done();
    // 清除声音
    run(builder);
    if (hasAudio(tempOutput)) {
      delAudio(tempOutput);
    }
    // 音频与视频拼接
    builder = new FFmpegBuilder().addInput(prior);
    builder.addInput(tempOutput);
    builder.addOutput(videoOutputPath).setDuration(priorityDuration.longValue(), TimeUnit.SECONDS)
      .setVideoCodec("libx264").setAudioBitRate(16000L).setAudioCodec("aac").setVideoCodec(COPY).done();
    run(builder);
    deleteFile(tempTxt);
    deleteFile(tempOutput);
    return videoOutputPath;
  }

  public static String generateTempTxt(List<String> paths) {
    String filename = generateFilePath("txt");
    File file = new File(filename);
    try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
      for (String temp : paths) {
        writer.write(String.format("file '%s'\n", temp));
      }
      writer.flush();
      log.info("写入{}", file.getAbsolutePath());
      return file.getAbsolutePath();
    } catch (IOException e) {
      log.error("文件不存在");
      return "";
    }
  }

}
