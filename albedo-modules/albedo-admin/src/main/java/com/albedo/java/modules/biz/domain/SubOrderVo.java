package com.albedo.java.modules.biz.domain;

import java.util.List;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @author arronshentu
 */

@Data
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class SubOrderVo {
  private transient String contentText;
  private List<String> content;
  private String description;
  /**
   * 订单id
   */
  @NotNull(message = "请提交订单编号")
  private String orderId;
  /**
   * 视频时长
   */
  private Long duration;
  /**
   * 配音方式 0上传 1下单 2合成
   */
  @NotNull(message = "请选择配音方式")
  private Integer type;
  /**
   * 音色
   */
  private List<String> voiceType;
  /**
   * 音频链接
   */
  private String audioUrl;

  /**
   * 人工下单的订单金额
   */
  private String totalAmount;

  public String appendContent() {
    StringBuilder stringBuilder = new StringBuilder();
    for (String text : getContent()) {
      stringBuilder.append(text);
    }
    return stringBuilder.toString();
  }
}
