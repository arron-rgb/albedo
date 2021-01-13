package com.albedo.java.modules.biz.service.task;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.io.FileUtil;
import com.albedo.java.common.core.util.FileUploadUtil;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.VideoMaterial;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.biz.util.FfmpegUtil;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.aliyun.oss.event.ProgressEvent;
import com.aliyun.oss.event.ProgressEventType;
import com.aliyun.oss.event.ProgressListener;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static com.albedo.java.common.core.constant.BusinessConstants.*;

/**
 * @author arronshentu
 */
@Slf4j
public class VideoTaskExecutor {
  public VideoTaskExecutor() {
  }

  /**
   * 将音频与视频合成
   * 合成完毕后 1. 将视频上传至oss 2. 更新video表字段 3. 更新订单表字段
   *
   * @param event 含有video的信息
   */
  @Async
  @EventListener(VideoEncodeTask.class)
  @Transactional(rollbackFor = Exception.class)
  public void concatAudio(VideoEncodeTask event) {
    Video video = event.video;
    String orderId = video.getOrderId();

    List<VideoMaterial> materials = videoService.getMaterials(orderId);
    if (CollectionUtil.isEmpty(materials)) {
      log.error("订单对应素材为空，需要回滚状态");
      Order order = orderService.getById(orderId);
      order.setState(IN_PRODUCTION);
      orderService.updateById(order);
      return;
    }
    materials.forEach(material -> {
      String url = material.getOriginUrl();
      material.setOriginUrl(checkFileExist(ossSingleton.getPath(url)));
    });
    checkFileExist(ossSingleton.getPath(video.getAudioUrl()));
    String audioUrl = FileUploadUtil.getDefaultBaseDir() + File.separator + ossSingleton.getPath(video.getAudioUrl());
    if (FileUtil.isEmpty(new File(audioUrl))) {
      log.error("audio is empty");
      return;
    }
    String outputUrl = ffmpegUtil.concatAudio(audioUrl, materials);
    // todo 失败的话
    // redisTemplate.opsForList().rightPush("dub_task", video.getId());
    video.setOutputUrl(outputUrl);
    String userId = video.getUserId();
    String bucketName = userService.getBucketName(userId);
    String outputPath =
      FileUtil.getParent(outputUrl, 1) + File.separator + bucketName + File.separator + FileUtil.getName(outputUrl);
    FileUtil.move(FileUtil.newFile(outputUrl), FileUtil.newFile(outputPath), true);
    log.info("将视频输出位置{}移动到{}", outputUrl, outputPath);
    // 更新video表
    File file = new File(outputPath);
    // 上传视频
    ossSingleton.uploadFileNonAsync(file, file.getName(), bucketName);
    video.setOutputUrl(ossSingleton.getUrl(file.getAbsolutePath()));
    video.setStatus("配音完毕");
    video.updateById();
    // 更新订单状态
    Order order = orderService.getById(orderId);
    order.setState(VALID);
    orderService.updateById(order);
    log.info("更新订单状态为{}", order.getState());
    FileUtil.del(audioUrl);
    log.info("删除音频{}", audioUrl);
  }

  private String checkFileExist(String path) {
    String downloadPath = FileUploadUtil.getDefaultBaseDir() + File.separator + path;
    if (!FileUtil.exist(new File(downloadPath)) || FileUtil.isEmpty(new File(downloadPath))) {
      log.info("文件{}不存在或为空", path);
      log.info("下载文件至{}", downloadPath);
      FileUtil.touch(path);
      String[] split = path.split(File.separator);
      ossSingleton.downloadFile(split[0], split[1], downloadPath, new GetObjectProgressListener());
    }
    return downloadPath;
  }

  public static class GetObjectProgressListener implements ProgressListener {
    private long bytesRead = 0;
    private long totalBytes = -1;
    private boolean succeed = false;

    @Override
    public void progressChanged(ProgressEvent progressEvent) {
      long bytes = progressEvent.getBytes();
      ProgressEventType eventType = progressEvent.getEventType();
      switch (eventType) {
        case TRANSFER_STARTED_EVENT:
          log.info("Start to download......");
          break;
        case RESPONSE_CONTENT_LENGTH_EVENT:
          this.totalBytes = bytes;
          log.info(this.totalBytes + " bytes in total will be downloaded to a local file");
          break;
        case RESPONSE_BYTE_TRANSFER_EVENT:
          this.bytesRead += bytes;
          if (this.totalBytes != -1) {
            // int percent = (int)(this.bytesRead * 100.0 / this.totalBytes);
            // log.info(bytes + " bytes have been read at this time, download progress: " + percent + "%(" +
            // this.bytesRead
            // + "/" + this.totalBytes + ")");
          } else {
            log.info(
              bytes + " bytes have been read at this time, download ratio: unknown" + "(" + this.bytesRead + "/...)");
          }
          break;
        case TRANSFER_COMPLETED_EVENT:
          this.succeed = true;
          log.info("Succeed to download, " + this.bytesRead + " bytes have been transferred in total");
          break;
        case TRANSFER_FAILED_EVENT:
          log.info("Failed to download, " + this.bytesRead + " bytes have been transferred");
          break;
        default:
          break;
      }
    }

    public boolean isSucceed() {
      return succeed;
    }
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
  RedisTemplate<String, String> redisTemplate;
  @Resource
  FfmpegUtil ffmpegUtil;

  @Scheduled(fixedDelay = 5000L)
  public void invoke() {
    Long size = redisTemplate.opsForList().size("dub_task");
    if (Optional.ofNullable(size).orElse(0L) > 0) {
      String videoId = redisTemplate.opsForList().rightPop("dub_task");
      log.info("执行{}的合成", videoId);
      videoService.addAudio(videoId);
    }
  }

  @Resource
  BalanceService balanceService;

  @Scheduled(fixedDelay = 1000L)
  public void checkOrderStatus() {
    // todo 找一个状态为>=3的 距离今天最近的订单 到点后唤醒
    List<Order> list = orderService.list(Wrappers.<Order>lambdaQuery().eq(Order::getState, PRODUCTION_COMPLETED).or().eq(Order::getState, NOT_UPDATED).or().eq(Order::getState, VALID));
    list.forEach(order -> {
      String userId = order.getUserId();
      Balance balance = balanceService.getByUserId(userId);
      LocalDateTime availableDate = order.getCreatedDate().plusDays(balance.getLicenseDuration());
      if (availableDate.isBefore(LocalDateTime.now())) {
        order.setState(FINISHED);
        order.updateById();
        log.info("更新订单{}为已结束", order.getId());
      }
    });
  }

}
