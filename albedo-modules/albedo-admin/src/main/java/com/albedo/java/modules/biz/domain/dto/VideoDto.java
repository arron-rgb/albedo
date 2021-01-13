package com.albedo.java.modules.biz.domain.dto;

import com.albedo.java.common.core.vo.DataDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @author arronshentu
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class VideoDto extends DataDto<String> {

  private String orderId;
  private String userId;
  private String name;
  private String originUrl;
  private String logoUrl;
  private String outputUrl;

}
