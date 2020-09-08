package com.albedo.java.modules.biz.domain;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * @author arronshentu
 */
@Data
@Builder
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@TableName("t_config")
public class Config {
  @TableId(type = IdType.AUTO)
  private Integer id;
  /**
   * 标签名
   */
  @JSONField(serialize = false)
  private String title;
  /**
   * 标签值
   */
  private String value;
  /**
   * 图片链接
   */
  private String url;
  /**
   * 0为普通 1为增值服务
   */
  @JSONField(serialize = false)
  private String type;
}
