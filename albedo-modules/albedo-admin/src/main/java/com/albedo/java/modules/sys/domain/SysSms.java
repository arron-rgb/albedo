/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.sys.domain;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * 管理短信Entity sys_sms
 *
 * @author admin
 * @version 2020-08-12 15:46:27
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@TableName(value = "sys_sms")
@EqualsAndHashCode(callSuper = true)
public class SysSms extends IdEntity<SysSms> {

  private static final long serialVersionUID = 1L;
  /** F_PHONENUMBER phone_number : phone_number */
  public static final String F_PHONENUMBER = "phoneNumber";
  /** F_USERID user_id : 开发票的userid */
  public static final String F_USERID = "userId";
  /** F_TYPE type : 类型？ */
  public static final String F_TYPE = "type";
  /** F_TEMPLATECODE template_code : 模板代码？ */
  public static final String F_TEMPLATECODE = "templateCode";
  /** F_TEMPLATEPARAM template_param : template_param */
  public static final String F_TEMPLATEPARAM = "templateParam";
  /** F_STATUS status : 状态 */
  public static final String F_STATUS = "status";

  /** phoneNumber phone_number */
  @TableField("phone_number")
  private Long phoneNumber;
  /** userId 开发票的userid */
  @NotBlank
  @Size(max = 32)
  @TableField("user_id")
  private String userId;
  /** type 类型？ */
  @Size(max = 1)
  private String type;
  /** templateCode 模板代码？ */
  @NotBlank
  @Size(max = 255)
  @TableField("template_code")
  private String templateCode;
  /** templateParam template_param */
  @Size(max = 255)
  @TableField("template_param")
  private String templateParam;
  /** status 状态 */
  @Size(max = 255)

  private String status;

}
