package com.albedo.java.modules.biz.domain;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * 订单对应的产出视频
 *
 * @author arronshentu
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@TableName("t_video")
@EqualsAndHashCode(callSuper = true)
public class Video extends IdEntity<Video> {
  private String orderId;
  private String userId;
  private String outputUrl;
  private String audioUrl;
  private String audioText;
  private Integer dubType;
  private String voiceType;

  /**
   * 插入后设为 等待配音
   * 加入队列后 配音中
   * 执行完毕 配音结束
   */
  @TableField(exist = false)
  private String status;
}
