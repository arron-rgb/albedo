package com.albedo.java.modules.tool.domain;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author arronshentu
 */
@Data
@Builder
@AllArgsConstructor
@EqualsAndHashCode
public class TtsParams {
  @JSONField(name = "Text")
  String text;
  @JSONField(name = "SessionId")
  String sessionId;
  @JSONField(name = "ModelType")
  String modelType = "1";
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
  // String version;
  // String region;

  @Override
  public String toString() {
    return JSON.toJSONString(this);
  }

  public TtsParams() {
    codec = "mp3";
    // modelType = "1";
    // Action 是 String 公共参数，本接口取值：TextToVoice。
    // version = "2019-08-23";
    // region = "ap-shanghai";
  }
}
