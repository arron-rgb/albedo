package com.albedo.java.modules.biz.domain;

import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * @author arronshentu
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@TableName("t_script")
public class Script {
  private String id;
  private String value;
  private String title;
}
