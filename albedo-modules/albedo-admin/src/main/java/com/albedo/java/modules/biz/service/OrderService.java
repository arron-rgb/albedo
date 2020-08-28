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

  /**
   * 可认领的订单
   */
  void availableOrder();

  /**
   * 员工制作完成 上传视频后与订单绑定
   *
   * @param orderId
   *          订单id
   * @param videoId
   *          视频id
   */
  void uploadVideo(String orderId, String videoId);

}
