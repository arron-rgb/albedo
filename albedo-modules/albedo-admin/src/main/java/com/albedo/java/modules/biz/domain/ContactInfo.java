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
 * 联系单Entity 联系单
 *
 * @author arronshentu
 * @version 2020-09-02 13:51:29
 */
@TableName(value = "t_contact_info")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class ContactInfo extends IdEntity<ContactInfo> {

  private static final long serialVersionUID = 1L;
  /** F_COMPANYNAME company_name : 企业名称 */
  public static final String F_COMPANYNAME = "companyName";
  /** F_NAME name : 姓名 */
  public static final String F_NAME = "name";
  /** F_PHONE phone : 手机号 */
  public static final String F_PHONE = "phone";
  /** F_STATUS status : 处理状态 */
  public static final String F_STATUS = "status";

  /** companyName 企业名称 */
  @Size(max = 32)
  @TableField("company_name")
  private String companyName;
  /** name 姓名 */
  @Size(max = 32)

  private String name;
  /** phone 手机号 */
  @Size(max = 20)

  private String phone;
  /** status 处理状态 */
  @Size(max = 100)
  private String status;

}
