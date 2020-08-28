/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 表单Entity OrderForm
 *
 * @author admin
 * @version 2020-08-18 10:19:40
 */
@TableName(value = "t_order_form")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class OrderForm extends IdEntity<OrderForm> {

  private static final long serialVersionUID = 1L;
  /** F_LABELS labels : 标签文本 */
  public static final String F_LABELS = "labels";
  public static final String F_USERID = "userId";
  public static final String F_ANCHOR_NUM = "anchorNum";
  public static final String F_SEAT = "seat";
  public static final String F_ANCHOR_TYPE = "anchorType";
  public static final String F_PLUS_SERVICE = "plusService";

  /** labels 标签文本 */
  @NotBlank
  @Size(max = 65535)
  private String labels;
  /** userId user_id */
  @Size(max = 200)
  @TableField("user_id")
  private String userId;
  /**
   * 主播数量
   */
  @Size(max = 500)
  @TableField("anchor_num")
  private String anchorNum;
  /**
   * 0站 1坐
   */
  @Size(max = 20)
  private String seat;
  /**
   * 主播风格
   */
  @Size(max = 50)
  @TableField("anchor_type")
  private String anchorType;
  /**
   * plusService vip服务
   * 1. 搭配服装颜色
   * 2. 直播间配色
   * 3. logo
   * 4. 产品广告屏
   */
  @Size(max = 100)
  @TableField("plus_service")
  private String plusService;

  /**
   * 0不加速 1加速 加速单价?
   */
  @TableField("accelerate")
  private Integer accelerate;

  @Override
  public boolean equals(Object o) {
    return super.equals(o);
  }

  @Override
  public int hashCode() {
    return super.hashCode();
  }
}
