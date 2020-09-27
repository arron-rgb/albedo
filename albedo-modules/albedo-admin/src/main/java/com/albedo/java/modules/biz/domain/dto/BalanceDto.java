package com.albedo.java.modules.biz.domain.dto;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @author arronshentu
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode
public class BalanceDto {

  /**
   * 子账户数量
   */
  private Integer accountAvailable;
  /**
   * 子账户容量
   */
  private Integer accountAmount;
  /**
   * 子账户list
   */
  private List<String> accountIds;
  /**
   * 存储空间单位 GB
   */
  private Double storage;
  /**
   * 空间容量
   */
  private Double allowedStorage;
  /**
   * 剩余可下单次数
   */
  private Integer times;
  /**
   * 现有商品数量
   */
  private Integer commodity;
  /**
   * 允许上传商品数量
   */
  private Integer allowedCommodity;
  /**
   * 购买的套餐名
   */
  private String planName;
  /**
   * 可修改次数
   * 订单上传视频后，反馈员工可重做
   */
  private Integer editTimes;

  /**
   * 人工专属配音 抵扣配音订单金额
   */
  private Integer audioTime;
  private Integer videoTime;
}
