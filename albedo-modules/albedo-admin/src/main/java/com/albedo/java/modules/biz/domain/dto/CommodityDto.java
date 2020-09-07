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
 * 商品管理Dto 商品管理
 *
 * @author arronshentu
 * @version 2020-09-07 14:58:36
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CommodityDto extends DataDto<String> {

  private static final long serialVersionUID = 1L;
  /** F_NAME name : 名称 */
  public static final String F_NAME = "name";
  /** F_URLS urls : 商品图片 */
  public static final String F_URLS = "urls";
  /** F_USERID user_id : 用户id */
  public static final String F_USERID = "userId";

  /** name 名称 */
  @Size(max = 200)
  private String name;
  /** urls 商品图片 */
  @Size(max = 65535)
  private String urls;
  /** userId 用户id */
  @Size(max = 32)
  private String userId;

}
