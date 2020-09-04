package com.albedo.java.modules.biz.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.Version;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author arronshentu
 */
@Data
@Builder
@TableName("t_balance")
@EqualsAndHashCode
public class Balance {

  @TableId
  private String userId;
  private Integer times;
  @Version
  private Integer version;
  private Integer accountAvailable;
  /**
   * 存储空间单位 GB
   */
  private Double storage;

}
