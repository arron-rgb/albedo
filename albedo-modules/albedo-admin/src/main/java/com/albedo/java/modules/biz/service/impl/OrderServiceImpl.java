package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;

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
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.domain.vo.TradeVo;
import com.albedo.java.modules.tool.service.AliPayService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

/**
 * @author arronshentu
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class OrderServiceImpl extends DataServiceImpl<OrderRepository, Order, OrderDto, String>
  implements OrderService {

  @Resource
  AliPayService aliPayService;
  @Resource
  BalanceService balanceService;

  @Override
  public void place(OrderForm form) {
    Order order = new Order();
    order.setUserId(SecurityUtil.getUser().getId());
    order.setType(form.getAccelerate().toString());
    order.setState(ORDER_STATE_0);
    order.setTotalAmount(calculatePrice(form));
    baseMapper.insert(order);
  }

  @Override
  public String price(String orderId) {
    // 1. 消耗次数
    try {
      balanceService.consumeTimes();
    } catch (TimesOverspendException ignored) {
      return "success";
    }
    // 2. 付款链接
    TradePlus plus = TradePlus.builder().build();
    try {
      return aliPayService.toPayAsPc(plus);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "failed";
  }

  private String calculatePrice(OrderForm form) {
    return "";
  }

  @Override
  public void consume(String staffId, String orderId) {
    Order order = baseMapper.selectById(orderId);
    if (order == null) {
      return;
    }
    order.setStaffId(staffId);
    order.setState(ORDER_STATE_2);
    saveOrUpdate(order);
  }

  @Override
  public void uploadVideo(String orderId, String videoId) {
    Order order = baseMapper.selectById(orderId);
    if (order == null) {
      return;
    }
    order.setVideoId(videoId);
    order.setState(ORDER_STATE_3);
    // todo 员工自行上传视频逻辑
  }

  @Override
  public String payAsPcForOrder(Order order) {
    TradeVo tradeVo = new TradeVo();
    tradeVo.setSubject(order.getId());
    tradeVo.setBody("");
    try {
      return aliPayService.toPayAsPc(tradeVo);
    } catch (Exception e) {
      e.printStackTrace();
    }
    // todo order费用怎么计算
    return "";
  }

  @Override
  public void availableOrder() {
    List<Order> orders = baseMapper.selectList(Wrappers.query());
    orders = orders.stream().filter((order -> ORDER_STATE_1.equals(order.getState()))).collect(Collectors.toList());
    orders.forEach(System.out::println);
  }

}
