package com.albedo.java.modules.biz.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @author arronshentu
 */

@Data
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class SubOrderVo {
  private String content;
  private String description;
  private String logoUrl;
  /**
   * 贴片
   */
  private String adUrl;
  private String orderId;
}
