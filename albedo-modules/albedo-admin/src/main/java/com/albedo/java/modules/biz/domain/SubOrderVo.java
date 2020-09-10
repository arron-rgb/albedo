package com.albedo.java.modules.biz.domain;

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
  private String content;
  private String description;
  /**
   * 订单id
   */
  @NotNull(message = "请提交订单编号")
  private String orderId;
  /**
   * 视频时长
   */
  private Long time;
  /**
   * 配音方式 下单 上传 合成
   */
  private int type;
  /**
   * 音频链接
   */
  private String audioUrl;
  /**
   * 水印
   */
  private String logoUrl;
  /**
   * 贴片
   */
  private String adUrl;
}
