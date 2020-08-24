// package com.albedo.java.modules.tool.util;
//
// import com.alibaba.fastjson.JSONObject;
// import com.aliyuncs.DefaultAcsClient;
// import com.aliyuncs.IAcsClient;
// import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
// import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
// import com.aliyuncs.exceptions.ClientException;
// import com.aliyuncs.profile.DefaultProfile;
//
// import lombok.extern.slf4j.Slf4j;
//
// @Slf4j
// public class DySmsHelper {
//
// static String accessKeyId;
// static String accessKeySecret;
//
// static {
// accessKeyId = "";
// accessKeySecret = "";
// }
//
// public static boolean sendSms(String phone, JSONObject templateParamJson, DySmsEnum dySmsEnum)
// throws ClientException {
// // 可自助调整超时时间
// System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
// System.setProperty("sun.net.client.defaultReadTimeout", "10000");
//
// // 初始化acsClient,暂不支持region化
// DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
// IAcsClient acsClient = new DefaultAcsClient(profile);
//
// // 验证json参数
// validateParam(templateParamJson, dySmsEnum);
//
// // 组装请求对象-具体描述见控制台-文档部分内容
// SendSmsRequest request = new SendSmsRequest();
// // 必填:待发送手机号
// request.setPhoneNumbers(phone);
// // 必填:短信签名-可在短信控制台中找到
// request.setSignName(dySmsEnum.getSignName());
// // 必填:短信模板-可在短信控制台中找到
// request.setTemplateCode(dySmsEnum.getTemplateCode());
// // 可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
// request.setTemplateParam(templateParamJson.toJSONString());
//
// boolean result = false;
//
// // hint 此处可能会抛出异常，注意catch
// SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
// log.info("短信接口返回的数据----------------");
// log.info("{Code:" + sendSmsResponse.getCode() + ",Message:" + sendSmsResponse.getMessage() + ",RequestId:"
// + sendSmsResponse.getRequestId() + ",BizId:" + sendSmsResponse.getBizId() + "}");
// if ("OK".equals(sendSmsResponse.getCode())) {
// result = true;
// }
// return result;
//
// }
//
// private static void validateParam(JSONObject templateParamJson, DySmsEnum dySmsEnum) {
// String keys = dySmsEnum.getKeys();
// String[] keyArr = keys.split(",");
// for (String item : keyArr) {
// if (!templateParamJson.containsKey(item)) {
// throw new RuntimeException("模板缺少参数：" + item);
// }
// }
// }
//
// public static void main(String[] args) throws ClientException {
// JSONObject obj = new JSONObject();
// obj.put("code", "1234");
// String phone = "13800138000";
// sendSms(phone, obj, DySmsEnum.FORGET_PASSWORD_TEMPLATE_CODE);
// }
//
// }
