package com.albedo.java.modules.biz.domain;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * @author arronshentu
 */
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@TableName("t_dub")
public class Dub extends IdEntity<Dub> {

  private String id;
  private String title;
  private String value;

}
