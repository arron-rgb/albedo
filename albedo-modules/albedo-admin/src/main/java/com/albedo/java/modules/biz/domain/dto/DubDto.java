/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain.dto;

import javax.validation.constraints.Size;

import com.albedo.java.common.core.vo.DataDto;

import lombok.*;

/**
 * 配音表单配置Dto 配音表单配置
 *
 * @author admin
 * @version 2020-09-07 18:24:16
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DubDto extends DataDto<String> {

  private static final long serialVersionUID = 1L;
  /** label 属性名 */
  @Size(max = 255)
  private String title;
  /** value 属性值 */
  @Size(max = 255)
  private String value;

}
