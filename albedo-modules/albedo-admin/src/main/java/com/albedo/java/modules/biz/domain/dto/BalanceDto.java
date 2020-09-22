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

  // 4、商品库容量及余量
  // 5、用户类型（普通用户、升级版套餐用户、旗舰版套餐用户）

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

}
