package com.albedo.java.modules.biz.domain.dto;

import com.albedo.java.common.core.vo.DataDto;

import lombok.*;

/**
 * @author arronshentu
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class OrderDto extends DataDto<String> {

  private String userId;
  private String staffId;
  private Integer status;
  private String type;
  private String videoId;

}
