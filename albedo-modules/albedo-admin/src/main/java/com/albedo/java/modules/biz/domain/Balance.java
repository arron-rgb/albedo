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
  /**
   * 剩余可下单次数
   */
  private Integer times;
  @Version
  private Integer version;
  /**
   * 子账户数量
   */
  private Integer accountAvailable;
  /**
   * 存储空间单位 GB
   */
  private Double storage;
  /**
   * 现有商品数量
   */
  private Integer commodity;
  /**
   * 套餐类型
   */
  private String planType;
  /**
   * 套餐id
   */
  private String planId;

}
