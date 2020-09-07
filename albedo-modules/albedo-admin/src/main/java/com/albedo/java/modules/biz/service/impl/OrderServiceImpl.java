package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.ADMIN_ROLE_ID;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.albedo.java.common.core.exception.OrderException;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.exception.TimesOverspendException;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.*;
import com.albedo.java.modules.biz.domain.dto.OrderDto;
import com.albedo.java.modules.biz.repository.OrderRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.biz.util.MoneyUtil;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;

/**
 * @author arronshentu
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class OrderServiceImpl extends DataServiceImpl<OrderRepository, Order, OrderDto, String>
  implements OrderService {

  @Resource
  AliPayUtils aliPayUtils;
  @Resource
  AliPayService aliPayService;
  @Resource
  BalanceService balanceService;

  int val = 30;

  @Override
  public String place(OrderVo form) {
    Order order = new Order();
    order.setUserId(SecurityUtil.getUser().getId());
    order.setState(ORDER_STATE_0);
    order.setType(form.getType());
    order.setContent(form.getContent());
    order.setTotalAmount(calculatePrice(form.getContent().trim()));
    if (verifyOrderType(form)) {
      BigDecimal totalAmount = new BigDecimal(order.getTotalAmount());
      totalAmount = totalAmount.add(new BigDecimal(val));
      order.setTotalAmount(String.valueOf(totalAmount));
    }
    if (!compareOrderPrice(form, order)) {
      throw new RuntimeMsgException("订单价格异常");
    }
    return save(order) ? order.getId() : "";
  }

  private boolean verifyOrderType(OrderVo form) {
    return StringUtils.equals("1", form.getType());
  }

  private boolean compareOrderPrice(OrderVo form, Order order) {
    return MoneyUtil.compareTo(form.getTotalAmount(), order.getTotalAmount());
  }

  @Override
  public String price(String orderId, String subject) {
    Order order = baseMapper.selectById(orderId);
    // 1. 有次数就消耗次数
    try {
      // 扣了次数后，如果不需要额外支付，则将订单设为已支付
      balanceService.consumeTimes();
      // 加速订单 返回支付链接
      if ("1".equals(order.getType())) {
        TradePlus plus = TradePlus.builder().outTradeNo(aliPayUtils.getOrderCode()).subject(subject)
          .totalAmount(String.valueOf(val)).build();
        try {
          return aliPayService.toPayAsPc(plus);
        } catch (Exception e) {
          throw new RuntimeMsgException("调用支付链接时发生错误");
        }
      }
      order.setState(ORDER_STATE_1);
      baseMapper.updateById(order);
    } catch (TimesOverspendException ignored) {
      // 次数不够扣，返回付款链接 or 购买链接
      TradePlus plus = TradePlus.builder().outTradeNo(aliPayUtils.getOrderCode()).subject(subject)
        .totalAmount(order.getTotalAmount()).build();
      try {
        return aliPayService.toPayAsPc(plus);
      } catch (Exception e) {
        throw new RuntimeMsgException("调用支付链接时发生错误");
      }
    }
    return "success";
  }

  private String calculatePrice(String content) {
    PlusService plusService = JSON.parseObject(content, PlusService.class);
    if (plusService == null) {
      throw new RuntimeMsgException("订单价格计算失败");
    }

    List<PlusService.Element> elements = plusService.getData().stream()
      .filter((element -> "anchorNum".equals(element.getTitle()))).collect(Collectors.toList());

    if (elements.size() != 1) {
      throw new RuntimeMsgException("参数异常");
    }

    int result = elements.stream().mapToInt(ele -> {
      List<Config> data = ele.getData();
      if (CollectionUtils.isEmpty(data)) {
        return 0;
      }
      if (data.size() != 1) {
        throw new RuntimeException("参数异常");
      }
      Config config = data.get(0);
      // todo 999 从配置项中读取
      return "单人主播".equals(config.getValue()) ? 999 : 1999;
    }).sum();

    return String.valueOf(result);
  }

  @Override
  public void consume(String orderId) throws OrderException {
    String staffId = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();
    // 非后台工作人员无法认领
    if (!roles.contains(ADMIN_ROLE_ID)) {
      throw new OrderException("非后台员工无法认领订单");
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
  public void updateForm(SubOrderVo orderVo) {
    // 自己上传录音 直接给一个文件路径即可
    Video video = videoService.getOne(Wrappers.<Video>lambdaQuery().eq(Video::getOrderId, orderVo.getOrderId()));
    Assert.notNull(video, "未查询到该订单对应的视频记录");
    video.setAdUrl(orderVo.getAdUrl());
    video.setAudioText(orderVo.getContent());
    video.setLogoUrl(orderVo.getLogoUrl());
    videoService.updateById(video);
    // 人工配音 配音字段的属性及pojo
    TradePlus tradePlus = TradePlus.builder().build();
    Order order = new Order();
    // tts配音 1. 商品选择及商品crud 2. 串词中参数的注入？
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
  }

  @Override
  public boolean callback(String orderId) {
    Order order = baseMapper.selectById(orderId);
    order.setState(ORDER_STATE_1);
    return baseMapper.updateById(order) == 1;
  }
}
