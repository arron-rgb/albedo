package com.albedo.java.modules.tool.service;

import com.albedo.java.modules.tool.util.DySmsEnum;

/**
 * @author arronshentu
 */
public interface SmsService {

  void validated(String key, String code);

  void sendMsg(String phone, String key, DySmsEnum type);
}
