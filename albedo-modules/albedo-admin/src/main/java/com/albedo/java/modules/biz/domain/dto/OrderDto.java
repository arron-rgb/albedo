package com.albedo.java.modules.biz.domain.dto;

import com.albedo.java.common.core.vo.DataDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @author arronshentu
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class OrderDto extends DataDto<String> {

  private String userId;
  private Integer state;
  private String type;
  private String videoId;
  private String userName;
  private String userPhone;

}
