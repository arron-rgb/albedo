package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.BUSINESS_COMMON_ROLE_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.ORDER_STATE_3;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.VideoDto;
import com.albedo.java.modules.biz.repository.VideoRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.albedo.java.modules.tool.util.TtsSingleton;
import com.aliyun.oss.model.PutObjectResult;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;
import net.bramp.ffmpeg.job.FFmpegJob;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;

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
  public boolean storageState(Double byteSize) {
    // 以下语义类似 1为已使用空间 2为剩余量 3如何获取购买套餐记录使其与使用量/剩余量绑定
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", ""));
    Assert.notNull(balance, "该账号下无任何存储空间");
    return byteSize.compareTo(balance.getStorage()) > 0;
  }

  /**
   * 每个企业/个人默认一个bucket，命名按企业id或个人id命名。如果id不符合规范 使用uuid并设置为qqOpenId
   * 只能包括小写字母、数字和短划线（-）。
   * 必须以小写字母或者数字开头和结尾。
   * 长度必须在3~63字节之间。
   */
  @Override
  public void createBucket(String userId) {
    // userId应该是通过订单获取，视频由工作人员上传的
    List<String> roleIds = userService.findUserVoById(userId).getRoleIdList();
    // 如果为付费用户，则找管理员；管理员为其余两种情况均无需变动userId
    if (roleIds.contains(BUSINESS_COMMON_ROLE_ID)) {
      userId = userService.getOutTradeNosByUserId(userId);
    }
    // 没balance的话 storage也不会被调用
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    Assert.notNull(balance, "该账号下无任何存储空间");
    Double storageSize = balance.getStorage();
    String bucketName = userService.getBucketName(userId);
    if (!ossSingleton.doesBucketExist(bucketName)) {
      ossSingleton.create(bucketName, storageSize.intValue());
    }
  }

  @Override
  @Transactional(rollbackFor = Exception.class)
  public void uploadVideo(String orderId, MultipartFile file) throws IOException {
    // 更新订单状态
    Order order = orderService.getById(orderId);

    String userId = order.getUserId();
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    // 更新使用状况 单位以GB为基准
    Assert.notNull(balance, "该账号下无任何存储空间");
    double storage = balance.getStorage() - ((double)file.getSize() / 1073741824);
    // 存储空间不足
    Assert.isTrue(storage > 0, "该账号下存储空间不足以容纳该视频");
    balance.setStorage(storage);
    String bucketName = userService.getBucketName(userId);
    if (!ossSingleton.doesBucketExist(bucketName)) {
      createBucket(bucketName);
    }
    InputStream inputStream = file.getInputStream();
    // 保存视频记录至数据库
    Video video = Video.builder().userId(userId).orderId(orderId).build();
    baseMapper.insert(video);
    order.setState(ORDER_STATE_3);
    order.setVideoId(video.getId());
    orderService.updateById(order);
    // 上传视频至oss
    PutObjectResult result = ossSingleton.uploadFileStream(inputStream, bucketName, video.getId());
    balanceService.updateById(balance);
  }

  private static final String PATH = System.getenv("PWD");
  private static final String SEPARATOR = File.separator;

  @Override
  public void addAudio(String videoId) {
    Video video = baseMapper.selectById(videoId);
    String audioPath = video.getLogoUrl();
    String videoPath = PATH + SEPARATOR + "jojo.mp4";
    String outPut = PATH + SEPARATOR + "result.mp4";
    video.setOutputUrl(outPut);
    String codec = "copy";
    FFmpegBuilder builder = new FFmpegBuilder().addInput(videoPath).addInput(audioPath).addOutput(outPut)
      .setVideoCodec(codec).setAudioCodec(codec).done();

    FFmpegExecutor executor = new FFmpegExecutor(ffmpeg, ffprobe);
    // todo 加上线程池配置 不打印进度 job执行完毕添加callback方法设定路径并决定是否上传
    FFmpegJob job = executor.createJob(builder);
    job.run();
  }

  @Override
  public void uploadAudio(String radioPath) {
    // 1. 人工上传的配音
    // 2. tts合成的语音
    // 一样处理

  }

  @Resource
  TtsSingleton ttsSingleton;

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

}
