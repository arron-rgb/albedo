package com.albedo.java.modules.biz.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.Version;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author arronshentu
 */
@TableName("t_balance")
@Data
@EqualsAndHashCode
public class Balance {

  private String userId;
  private Integer times;

  @Version
  private Integer version;

}