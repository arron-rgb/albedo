package com.albedo.java.modules.tool.service.impl;

import static com.albedo.java.common.core.constant.CommonConstants.CAPTCHA_EXPIRES_TIME;
import static java.util.concurrent.TimeUnit.SECONDS;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.tool.domain.SmsEnum;
import com.albedo.java.modules.tool.service.SmsService;
import com.albedo.java.modules.tool.util.SmsSingleton;

import cn.hutool.core.util.RandomUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Service
@Slf4j
public class SmsServiceImpl implements SmsService {

  @Resource
  SmsSingleton smsSingleton;

  @Override
  public boolean validated(String key, String code) {
    Object value = RedisUtil.getCacheString(key);
    if (value == null || !value.toString().equals(code)) {
      return false;
    } else {
      return RedisUtil.delete(key);
    }
  }

  @Override
  public void sendMsg(String phone, String key, SmsEnum type) {
    String redisKey = key + phone;
    Object oldCode = RedisUtil.getCacheString(redisKey);
    if (oldCode == null) {
      oldCode = RandomUtil.randomNumbers(6);
      log.info("写入{}", oldCode);
      redisTemplate.opsForValue().set(redisKey, oldCode.toString(), CAPTCHA_EXPIRES_TIME, SECONDS);
      log.info("oldCode{}", oldCode.toString());
    }
    // JSONObject param = new JSONObject();
    // param.put("code", oldCode);
    // try {
    // smsSingleton.sendSms(phone, param, type);
    // } catch (ClientException e) {
    // throw new RuntimeException("发送短信失败");
    // }
  }

  @Resource
  RedisTemplate<String, String> redisTemplate;

}
