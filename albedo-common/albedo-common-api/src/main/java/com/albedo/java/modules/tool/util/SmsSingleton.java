package com.albedo.java.modules.tool.util;

import static com.albedo.java.common.core.constant.BusinessConstants.ALIBABA_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.ALIBABA_SECRET;
import static com.albedo.java.common.core.constant.CommonConstants.ok;

import org.springframework.stereotype.Component;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.modules.tool.domain.SmsEnum;
import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.profile.DefaultProfile;

import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Component
@Slf4j
public class SmsSingleton {

  ApplicationProperties applicationProperties;

  public SmsSingleton(ApplicationProperties applicationProperties) {
    this.applicationProperties = applicationProperties;
    String accessKeyId = applicationProperties.getKey(ALIBABA_ID);
    String accessKeySecret = applicationProperties.getKey(ALIBABA_SECRET);
    DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
    ACS_CLIENT = new DefaultAcsClient(profile);
  }

  private final IAcsClient ACS_CLIENT;

  public boolean sendSms(String phone, JSONObject templateParamJson, SmsEnum smsEnum) throws ClientException {
    // 可自助调整超时时间
    System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
    System.setProperty("sun.net.client.defaultReadTimeout", "10000");
    validateParam(templateParamJson, smsEnum);
    SendSmsRequest request = new SendSmsRequest();
    request.setPhoneNumbers(phone);
    request.setSignName(smsEnum.getSignName());
    request.setTemplateCode(smsEnum.getTemplateCode());
    request.setTemplateParam(templateParamJson.toJSONString());

    boolean result = false;

    SendSmsResponse res = ACS_CLIENT.getAcsResponse(request);
    if (ok.equals(res.getCode())) {
      result = true;
    }
    return result;
  }

  private void validateParam(JSONObject templateParamJson, SmsEnum smsEnum) {
    String keys = smsEnum.getKeys();
    String[] keyArr = keys.split(",");
    for (String item : keyArr) {
      if (!templateParamJson.containsKey(item)) {
        throw new RuntimeException("模板缺少参数：" + item);
      }
    }
  }

}
