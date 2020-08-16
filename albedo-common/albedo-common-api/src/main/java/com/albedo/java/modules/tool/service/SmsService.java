package com.albedo.java.modules.tool.service;

/**
 * @author arronshentu
 */
public interface SmsService {

  void validated(String key, String code);

  void sendMsg(String phone, String key);
}
