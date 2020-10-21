package com.albedo.java.modules.biz.service.task;

import static com.albedo.java.common.core.constant.BusinessConstants.COMPLETED_SUCCESS;
import static com.albedo.java.common.core.constant.ExceptionNames.AUDIO_NOT_FOUND;
import static com.albedo.java.common.core.constant.ExceptionNames.VIDEO_NOT_FOUND;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;

import com.albedo.java.common.core.util.FileUploadUtil;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.biz.util.FfmpegUtil;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.toolkit.Assert;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.io.FileUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Slf4j
public class VideoTaskExecutor {
  public VideoTaskExecutor() {}

  /**
   * 将音频与视频合成
   * 合成完毕后 1. 将视频上传至oss 2. 更新video表字段 3. 更新订单表字段
   *
   * @param event
   *          含有video的信息
   */
  @Async
  @EventListener(VideoEncodeTask.class)
  public void concatAudio(VideoEncodeTask event) {
    Video video = event.video;
    List<Video> videos = videoService.list(Wrappers.<Video>query().eq("order_id", video.getOrderId()));
    videos.forEach(innerVideo -> {
      // 9169280e-3159-4218-be7a-bf0dc298785c.oss-cn-hangzhou.aliyuncs.com/ce1c7a71f6a8b72cf21f7cdabc655114.mp4
      // static.vlivest.com/6f83d88654539343fc153888d8da736a.mp3
      String originUrl = video.getOriginUrl();
      String originPath = checkFileExist(ossSingleton.getPath(originUrl));
      innerVideo.setOriginUrl(originPath);

      String audioUrl = video.getAudioUrl();
      String audioPath = checkFileExist(ossSingleton.getPath(audioUrl));
      innerVideo.setAudioUrl(audioPath);
    });
    Assert.notEmpty(videos, VIDEO_NOT_FOUND);
    String audioUrl = FileUploadUtil.getDefaultBaseDir() + File.separator + ossSingleton.getPath(video.getAudioUrl());
    Assert.notEmpty(audioUrl, AUDIO_NOT_FOUND);
    String outputUrl = ffmpegUtil.concatAudio(audioUrl, videos);
    String userId = video.getUserId();
    String bucketName = userService.getBucketName(userId);
    String outputPath =
      FileUtil.getParent(outputUrl, 1) + File.separator + bucketName + File.separator + FileUtil.getName(outputUrl);
    FileUtil.move(FileUtil.newFile(outputUrl), FileUtil.newFile(outputPath), true);
    log.info("将视频输出位置{}移动到{}", outputUrl, outputPath);
    // 更新video表
    File file = new File(outputPath);
    // 上传视频
    ossSingleton.uploadFile(file, file.getName(), bucketName);
    video.setOutputUrl(ossSingleton.getUrl(file.getAbsolutePath()));
    log.info("上传视频{}", video.getOutputUrl());
    videoService.updateById(video);
    // 更新订单状态
    String orderId = video.getOrderId();
    Order order = orderService.getById(orderId);
    order.setState(COMPLETED_SUCCESS);
    orderService.updateById(order);
    log.info("更新订单状态为{}", order.getState());
    FileUtil.del(audioUrl);
    log.info("删除音频{}", audioUrl);
  }

  private String checkFileExist(String audioPath) {
    String downloadPath = FileUploadUtil.getDefaultBaseDir() + File.separator + audioPath;
    if (!FileUtil.exist(new File(downloadPath)) || FileUtil.isEmpty(new File(downloadPath))) {
      FileUtil.touch(audioPath);
      String[] split = audioPath.split(File.separator);
      ossSingleton.downloadFile(split[0], split[1], downloadPath);
    }
    return downloadPath;
  }

  @Resource
  OrderService orderService;
  @Resource
  VideoService videoService;
  @Resource
  UserService userService;
  @Resource
  OssSingleton ossSingleton;
  @Resource
  FfmpegUtil ffmpegUtil;

  @Async
  @EventListener(Signal.class)
  public void signal(Signal signal) {
    log.info("触发合成");
    videoService.addAudio(signal.getVideoId());
  }
}
