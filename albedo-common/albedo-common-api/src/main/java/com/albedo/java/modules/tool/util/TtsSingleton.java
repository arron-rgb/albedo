package com.albedo.java.modules.tool.util;

import static com.albedo.java.common.core.constant.BusinessConstants.TENCENT_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.TENCENT_SECRET;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Component;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.exception.TencentCloudSDKException;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;
import com.tencentcloudapi.tts.v20190823.TtsClient;
import com.tencentcloudapi.tts.v20190823.models.TextToVoiceRequest;
import com.tencentcloudapi.tts.v20190823.models.TextToVoiceResponse;

import cn.hutool.core.codec.Base64;
import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Component
@Slf4j
public class TtsSingleton {

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

  public File generateRadio(String params, String filePath) throws TencentCloudSDKException {
    TextToVoiceRequest req = TextToVoiceRequest.fromJsonString(params, TextToVoiceRequest.class);
    TextToVoiceResponse resp = client.TextToVoice(req);
    System.out.println(TextToVoiceResponse.toJsonString(resp));
    File outFile = new File(filePath);
    return decoderBase64File(resp.getAudio(), outFile);
  }

}
