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
public class OrderVo {
  String content;
  String type;
  String totalAmount;
  // todo 支付途径
  String method;
}
