/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain.dto;

import javax.validation.constraints.Size;

import com.albedo.java.common.core.vo.DataDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 增删改查Dto 优惠券
 *
 * @author admin
 * @version 2020-10-04 08:44:10
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CouponDto extends DataDto<String> {

  private static final long serialVersionUID = 1L;
  /** F_CODE code : 优惠码编号 */
  public static final String F_CODE = "code";
  /** F_STATUS status : 使用状态 */
  public static final String F_STATUS = "status";
  /** F_USERID user_id : 使用者 */
  public static final String F_USERID = "userId";

  /** code 优惠码编号 */
//  @Size(max = 32)
  private String code;
  /** status 使用状态 */
//  @Size(max = 200)
  private String status;
  /** userId 使用者 */
  @Size(max = 32)
  private String discount;
  @Size(max = 32)
  private String userId;
  private Integer num;

}
