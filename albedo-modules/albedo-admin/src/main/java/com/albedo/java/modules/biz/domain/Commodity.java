package com.albedo.java.modules.biz.domain;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * @author arronshentu
 */

@Data
@Builder
@TableName("t_commodity")
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class Commodity extends IdEntity<Commodity> {

  private String name;
  /**
   * 图片路径，但只有一张图片
   */
  private String urls;

}
