package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.OrderForm;

/**
 * @author arronshentu
 */
public interface OrderService extends BaseService<Order> {

  /**
   * 用户下单
   *
   * @param form
   */
  void place(OrderForm form);

  /**
   * 员工认领
   *
   * @param staffId
   * @param orderId
   */
  void consume(String staffId, String orderId);

  void availableOrder();

  void uploadVideo(String orderId, String videoId);

}
