package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.BUSINESS_COMMON_ROLE_ID;
import static com.albedo.java.common.core.constant.ExceptionNames.*;
import static com.albedo.java.common.core.util.FileUtil.concatFilePath;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.VideoDto;
import com.albedo.java.modules.biz.repository.VideoRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.biz.service.task.VideoEncodeTask;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.aliyun.oss.event.ProgressEventType;
import com.aliyun.oss.internal.OSSUtils;
import com.aliyuncs.utils.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.IdUtil;

/**
 * @author arronshentu
 */
@Service
public class VideoServiceImpl extends DataServiceImpl<VideoRepository, Video, VideoDto, String>
  implements VideoService {

  @Resource
  OrderService orderService;

  @Resource
  UserService userService;

  @Resource
  OssSingleton ossSingleton;

  @Resource
  BalanceService balanceService;

  @Override
  public boolean storageState(Double byteSize, String userId) {
    // 以下语义类似 1为已使用空间 2为剩余量 3如何获取购买套餐记录使其与使用量/剩余量绑定
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    Assert.notNull(balance, EMPTY_STORAGE);
    return byteSize.compareTo(balance.getStorage()) > 0;
  }

  /**
   * 上传视频，可执行多次
   * 逻辑：
   * 员工上传视频：一条订单可对应多个video
   *
   *
   * @param orderId
   *          订单id
   * @param tempPath
   * @throws IOException
   */
  @Override
  @Async
  @Transactional(rollbackFor = Exception.class)
  public void uploadVideo(String orderId, String tempPath) throws IOException {
    // 更新订单状态
    Order order = orderService.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    String userId = order.getUserId();
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    // 更新使用状况 单位以GB为基准
    Assert.notNull(balance, EMPTY_STORAGE);
    File tempFile = new File(tempPath);
    double storage = balance.getStorage() - ((double)tempFile.length() / 1073741824);
    balance.setStorage(storage);
    String bucketName = userService.getBucketName(userId);
    if (!ossSingleton.doesBucketExist(bucketName)) {
      createBucket(bucketName);
    }
    if (storage < 0) {
      try {
        ossSingleton.removeOldestFile(bucketName);
      } catch (Exception ignored) {
        log.error("删除失败");
      }
    }
    // userId不符合bucket命名规范，则用uuid当bucketName
    // 并且将其更新到qqOpenId字段上
    InputStream inputStream = new FileInputStream(tempFile);
    // 只要上传视频就插入新的记录
    Video video = Video.builder().userId(userId).orderId(orderId).build();
    video.setOriginUrl(tempPath);
    video.setName(tempFile.getName());
    baseMapper.insert(video);
    if (StringUtils.isEmpty(order.getVideoId())) {
      order.setVideoId(video.getId());
      order.updateById();
    }
    // 上传视频至oss video命名规则: 数据库中的id+.格式
    // video存储规则:
    // 本地：./upload/bucketName/文件名
    // oss: ./bucketName/文件名
    ossSingleton.uploadFileStream(inputStream, bucketName, video.getName());
    balanceService.updateById(balance);
  }

  /**
   * 1. 检查本地是否存在该video对应的视频
   * 2. 如果存在直接渲染，不存在则通过oss拉取视频
   * 3. 渲染时需要保证radio和audio都存在
   * 4. orderId中type为1的启用gpu加速
   *
   * 在checkIfFileExist中通知执行渲染任务
   *
   * @param videoId
   *          需要合成的videoId
   */
  @Async
  @Override
  public void addAudio(String videoId) {
    Video video = baseMapper.selectById(videoId);
    Assert.notNull(video, VIDEO_NOT_FOUND);
    Assert.notEmpty(video.getAudioUrl(), AUDIO_NOT_FOUND);
    Assert.notEmpty(video.getOriginUrl(), VIDEO_DATA_NOT_FOUND);
    checkIfFileExist(video);
  }

  /**
   * 查询一个订单id并且audio非空的video
   *
   * @param orderId
   * @return
   */
  @Override
  public Video getOneByOrderId(String orderId) {
    Order order = orderService.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    Video video = baseMapper.selectById(order.getVideoId());
    Assert.notNull(video, VIDEO_NOT_FOUND);
    return video;
  }

  /**
   * 在download中发起下载的请求，
   * listener中监听结束的信号
   * 发起合成的请求
   * 合成中监听结束的信号
   * 发起上传的请求
   *
   * @param video
   */
  private void checkIfFileExist(Video video) {
    String bucketName = userService.getBucketName(video.getUserId());
    String name = video.getName();
    File file = new File(concatFilePath("upload", bucketName, name));
    if (file.exists()) {
      SpringContextHolder.publishEvent(new VideoEncodeTask(video));
    } else {
      // 下载完成后再执行addAudio的逻辑
      ossSingleton.downloadFile(bucketName, name, (progressEvent) -> {
        ProgressEventType eventType = progressEvent.getEventType();
        switch (eventType) {
          case TRANSFER_STARTED_EVENT:
            log.info("开始下载");
            break;
          case TRANSFER_COMPLETED_EVENT:
            VideoEncodeTask event = new VideoEncodeTask(video);
            SpringContextHolder.publishEvent(event);
            break;
          case TRANSFER_FAILED_EVENT:
            log.info("失败");
            break;
          default:
            break;
        }
      });
    }
  }

  /**
   * 用作临时存储需要渲染的视频的路径
   *
   * @param video
   * @return
   */
  private String getLocalPath(Video video) {
    String bucketName = video.getUserId();
    bucketName = userService.getBucketName(bucketName);
    return concatFilePath("download", bucketName, video.getName());
  }

  /**
   * 每个企业/个人默认一个bucket，命名按企业id或个人id命名
   * 只能包括小写字母、数字和短划线（-）。
   * 必须以小写字母或者数字开头和结尾。
   * 长度必须在3~63字节之间。
   */
  private String createBucket(String userId) {
    // userId应该是通过订单获取，视频由工作人员上传的
    List<String> roleIds = userService.findUserVoById(userId).getRoleIdList();
    // 如果为付费用户，则找管理员；管理员为其余两种情况均无需变动userId
    if (roleIds.contains(BUSINESS_COMMON_ROLE_ID)) {
      userId = userService.getAdminIdByDeptId(userId);
    }
    // 没bucket的话 storage也不会被调用
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    Double storageSize = balance.getStorage();

    String bucketName = userId;
    if (!OSSUtils.validateBucketName(bucketName)) {
      bucketName = IdUtil.fastUUID();
    }

    if (!ossSingleton.doesBucketExist(bucketName)) {
      // buck命名失败时使用uuid 并更新uuid为qqOpenId
      ossSingleton.create(bucketName, storageSize.intValue());
      User user = userService.getById(userId);
      user.setQqOpenId(bucketName);
      userService.updateById(user);
    }
    return bucketName;
  }

}
