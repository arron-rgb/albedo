package com.albedo.java.common.core.resource;

import java.time.Duration;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cn.hutool.core.util.IdUtil;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;

/**
 * @author arronshentu
 */

@RestController
@RequestMapping(value = "${application.admin-path}/token")
@AllArgsConstructor
@Api(tags = "Token")
public class TokenResource {
  @Resource
  RedisTemplate<String, String> redisTemplate;

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
