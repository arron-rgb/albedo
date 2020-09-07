package com.albedo.java.modules.biz.service.task;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.scheduling.annotation.Async;

import lombok.extern.slf4j.Slf4j;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFmpegUtils;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;
import net.bramp.ffmpeg.job.FFmpegJob;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;
import net.bramp.ffmpeg.progress.Progress;
import net.bramp.ffmpeg.progress.ProgressListener;

/**
 * @author arronshentu
 */
@Slf4j
public class VideoTaskExecutor {

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

  @Async
  @Order
  @EventListener(VideoUploadTask.class)
  public void uploadVideoToOss(VideoUploadTask event) {
    String videoPath = event.getVideoPath();
    // 方法更新至videoService
  }

  @Async
  @Order
  @EventListener(VideoUploadTask.class)
  public void updateVideo(VideoEncodeTask event) throws IOException {
    String videoPath = event.getVideoPath();
    String audioPath = event.getAudioPath();
    String outputPath = event.getOutputPath();
    String codec = "copy";

    FFmpegBuilder builder = new FFmpegBuilder().addInput(videoPath).addInput(audioPath).addOutput(outputPath)
      .setVideoCodec(codec).setAudioCodec(codec).done();

    FFmpegExecutor executor = new FFmpegExecutor(ffmpeg, ffprobe);
    FFmpegProbeResult in = ffprobe.probe(videoPath);
    // todo 加上线程池配置 不打印进度 job执行完毕添加callback方法设定路径并决定是否上传
    FFmpegJob job = executor.createJob(builder, new ProgressListener() {
      final double duration_ns = in.getFormat().duration * TimeUnit.SECONDS.toNanos(1);

      @Override
      public void progress(Progress progress) {
        double percentage = progress.out_time_ns / duration_ns;
        System.out.printf("[%.0f%%] status:%s frame:%d time:%s ms fps:%.0f speed:%.2fx%n", percentage * 100,
          progress.status, progress.frame, FFmpegUtils.toTimecode(progress.out_time_ns, TimeUnit.NANOSECONDS),
          progress.fps.doubleValue(), progress.speed);
      }
    });
    job.run();
  }
}
