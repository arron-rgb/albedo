package com.albedo.java.modules.tool.util;

import static com.albedo.java.common.core.constant.CommonConstants.ok;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.profile.DefaultProfile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SmsSingleton {

  private static final String ACCESS_KEY_ID = "LTAI4G9GELKL2AM8BxufjLUE";
  private static final String ACCESS_KEY_SECRET = "usIxuCax2SM5cQ6uDnNBZ1CARpbuhg";
  private static final DefaultProfile PROFILE =
    DefaultProfile.getProfile("cn-hangzhou", ACCESS_KEY_ID, ACCESS_KEY_SECRET);
  private static final IAcsClient ACS_CLIENT = new DefaultAcsClient(PROFILE);

  public static boolean sendSms(String phone, JSONObject templateParamJson, DySmsEnum dySmsEnum)
    throws ClientException {
    // 可自助调整超时时间
    System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
    System.setProperty("sun.net.client.defaultReadTimeout", "10000");
    validateParam(templateParamJson, dySmsEnum);
    SendSmsRequest request = new SendSmsRequest();
    request.setPhoneNumbers(phone);
    request.setSignName(dySmsEnum.getSignName());
    request.setTemplateCode(dySmsEnum.getTemplateCode());
    request.setTemplateParam(templateParamJson.toJSONString());

    boolean result = false;

    // hint 此处可能会抛出异常，注意catch
    SendSmsResponse res = ACS_CLIENT.getAcsResponse(request);
    log.info(JSON.toJSONString(res));
    if (ok.equals(res.getCode())) {
      result = true;
    }
    return result;
  }

  private static void validateParam(JSONObject templateParamJson, DySmsEnum dySmsEnum) {
    String keys = dySmsEnum.getKeys();
    String[] keyArr = keys.split(",");
    for (String item : keyArr) {
      if (!templateParamJson.containsKey(item)) {
        throw new RuntimeException("模板缺少参数：" + item);
      }
    }
  }

  public static void main(String[] args) throws ClientException {
    JSONObject obj = new JSONObject();
    obj.put("code", "1234");
    String phone = "13346161445";
    sendSms(phone, obj, DySmsEnum.REGISTER_TEMPLATE_CODE);
  }

}
