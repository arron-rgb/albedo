package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;

import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
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
    // userId应该是通过订单获取，视频是由工作人员上传的
    List<String> roleIds = userService.findUserVoById(userId).getRoleIdList();
    // if (roleIds.contains(PERSONAL_USER_ROLE_ID)) {
    // }
    if (roleIds.contains(BUSINESS_ADMIN_ROLE_ID) || roleIds.contains(BUSINESS_COMMON_ROLE_ID)) {
      // userId = userService.getOutTradeNosByUserId(userId);
    }
    // todo 通过userId去购买记录里查
    int storageSize = 1;
    if (!ossSingleton.doesBucketExist(userId)) {
      ossSingleton.create(userId, storageSize);
    }
  }

  @Override
  public void uploadVideo(String orderId, InputStream inputStream) {
    // 更新订单状态
    Order order = orderService.getById(orderId);
    order.setState(ORDER_STATE_3);
    // 上传视频至oss
    String userId = order.getUserId();
    // 保存视频记录至数据库
    Video video = Video.builder().userId(userId).orderId(orderId).build();
    baseMapper.insert(video);
    order.setVideoId(video.getId());
    orderService.updateById(order);
    PutObjectResult result = ossSingleton.uploadFileStream(inputStream, video.getId(), userId);
  }
}
