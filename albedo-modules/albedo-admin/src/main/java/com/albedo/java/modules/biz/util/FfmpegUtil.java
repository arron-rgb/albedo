package com.albedo.java.modules.biz.util;

import static cn.hutool.core.io.FileUtil.move;
import static cn.hutool.core.io.FileUtil.newFile;
import static com.albedo.java.common.core.util.FileUploadUtil.getBucketPath;
import static com.albedo.java.common.core.util.FileUtil.generateFilePath;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.albedo.java.modules.biz.domain.VideoMaterial;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
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

  static String gpuParam;

  public static FFprobe ffprobe;
  public static FFmpeg ffmpeg;
  static FFmpegExecutor executor;

  public FfmpegUtil(@Value("${path.ffprobe}") String ffprobePath, @Value("${path.ffmpeg}") String ffmpegPath,
    @Value("${hwflag}") String gpuParamConfig) {
    try {
      ffprobe = new FFprobe(ffprobePath);
      ffmpeg = new FFmpeg(ffmpegPath);
      gpuParam = gpuParamConfig;

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
    if (!hasAudio(mediaPath)) {
      return mediaPath;
    }
    FFmpegBuilder builder = new FFmpegBuilder();
    log.info("原视频路径{}", mediaPath);
    builder.addInput(mediaPath);
    String parentPath = new File(mediaPath).getParent();
    log.info("母文件路径{}", parentPath);
    String extName = FileUtil.extName(mediaPath);
    String outputPath = generateFilePath(extName);
    builder.addOutput(outputPath).setVideoCodec(COPY).addExtraArgs("-an").done();
    run(builder);
    move(newFile(outputPath), newFile(mediaPath), true);
    log.info("移动静音视频{}至{}", outputPath, mediaPath);
    return outputPath;
  }

  /**
   * 总步骤：音频与视频拼接
   *
   * @param audioUrl
   * @param videos
   * @return
   */
  public String concatAudio(String audioUrl, List<VideoMaterial> videos) {
    String tempOutput = shuffleList(videos);
    String outputPath = loopOrCut(audioUrl, tempOutput);
    FileUtil.del(tempOutput);
    return outputPath;
  }

  /**
   * 构造音频参数
   *
   * @param mediaPaths
   *          音频路径list
   * @return
   */
  public String concatMedia(List<String> mediaPaths, String bucket) {
    String extName = FileUtil.extName(mediaPaths.get(0));
    String mediaOutputPath = getBucketPath(bucket, IdUtil.fastSimpleUUID() + "." + extName);
    FFmpegBuilder fFmpegBuilder = new FFmpegBuilder();
    String tempTxtPath = generateTempTxt(mediaPaths);
    fFmpegBuilder.addInput(tempTxtPath).addExtraArgs("-f", "concat", "-safe", "0");
    fFmpegBuilder.addOutput(mediaOutputPath).setAudioCodec(COPY).addExtraArgs("-strict", "-2").done();
    run(fFmpegBuilder);
    FileUtil.del(tempTxtPath);
    return mediaOutputPath;
  }

  /**
   * 1. 打乱顺序
   * 2. 拼接小片段成一级循环
   *
   * @param videoList
   * @return
   */
  public String shuffleList(List<VideoMaterial> videoList) {
    // url为本地链接
    log.info("合成{}个视频", videoList.size());
    if (videoList.size() == 1) {
      return videoList.get(0).getOriginUrl();
    }
    List<String> videoPaths = videoList.stream().map(VideoMaterial::getOriginUrl).collect(Collectors.toList());
    String extName = FileUtil.extName(videoPaths.get(0));
    String videoOutputPath = generateFilePath(extName);
    FFmpegBuilder builder = new FFmpegBuilder();
    String tempTxtPath = generateTempTxt(videoPaths);
    builder.addInput(tempTxtPath).addExtraArgs("-f", "concat", "-safe", "0");
    builder.addOutput(videoOutputPath).setVideoCodec(COPY).addExtraArgs("-strict", "-2").done();
    run(builder);
    return videoOutputPath;
  }

  public String loopOrCut(String mediaPath, Double priorityDuration) {
    FFmpegBuilder builder = new FFmpegBuilder();
    List<String> paths = generateList(mediaPath, priorityDuration);
    String tempTxt = generateTempTxt(paths);
    builder.addInput(tempTxt).addExtraArgs("-f", "concat", "-safe", "0");
    String tempExtName = FileUtil.extName(mediaPath);
    String tempOutput = generateFilePath(tempExtName);
    builder.addOutput(tempOutput).setDuration(priorityDuration.longValue(), TimeUnit.SECONDS).setVideoCodec(COPY)
      .done();
    run(builder);
    return tempOutput;
  }

  private List<String> generateList(String mediaPath, Double priorityDuration) {
    Double inferiorityDuration = getVideoMetadata(mediaPath).duration;
    List<String> paths = new LinkedList<>();
    double times = Math.ceil(priorityDuration / inferiorityDuration);
    for (int i = 0; i < (int)times; i++) {
      paths.add(mediaPath);
    }
    return paths;
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
   *          音频
   * @param inferior
   *          一级循环视频
   */
  public String loopOrCut(String prior, String inferior) {
    FFmpegBuilder builder;
    String extName = FileUtil.extName(inferior);
    String videoOutputPath = generateFilePath(extName);
    Double priorityDuration = getVideoMetadata(prior).duration;
    List<String> paths = generateList(inferior, priorityDuration);
    // 合成video
    builder = new FFmpegBuilder();
    builder.addExtraArgs("-hwaccel_device", "0", "-hwaccel", gpuParam);
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
    builder.addExtraArgs("-hwaccel_device", "0", "-hwaccel", gpuParam);
    builder.addInput(tempOutput);
    builder.addOutput(videoOutputPath).setDuration(priorityDuration.longValue(), TimeUnit.SECONDS).setVideoCodec("h264")
      .setAudioBitRate(16000L).setAudioCodec("aac").setVideoCodec(COPY).done();
    run(builder);
    FileUtil.del(tempTxt);
    FileUtil.del(tempOutput);
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

  public static void run(FFmpegBuilder builder) {
    run(builder, null);
  }

  public static void run(FFmpegBuilder builder, ProgressListener listener) {
    FFmpegJob job;
    job = executor.createJob(builder, progress -> System.out.println("Progress: " + progress));
    job.run();
  }

}
