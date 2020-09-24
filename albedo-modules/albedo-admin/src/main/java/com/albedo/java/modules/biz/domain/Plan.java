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
public class Plan extends IdEntity<Plan> implements Comparable<Plan> {
  /**
   * 套餐名
   *
   */
  String name;
  /**
   * 套餐价格
   */
  BigDecimal price;
  /**
   * 可下单次数
   */
  Integer times;
  /**
   * 可修改次数
   * 订单上传视频后，反馈员工可重做
   */
  Integer editTime;
  /**
   * 商品数量
   */
  Integer goodsQuantity;
  /**
   * 人工专属配音抵扣配音订单金额
   */
  Integer audioTime;
  /**
   * 子账户个数
   */
  Integer childAccount;
  /**
   * 账号存储空间，子账号共享，可存储空间 单位GB
   */
  Integer storage;
  /**
   * 单条视频时长上限
   */
  Integer videoTime;
  /**
   * 排序依据
   */
  Integer orderBy;

  @Override
  public int compareTo(Plan plan) {
    return this.orderBy.compareTo(plan.orderBy);
  }
}
