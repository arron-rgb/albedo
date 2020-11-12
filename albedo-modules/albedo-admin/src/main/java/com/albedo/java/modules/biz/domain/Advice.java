package com.albedo.java.modules.biz.domain;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @author arronshentu
 */
@Data
@Builder
@ToString
@TableName("t_advice")
@EqualsAndHashCode(callSuper = true)
public class Advice extends IdEntity<Advice> {

  private String status;
  private String content;
  private String orderId;

}
