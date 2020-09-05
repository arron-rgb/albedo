package com.albedo.java.modules.biz.domain;

import java.util.List;

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
  private List<Label> labels;
  private String description;
  private String logoUrl;
  private String adUrl;
  private String orderId;
}
