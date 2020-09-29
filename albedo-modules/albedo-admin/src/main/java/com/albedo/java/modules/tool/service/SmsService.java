package com.albedo.java.modules.tool.service;

import com.albedo.java.modules.tool.domain.SmsEnum;

/**
 * @author arronshentu
 */
public interface SmsService {

  /**
   * 验证code是否有效
   *
   * @param key
   *          redis中的key
   * @param code
   *          redis中的value
   */
  boolean validated(String key, String code);

  /**
   * 发送消息
   *
   * @param phone
   *          手机号
   * @param key
   *          redis中的key
   * @param type
   *          发送类型 找回密码or注册
   */
  void sendMsg(String phone, String key, SmsEnum type);
}
