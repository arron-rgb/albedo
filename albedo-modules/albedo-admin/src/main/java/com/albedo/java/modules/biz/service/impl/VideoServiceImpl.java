package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.BUSINESS_COMMON_ROLE_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.ORDER_STATE_3;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
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
import com.aliyun.oss.model.PutObjectResult;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

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
  public void uploadVideoToOss() {
    ossSingleton.uploadFile(null, "", "vlivest");
  }

  @Override
  public boolean storageState() {
    // 以下语义类似 1为已使用空间 2为剩余量 3如何获取购买套餐记录使其与使用量/剩余量绑定
    // long storage = ossSingleton.getBucketStorage("");
    // Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", ""));
    //
    return false;
  }

  /**
   * 每个企业/个人默认一个bucket，命名按企业id或个人id命名
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
    // 没bucket的话 storage也不会被调用
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    Double storageSize = balance.getStorage();
    if (!ossSingleton.doesBucketExist(userId)) {
      ossSingleton.create(userId, storageSize.intValue());
    }
  }

  @Override
  public void uploadVideo(String orderId, MultipartFile file) throws IOException {
    // 更新订单状态
    Order order = orderService.getById(orderId);
    order.setState(ORDER_STATE_3);
    // 上传视频至oss
    String userId = order.getUserId();
    Balance balance = balanceService.getOne(Wrappers.<Balance>query().eq("user_id", userId));
    // 更新使用状况 单位以GB为基准
    double storage = balance.getStorage() - ((double)file.getSize() / 1073741824);
    // 存储空间不足
    if (storage < 0) {
      return;
    }
    balance.setStorage(storage);
    if (!ossSingleton.doesBucketExist(userId)) {
      createBucket(userId);
    }
    InputStream inputStream = file.getInputStream();
    // 保存视频记录至数据库
    Video video = Video.builder().userId(userId).orderId(orderId).build();
    baseMapper.insert(video);
    order.setVideoId(video.getId());
    orderService.updateById(order);
    PutObjectResult result = ossSingleton.uploadFileStream(inputStream, video.getId(), userId);
    balanceService.updateById(balance);

  }

}
