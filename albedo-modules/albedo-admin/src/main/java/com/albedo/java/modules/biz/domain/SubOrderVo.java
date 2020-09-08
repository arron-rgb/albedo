package com.albedo.java.modules.biz.domain;

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
   * 水印
   */
  private String logoUrl;
  /**
   * 贴片
   */
  private String adUrl;

  /**
   * 订单id
   */
  private String orderId;

  /**
   * 视频时长
   */
  private Long time;
  /**
   * 配音方式 下单 上传 合成
   */
  private int type;
  // 上传 合成 都需要提供商品及串词列表

  private String audioUrl;
}
