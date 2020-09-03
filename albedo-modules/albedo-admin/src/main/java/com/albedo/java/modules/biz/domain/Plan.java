package com.albedo.java.modules.biz.domain;

import java.math.BigDecimal;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * @author arronshentu
 */
@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@TableName("t_plan")
@EqualsAndHashCode(callSuper = true)
public class Plan extends IdEntity<Plan> {
  /**
   * 套餐价格
   */
  BigDecimal price;
  /**
   * 商品数量
   */
  Integer goodsQuantity;
  /**
   * 单条视频时长上限
   */
  Integer videoTime;
  /**
   * 子账户个数
   */
  Integer childAccount;
  /**
   * 可修改次数
   */
  Integer editTime;
  /**
   * 账号存储空间，子账号共享，可存储空间 单位GB
   */
  Integer storage;
  /**
   * 保留历史版本数量
   */
  Integer history;
  /**
   * 虚拟人物选项个数
   */
  Integer anchorAmount;
  /**
   * 虚拟场景选项个数
   */
  Integer envAmount;
  /**
   * 定制版虚拟人物选项个数
   */
  Integer anchorAmountPlus;
  /**
   * 定制版虚拟场景选项个数
   */
  Integer envAmountPlus;
  /**
   * 可下单次数
   */
  Integer times;
  /**
   * 套餐名
   */
  String name;
}
