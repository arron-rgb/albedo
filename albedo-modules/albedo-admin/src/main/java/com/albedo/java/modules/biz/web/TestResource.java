package com.albedo.java.modules.biz.web;

import java.time.Duration;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.Token;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.web.resource.BaseResource;

import cn.hutool.core.util.IdUtil;
import lombok.AllArgsConstructor;

/**
 * @author arronshentu
 */
@RestController
@RequestMapping(value = "${application.admin-path}/test")
@AllArgsConstructor
public class TestResource extends BaseResource {

  @Resource
  RedisTemplate<String, String> redisTemplate;

  @PostMapping
  @Token
  public Result<String> test(@RequestParam(value = "orderId") String orderId) {
    return Result.buildOk("orderId: " + orderId + "\ntoken: ");
  }

  @GetMapping
  public String get() {
    String token = IdUtil.fastSimpleUUID();
    redisTemplate.opsForValue().set(token, token);
    String memory = redisTemplate.opsForValue().get(token);
    if (!token.equals(memory)) {
      throw new RuntimeException("token获取错误");
    }
    Boolean expire = redisTemplate.expire(token, Duration.ofMinutes(5L));
    return token;
  }

}
