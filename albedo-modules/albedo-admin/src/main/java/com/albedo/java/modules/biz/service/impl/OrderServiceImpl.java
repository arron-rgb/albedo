package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.ADMIN_ROLE_ID;

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
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.OrderDto;
import com.albedo.java.modules.biz.repository.OrderRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderFormService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
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
    save(order);
  }

  @Resource
  OrderFormService formService;

  @Override
  public String price(String orderId) {
    Order order = baseMapper.selectById(orderId);
    // 1. 有次数就消耗次数
    try {
      balanceService.consumeTimes();
    } catch (TimesOverspendException ignored) {
      // 次数不够扣，返回付款链接 or 购买链接
      TradePlus plus = TradePlus.builder().subject("subject").totalAmount(order.getTotalAmount()).build();
      try {
        return aliPayService.toPayAsPc(plus);
      } catch (Exception ignored2) {
        return "";
      }
    }
    return "success";
  }

  private String calculatePrice(OrderForm form) {
    return "";
  }

  @Override
  public void consume(String orderId) {
    String staffId = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();
    // 非后台工作人员无法认领
    if (!roles.contains(ADMIN_ROLE_ID)) {
      return;
    }
    Order order = baseMapper.selectById(orderId);
    if (order == null) {
      return;
    }
    order.setStaffId(staffId);
    order.setState(ORDER_STATE_2);
    saveOrUpdate(order);
  }

  @Override
  public List<Order> availableOrder() {
    List<Order> orders = baseMapper.selectList(Wrappers.query());
    orders = orders.stream().filter((order -> ORDER_STATE_1.equals(order.getState()))).collect(Collectors.toList());
    return orders;
  }

  @Override
  public void updateForm() {
    // todo 上传贴片等素材
  }

  @Override
  public List<Order> belongs() {
    return baseMapper.selectList(Wrappers.<Order>query().eq("staff_id", SecurityUtil.getUser().getId()));
  }

  @Resource
  VideoService videoService;

  @Override
  public void uploadRadio(String orderId, String content) {
    Order order = baseMapper.selectById(orderId);
    String videoId = order.getVideoId();
    Video video = videoService.getById(videoId);
    // todo tts合成音频or上传音频
  }

  @Override
  public boolean callback(String orderId) {
    Order order = baseMapper.selectById(orderId);
    order.setState(ORDER_STATE_1);
    return baseMapper.updateById(order) == 1;
  }
}
