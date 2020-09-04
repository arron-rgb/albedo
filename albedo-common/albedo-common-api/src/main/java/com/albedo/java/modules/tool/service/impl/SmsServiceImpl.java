package com.albedo.java.modules.tool.service.impl;

import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.tool.domain.SmsEnum;
import com.albedo.java.modules.tool.service.SmsService;
import com.albedo.java.modules.tool.util.SmsSingleton;
import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.exceptions.ClientException;

import cn.hutool.core.util.RandomUtil;

/**
 * @author arronshentu
 */
@Service
public class SmsServiceImpl implements SmsService {

  @Resource
  SmsSingleton smsSingleton;

  @Override
  public void validated(String key, String code) {
    Object value = RedisUtil.getCacheString(key);
    if (value == null || !value.toString().equals(code)) {
      throw new BadRequestException("无效验证码");
    } else {
      RedisUtil.delete(key);
    }
  }

  @Override
  public void sendMsg(String phone, String key, SmsEnum type) {
    String redisKey = key + phone;
    Object oldCode = RedisUtil.getCacheString(redisKey);
    if (oldCode == null) {
      String code = RandomUtil.randomNumbers(6);
      RedisUtil.setCacheString(redisKey, code, CommonConstants.CAPTCHA_EXPIRES_TIME, TimeUnit.SECONDS);
      oldCode = code;
    }
    JSONObject param = new JSONObject();
    param.put("code", oldCode);
    try {
      smsSingleton.sendSms(phone, param, type);
    } catch (ClientException e) {
      throw new RuntimeException("发送短信失败");
    }
  }

}
