package com.albedo.java.modules.biz.service;

import java.util.List;

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
   *          表单
   */
  void place(OrderForm form);

  /**
   * 用户付款 or 扣次数
   *
   * @param orderId
   *          订单id
   * @return 付款链接
   */
  String price(String orderId);

  /**
   * 员工认领
   *
   * @param orderId
   *          订单id
   */
  void consume(String orderId);

  /**
   * 员工可认领的订单
   *
   * @return
   *         可认领的订单，即处于支付完成未认领的订单
   */
  List<Order> availableOrder();

  /**
   * 更新表单
   */
  void updateForm();

  /**
   * 返回员工名下的订单
   *
   * @return 员工名下的订单
   */
  List<Order> belongs();

  /**
   * 上传音频
   *
   * @param orderId
   *          订单
   * @param content
   *          base64
   */
  void uploadRadio(String orderId, String content);
}
