package com.albedo.java.modules.biz.service;

import java.util.List;

import org.springframework.scheduling.annotation.Async;

import com.albedo.java.common.core.exception.OrderException;
import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.SubOrderVo;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.OrderVo;

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
  Video updateForm(SubOrderVo orderVo);

  /**
   * 返回员工名下的订单
   *
   * @return 员工名下的订单
   */
  List<Order> belongs();

  /**
   * 订单支付完成回调接口
   * 1. 将购买记录更新为已支付
   * 2. 订单状态更新为已支付
   *
   * @param orderId
   * @return
   */
  boolean callback(String orderId);

  /**
   * 上传配音文件
   *
   * @param orderVo
   * @param video
   */
  void dubbingBySelf(SubOrderVo orderVo, Video video);

  /**
   * tts配音
   * 1. 调用tts接口合成
   *
   * @param orderVo
   * @param video
   */
  @Async
  void machineDubbing(SubOrderVo orderVo, Video video);

  /**
   * 下订单等待员工接单
   *
   * @param orderVo
   * @return
   */
  String artificialDubbing(SubOrderVo orderVo);

}
