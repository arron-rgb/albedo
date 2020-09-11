package com.albedo.java.modules.biz.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.Token;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.aliyun.oss.model.Bucket;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * @author arronshentu
 */
@RestController
@RequestMapping(value = "${application.admin-path}/test")
@AllArgsConstructor
@Api("测试")
public class TestResource extends BaseResource {

  @Resource
  RedisTemplate<String, String> redisTemplate;

  @PostMapping
  @Token
  @ApiOperation("token过滤")
  public Result<String> test(@RequestParam(value = "orderId") String orderId) {
    return Result.buildOk("orderId: " + orderId + "\ntoken: ");
  }

  @GetMapping
  @ApiOperation("更新")
  public String update(String videoId) {
    videoService.addAudio(videoId);
    return "任务发布成功";
  }

  @GetMapping("/bucket")
  public Result<String> getUserBucket() {
    return Result.buildOk(userService.getBucketName(SecurityUtil.getUser().getId()));
  }

  @GetMapping("/bucket/list")
  public Result<List<Bucket>> listBuckets() {
    List<Bucket> buckets = ossSingleton.listBuckets();
    return Result.buildOkData(buckets);
  }

  @Resource
  OssSingleton ossSingleton;
  @Resource
  UserService userService;
  @Resource
  VideoService videoService;

}
