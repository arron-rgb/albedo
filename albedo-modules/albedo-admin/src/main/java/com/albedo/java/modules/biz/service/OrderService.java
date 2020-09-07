package com.albedo.java.modules.biz.service;

import java.util.List;

import com.albedo.java.common.core.exception.OrderException;
import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.OrderVo;
import com.albedo.java.modules.biz.domain.SubOrderVo;

/**
 * @author arronshentu
 */
public interface OrderService extends BaseService<Order> {

  /**
   * 用户下单
   *
   * @param order
   *          表单
   */
  String place(OrderVo order);

  /**
   * 用户付款 or 扣次数
   *
   * @param orderId
   *          订单id
   * @param subject
   *          订单名
   * @return 付款链接
   */
  String price(String orderId, String subject);

  /**
   * 员工认领
   *
   * @param orderId
   *          订单id
   * @exception OrderException
   *              订单信息异常
   */
  void consume(String orderId) throws OrderException;

  /**
   * 员工可认领的订单
   *
   * @return
   *         可认领的订单，即处于支付完成未认领的订单
   */
  List<Order> availableOrder();

  /**
   * 二次下单
   *
   * @param orderVo
   */
  void updateForm(SubOrderVo orderVo);

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

  boolean callback(String orderId);

}
