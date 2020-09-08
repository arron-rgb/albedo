package com.albedo.java.modules.biz.domain.dto;

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
  /**
   * 第一次下单的表单json
   */
  String content;
  /**
   * 是否为加速单
   */
  String type;
  /**
   * 订单金额
   */
  String totalAmount;
  /**
   * 支付方式
   */
  String method;
  /**
   * 订单描述
   */
  String description;
}
