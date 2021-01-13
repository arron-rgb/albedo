/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain;

import javax.validation.constraints.Size;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * 增删改查Entity 优惠券
 *
 * @author admin
 * @version 2020-10-04 08:44:10
 */
@TableName(value = "t_coupon")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class Coupon extends IdEntity<Coupon> {

  private static final long serialVersionUID = 1L;
  /** F_CODE code : 优惠码编号 */
  public static final String F_CODE = "code";
  /** F_STATUS status : 使用状态 */
  public static final String F_STATUS = "status";
  /** F_USERID user_id : 使用者 */
  public static final String F_USERID = "userId";

  /** code 优惠码编号 */
  @Size(max = 32)
  private String code;
  /** status 使用状态 */
  @Size(max = 200)
  private String status;
  /**
   * 折扣
   */
  private String discount;
  /**
   * 使用的订单id
   */
  private String orderId;
  /** userId 使用者 */
  @Size(max = 32)
  @TableField("user_id")
  private String userId;

  public Coupon(String discount) {
    this.discount = discount;
  }
}
