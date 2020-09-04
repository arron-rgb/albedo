/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.*;

/**
 * 发票抬头管理Entity 发票抬头
 *
 * @author arronshentu
 * @version 2020-08-16 16:19:02
 */
@TableName(value = "t_invoice")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class Invoice extends IdEntity<Invoice> {

  private static final long serialVersionUID = 1L;
  /** F_USERID user_id : 用户id */
  public static final String F_USERID = "userId";
  /** F_TYPE type : 0-个人，1-企业 */
  public static final String F_TYPE = "type";
  /** F_NAME name : 企业名称/个人名称 */
  public static final String F_NAME = "name";
  /** F_TAXNUM tax_num : 公司税号 */
  public static final String F_TAXNUM = "taxNum";
  /** F_COMPANYLOCATION company_location : 注册地址 */
  public static final String F_COMPANYLOCATION = "companyLocation";
  /** F_COMPANYPHONE company_phone : 公司电话 */
  public static final String F_COMPANYPHONE = "companyPhone";
  /** F_ACCOUNTBANK account_bank : 开户公司 */
  public static final String F_ACCOUNTBANK = "accountBank";
  /** F_ACCOUNTNUMBER account_number : 开户账号 */
  public static final String F_ACCOUNTNUMBER = "accountNumber";

  /** userId 用户id */
  @Size(max = 32)
  @TableField("user_id")
  private String userId;
  /** type 0-个人，1-企业 */
  @NotNull
  private Integer type;
  /** name 企业名称/个人名称 */
  @NotBlank
  @Size(max = 255)
  private String name;
  /** taxNum 公司税号 */
  @Size(max = 0)
  @TableField("tax_num")
  private String taxNum;
  /** companyLocation 注册地址 */
  @Size(max = 255)
  @TableField("company_location")
  private String companyLocation;
  /** companyPhone 公司电话 */
  @Size(max = 255)
  @TableField("company_phone")
  private String companyPhone;
  /** accountBank 开户公司 */
  @Size(max = 255)
  @TableField("account_bank")
  private String accountBank;
  /** accountNumber 开户账号 */
  @Size(max = 32)
  @TableField("account_number")
  private String accountNumber;

}
