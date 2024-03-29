package com.albedo.java.modules.biz.service;

import java.util.List;

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
   * 非配音单
   * 未结单的订单
   *
   * @return
   */
  Order currentOrder();

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
   *          表单内容
   * @return
   *         订单对应的视频记录
   */
  Video updateForm(SubOrderVo orderVo);

  String generateAudio(List<String> text, String orderId, String voiceType);

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
   * 配音
   *
   * @param orderVo
   * @param video
   */
  String dub(SubOrderVo orderVo, Video video);

  /**
   *
   * // 0. 客户在视频订单的上传贴片状态选择人工配音
   * // 1. 新建配音订单：绑定视频订单-配音订单。用配音订单的**videoId字段**存储视频订单的id
   * // 2. 员工接单同个流程，在制作完成上传后直接将配音订单结束。把视频订单videoId的音频文件更新发起合成事件
   * // 3. 合成事件中会将视频订单状态更新，并上传至oss
   *
   * @param orderId
   *          配音订单id
   * @param audioUrl
   *          音频文件路径
   */
  void uploadAudio(String orderId, String audioUrl);

  Video getDub(String orderId);
}
