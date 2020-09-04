package com.albedo.java.common.core.aspect;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.data.redis.core.RedisTemplate;

import com.albedo.java.common.core.exception.TokenException;
import com.albedo.java.common.core.util.RequestHolder;

import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Aspect
@Slf4j
public class TokenAspect {

  @Resource
  RedisTemplate<String, String> redisTemplate;

  @Around("@annotation(tokenOperate)")
  public Object around(ProceedingJoinPoint point, com.albedo.java.common.core.annotation.Token tokenOperate)
    throws TokenException {
    HttpServletRequest request = RequestHolder.getHttpServletRequest();
    String token = request.getParameter("token");
    if (StringUtils.isEmpty(token)) {
      throw new TokenException("拒绝请求");
    }
    log.info("token: " + token);

    if (verify(token)) {
      throw new TokenException("无效请求");
    }

    Boolean delete = redisTemplate.delete(token);
    if (delete == null || !delete) {
      throw new TokenException("删除失败");
    }
    try {
      return point.proceed();
    } catch (Throwable throwable) {
      throwable.printStackTrace();
      throw new RuntimeException("未知错误");
    }
  }

  private Boolean verify(String key) {
    String value = redisTemplate.opsForValue().get(key);
    return StringUtils.isEmpty(value);
  }
}
