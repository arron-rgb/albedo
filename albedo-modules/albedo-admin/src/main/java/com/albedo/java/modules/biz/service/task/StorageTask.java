package com.albedo.java.modules.biz.service.task;

import java.util.List;

import javax.annotation.Resource;

import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

/**
 * @author arronshentu
 */
public class StorageTask {

  @Resource
  OssSingleton ossSingleton;
  @Resource
  UserService userService;
  @Resource
  OrderService orderService;
  @Resource
  VideoService videoService;

  void updateStorage() {
    List<User> users = userService.list();
    users.forEach(user -> {
      String userId = user.getId();
      String bucketName = userService.getBucketName(userId);
      List<Video> videos = videoService.list(Wrappers.<Video>lambdaQuery().eq(Video::getUserId, userId));
      // 1. 清除不在video中的记录
      ossSingleton.getBucketStorage(bucketName);
      // 2. 更新存储量
    });
  }

  void updateVideo() {
    String videoId = "";
    videoService.addAudio("");
  }
}
