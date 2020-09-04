package com.albedo.java.modules.biz.domain;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
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
  private String name;
  private String originUrl;
  private String logoUrl;
  private String outputUrl;
  private Integer duration;
}
