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
  private String value;
  private String name;
  private String url;
  @JSONField(serialize = false)
  private String type;
}
