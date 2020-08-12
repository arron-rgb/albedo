package com.albedo.java.modules.sys.domain;

import lombok.Data;

@Data
public class RegisterUserData {
  private String userType;
  private String companyName;
  private String username;
  private String password;
  private String rePassword;
  private String phone;
  private int verifyCode;
  //邀请码
  private int invitationCode;
  //所属企业名称
  private String ownedCompanyName;
  //企业名称
  private String newCompanyName;
}
