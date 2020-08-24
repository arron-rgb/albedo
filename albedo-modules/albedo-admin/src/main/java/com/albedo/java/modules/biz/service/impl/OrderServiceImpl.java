package com.albedo.java.modules.biz.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.core.exception.TimesOverspendException;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.OrderForm;
import com.albedo.java.modules.biz.domain.dto.OrderDto;
import com.albedo.java.modules.biz.repository.OrderRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

/**
 * @author arronshentu
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class OrderServiceImpl extends DataServiceImpl<OrderRepository, Order, OrderDto, String>
  implements OrderService {

  @Resource
  BalanceService balanceService;

  @Override
  public void place(OrderForm form) {
    // 下订单流程
    try {
      balanceService.consumeTimes();
    } catch (TimesOverspendException ignored) {
    }
    Order order = new Order();
    order.setUserId(SecurityUtil.getUser().getId());
    order.setType("0");
    order.setState(1);
    order.setStaffId("");
  }

  @Override
  public void consume(String staffId, String orderId) {
    Order order = baseMapper.selectById(orderId);
    if (order == null) {
      return;
    }
    order.setStaffId(staffId);
    order.setState(2);
    saveOrUpdate(order);
  }

  @Override
  public void uploadVideo(String orderId, String videoId) {
    Order order = baseMapper.selectById(orderId);
    if (order == null) {
      return;
    }
    order.setVideoId(videoId);
  }

  @Override
  public void availableOrder() {
    List<Order> orders = baseMapper.selectList(Wrappers.query());
    orders = orders.stream().filter((order -> order.getState() == 1)).collect(Collectors.toList());
    orders.forEach(System.out::println);
  }

  public void updateType(String orderId) {
    // todo 支付宝验证逻辑 or 回调
    Order order = baseMapper.selectById(orderId);
    if (order == null) {
      return;
    }
    order.setType("加速");

  }
}
