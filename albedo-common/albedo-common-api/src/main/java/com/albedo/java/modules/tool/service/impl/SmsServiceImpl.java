package com.albedo.java.modules.tool.service.impl;

import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Service;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.tool.service.SmsService;
import com.albedo.java.modules.tool.util.SmsEnum;
import com.albedo.java.modules.tool.util.SmsSingleton;
import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.exceptions.ClientException;

import cn.hutool.core.util.RandomUtil;

/**
 * @author arronshentu
 */
@Service
public class SmsServiceImpl implements SmsService {

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
      SmsSingleton.sendSms(phone, param, type);
    } catch (ClientException e) {
      e.printStackTrace();// todo
    }
  }

}
