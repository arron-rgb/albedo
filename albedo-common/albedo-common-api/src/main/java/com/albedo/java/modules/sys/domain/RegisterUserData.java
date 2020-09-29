package com.albedo.java.modules.sys.domain;

import javax.validation.constraints.NotBlank;

import lombok.Data;

/**
 * @author arronshentu
 */
@Data
public class RegisterUserData {
  /**
   * personal 个人用户 business 企业用户
   */
  @NotBlank
  private String userType;
  @NotBlank
  private String username;
  @NotBlank
  private String password;
  @NotBlank
  private String rePassword;
  private String phone;
  private String verifyCode;
  /**
   * 邀请码
   */
  private int invitationCode;
  /**
   * 所属企业名称
   */
  private String ownedCompanyName;
  /**
   * 企业名称
   */
  private String newCompanyName;
}
