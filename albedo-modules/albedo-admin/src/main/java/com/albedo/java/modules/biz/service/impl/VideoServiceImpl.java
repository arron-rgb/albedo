package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.BUSINESS_COMMON_ROLE_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.PRODUCTION_COMPLETED;
import static com.albedo.java.common.core.constant.ExceptionNames.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.function.Supplier;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.core.util.FileUploadUtil;
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
import com.aliyun.oss.event.ProgressEvent;
import com.aliyun.oss.event.ProgressEventType;
import com.aliyun.oss.event.ProgressListener;
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
  @Async
  @Transactional(rollbackFor = Exception.class)
  public void uploadVideo(String orderId, MultipartFile file) throws IOException {
    // 更新订单状态
    Order order = orderService.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    String userId = order.getUserId();
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    // 更新使用状况 单位以GB为基准
    Assert.notNull(balance, EMPTY_STORAGE);
    double storage = balance.getStorage() - ((double)file.getSize() / 1073741824);
    // 存储空间不足
    Assert.isTrue(storage > 0, STORAGE_NOT_SATISFIED);
    balance.setStorage(storage);
    String bucketName = userId;
    // userId不符合bucket命名规范，则用uuid当bucketName
    // 并且将其更新到qqOpenId字段上
    if (!OSSUtils.validateBucketName(bucketName)) {
      User user = userService.getById(userId);
      // 因此 只要符合 userId不符合命名规范 并且 qqOpenId为空的用户 就是没有bucket 所以需要创建
      bucketName = StringUtils.isEmpty(user.getQqOpenId()) ? createBucket(userId) : user.getQqOpenId();
    }
    InputStream inputStream = file.getInputStream();
    // 保存视频记录至数据库
    String extension = FileUploadUtil.getExtension(file);
    Video video = Video.builder().userId(userId).orderId(orderId).build();
    baseMapper.insert(video);
    video.setName(video.getId() + "." + extension);
    order.setState(PRODUCTION_COMPLETED);
    order.setVideoId(video.getId());
    orderService.updateById(order);
    // 上传视频至oss video命名规则: 数据库中的id+.格式
    // video存储规则:
    // 本地：./upload/bucketName/文件名
    // oss: ./bucketName/文件名
    ossSingleton.uploadFileStream(inputStream, bucketName, video.getName());
    baseMapper.updateById(video);
    balanceService.updateById(balance);

  }

  private static final String PATH = System.getenv("PWD");
  private static final String SEPARATOR = File.separator;

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
    String outPut = PATH + SEPARATOR + "result.mp4";
    video.setOutputUrl("");
    checkIfFileExist(video);
    video.setOutputUrl(outPut);
  }

  private String getLocalPath(Video video) {
    String bucketName = video.getUserId();
    bucketName = userService.getBucketName(bucketName);
    // todo 再加一个母层级统一管理文件
    return bucketName + File.separator + video.getName();
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
    File file = new File(getLocalPath(video));
    if (!file.exists()) {
      // 下载完成后再执行addAudio的逻辑
      ossSingleton.downloadFile(bucketName, video.getName(), getLocalPath(video),
        new GetObjectProgressListener(video).setFunction(() -> {
          VideoEncodeTask event = new VideoEncodeTask(video);
          SpringContextHolder.publishEvent(event);
          return event.getStatus();
        }));
    } else {
      SpringContextHolder.publishEvent(new VideoEncodeTask(video));
    }
  }

  static class GetObjectProgressListener implements ProgressListener {

    private long bytesRead = 0;
    private long totalBytes = -1;
    private boolean succeed = false;

    private final Video video;

    private Supplier<String> function;

    public GetObjectProgressListener(Video video) {
      this.video = video;
    }

    public GetObjectProgressListener setFunction(Supplier<String> function) {
      this.function = function;
      return this;
    }

    @Override
    public void progressChanged(ProgressEvent progressEvent) {
      long bytes = progressEvent.getBytes();
      ProgressEventType eventType = progressEvent.getEventType();
      switch (eventType) {
        case TRANSFER_STARTED_EVENT:
          System.out.println("Start to download......");
          break;

        case RESPONSE_CONTENT_LENGTH_EVENT:
          this.totalBytes = bytes;
          System.out.println(this.totalBytes + " bytes in total will be downloaded to a local file");
          break;

        case RESPONSE_BYTE_TRANSFER_EVENT:
          this.bytesRead += bytes;
          if (this.totalBytes != -1) {
            int percent = (int)(this.bytesRead * 100.0 / this.totalBytes);
            System.out.println(bytes + " bytes have been read at this time, download progress: " + percent + "%("
              + this.bytesRead + "/" + this.totalBytes + ")");
          } else {
            System.out.println(
              bytes + " bytes have been read at this time, download ratio: unknown" + "(" + this.bytesRead + "/...)");
          }
          break;

        case TRANSFER_COMPLETED_EVENT:
          this.succeed = true;
          this.function.get();
          break;
        case TRANSFER_FAILED_EVENT:
          // todo 失败通知？重试？
          break;
        default:
          break;
      }
    }

    public boolean isSucceed() {
      return succeed;
    }
  }
}
