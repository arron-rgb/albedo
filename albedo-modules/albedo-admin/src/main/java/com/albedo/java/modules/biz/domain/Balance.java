package com.albedo.java.modules.biz.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.Version;
import com.baomidou.mybatisplus.extension.activerecord.Model;

import lombok.*;

/**
 * @author arronshentu
 */
@Data
@Builder
@TableName("t_balance")
@EqualsAndHashCode(callSuper = true)
@AllArgsConstructor
@NoArgsConstructor
public class Balance extends Model<Balance> {

  @TableId
  private String userId;
  /**
   * 剩余可下单次数
   */
  private Integer times;
  /**
   * 定制次数
   */
  private Integer customTimes;
  /**
   * 可修改次数
   * 订单上传视频后，反馈员工可重做
   */
  private Integer editTimes;
  /**
   * 剩余可创建的子账户数量
   */
  private Integer childAccount;
  /**
   * 存储空间单位 GB
   */
  private Double storage;
  /**
   * 现有商品数量
   */
  private Integer goodsQuantity;
  /**
   * 人工专属配音抵扣配音订单金额
   */
  private Integer audioTime;
  /**
   * 单条视频时长上限
   */
  private Integer videoTime;

  /**
   * 授权时间
   */
  private Integer licenseDuration;
  /**
   * 套餐类型
   */
  private String planType;
  /**
   * 套餐id
   */
  private String planId;

  @Version
  private Integer version;

}
