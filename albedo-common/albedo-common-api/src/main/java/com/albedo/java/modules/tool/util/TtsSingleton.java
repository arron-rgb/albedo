package com.albedo.java.modules.tool.util;

import static com.albedo.java.common.core.constant.BusinessConstants.TENCENT_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.TENCENT_SECRET;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Component;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.exception.TencentCloudSDKException;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;
import com.tencentcloudapi.tts.v20190823.TtsClient;
import com.tencentcloudapi.tts.v20190823.models.TextToVoiceRequest;
import com.tencentcloudapi.tts.v20190823.models.TextToVoiceResponse;

import cn.hutool.core.codec.Base64;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Component
@Slf4j
public class TtsSingleton {

  private List<String> voiceType =
    new ArrayList<>(Arrays.asList("0", "1", "2", "4", "5", "6", "7", "1000", "1001", "1002", "1003"));

  ApplicationProperties applicationProperties;

  private final TtsClient client;

  public TtsSingleton(ApplicationProperties applicationProperties) {
    this.applicationProperties = applicationProperties;
    String secretId = applicationProperties.getKey(TENCENT_ID);
    String secretKey = applicationProperties.getKey(TENCENT_SECRET);
    Credential cred = new Credential(secretId, secretKey);
    HttpProfile httpProfile = new HttpProfile();
    String endpoint = "tts.tencentcloudapi.com";
    httpProfile.setEndpoint(endpoint);
    ClientProfile clientProfile = new ClientProfile();
    clientProfile.setHttpProfile(httpProfile);
    String region = "ap-shanghai";
    client = new TtsClient(cred, region, clientProfile);
  }

  private File decoderBase64File(String base64Str, File tempFile) {
    try (FileOutputStream outputStream = new FileOutputStream(tempFile)) {
      byte[] audioByte = Base64.decode(base64Str);
      outputStream.write(audioByte, 0, audioByte.length);
      outputStream.flush();
    } catch (IOException e) {
      e.printStackTrace();
    }
    return tempFile;
  }

  public File generateAudio(String params, String filePath) throws TencentCloudSDKException {
    TextToVoiceRequest req = TextToVoiceRequest.fromJsonString(params, TextToVoiceRequest.class);
    TextToVoiceResponse resp = client.TextToVoice(req);
    System.out.println(TextToVoiceResponse.toJsonString(resp));
    File outFile = new File(filePath);
    return decoderBase64File(resp.getAudio(), outFile);
  }

  public File generateAudio(Params params, String filePath) throws TencentCloudSDKException {
    return generateAudio(params.toString(), filePath);
  }

  @Data
  @Builder
  @EqualsAndHashCode
  static class Params {
    @JSONField(name = "Text")
    String text;
    @JSONField(name = "SessionId")
    String sessionId;
    @JSONField(name = "ModelType")
    String modelType;
    /**
     * 0-云小宁，亲和女声(默认)
     * 1-云小奇，亲和男声
     * 2-云小晚，成熟男声
     * 4-云小叶，温暖女声
     * 5-云小欣，情感女声
     * 6-云小龙，情感男声
     * 7-云小曼，客服女声
     * 1000-智侠，情感男声
     * 1001-智瑜，情感女声
     * 1002-智聆，通用女声
     * 1003-智美，客服女声
     */
    @JSONField(name = "VoiceType")
    String voiceType;
    /**
     * Float
     * 音量大小，范围：[0，10]，分别对应11个等级的音量，默认为0，代表正常音量。没有静音选项。
     * 输入除以上整数之外的其他参数不生效，按默认值处理。
     */
    String volume;
    /**
     * 语速，范围：[-2，2]，分别对应不同语速：
     * -2代表0.6倍
     * -1代表0.8倍
     * 0代表1.0倍（默认）
     * 1代表1.2倍
     * 2代表1.5倍
     * 如果需要更细化的语速，可以保留小数点后一位，例如0.5 1.1 1.8等。
     */
    String speed;
    @JSONField(name = "Codec")
    String codec;

    @Override
    public String toString() {
      return JSON.toJSONString(this);
    }
  }
}
