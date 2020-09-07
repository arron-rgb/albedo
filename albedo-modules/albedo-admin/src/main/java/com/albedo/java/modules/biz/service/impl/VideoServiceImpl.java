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
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.albedo.java.modules.tool.util.TtsSingleton;
import com.aliyun.oss.internal.OSSUtils;
import com.aliyuncs.utils.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.IdUtil;
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
      userId = userService.getOutTradeNosByUserId(userId);
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

  @Override
  @Transactional(rollbackFor = Exception.class)
  public void uploadVideo(String orderId, MultipartFile file) throws IOException {
    // 更新订单状态
    Order order = orderService.getById(orderId);
    Assert.notNull(order, "未查询到订单信息");
    String userId = order.getUserId();
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    // 更新使用状况 单位以GB为基准
    Assert.notNull(balance, "该账号下无任何存储空间");
    double storage = balance.getStorage() - ((double)file.getSize() / 1073741824);
    // 存储空间不足
    Assert.isTrue(storage > 0, "该账号下存储空间不足以容纳该视频");
    balance.setStorage(storage);

    String bucketName = userId;
    // userId不符合bucket命名规范，则用uuid当bucketName
    // 并且将其更新到qqopenid字段上
    if (!OSSUtils.validateBucketName(bucketName)) {
      User user = userService.getById(userId);
      // 因此 只要符合 userId不符合命名规范 并且 qqOpenId为空的用户 就是没有bucket
      if (StringUtils.isEmpty(user.getQqOpenId())) {
        bucketName = createBucket(userId);
      } else {
        bucketName = user.getQqOpenId();
      }
    }

    InputStream inputStream = file.getInputStream();
    // 保存视频记录至数据库
    Video video = Video.builder().userId(userId).orderId(orderId).build();
    baseMapper.insert(video);
    order.setState(ORDER_STATE_3);
    order.setVideoId(video.getId());
    orderService.updateById(order);
    // 上传视频至oss todo video命名规则
    ossSingleton.uploadFileStream(inputStream, bucketName, video.getName());
    balanceService.updateById(balance);
  }

  private static final String PATH = System.getenv("PWD");
  private static final String SEPARATOR = File.separator;

  /**
   * 1. 检查本地是否存在该video对应的视频（todo 需要与oss上的存储规范一下）
   * 2. 如果存在直接渲染，不存在则通过oss拉取视频
   * 3. 渲染时需要保证radio和audio都存在 （todo 所以需要做拉取的回调接口
   * 4. orderId中type为1的启用gpu加速
   *
   * @param videoId
   *          需要合成的videoId
   */
  @Override
  public void addAudio(String videoId) {
    // todo oss中的video获取与拉取到本地的video路径
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

  /**
   * // 1. 人工上传的配音
   * // 2. tts合成的语音
   * 把音频文件路径更新到数据库中
   *
   * @param audioPath
   *          生成导出的音频路径
   */
  @Override
  public void uploadAudio(String audioPath) {

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
