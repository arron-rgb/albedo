package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.ADMIN_ROLE_ID;
import static com.albedo.java.common.core.constant.ExceptionNames.ALIPAY_ERROR;
import static com.albedo.java.common.core.constant.ExceptionNames.ORDER_NOT_FOUNT;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.text.StringEscapeUtils;
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
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.tool.domain.TtsParams;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.albedo.java.modules.tool.util.TtsSingleton;
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

  @Override
  public String place(OrderVo form) {
    Order order = new Order();
    order.setUserId(SecurityUtil.getUser().getId());
    order.setState(UNPAID_ORDER);
    order.setType(form.getType());
    order.setDescription(form.getDescription());
    order.setContent(StringEscapeUtils.unescapeHtml4(form.getContent()));
    order.setTotalAmount(calculatePrice(order.getContent().trim()));

    if (verifyOrderType(form)) {
      // 给订单价格加上加速服务
      Dict map = dictService.getOne(Wrappers.<Dict>query().eq("code", "加速服务"));
      String updateAmount = MoneyUtil.moneyAdd(order.getTotalAmount(), map.getVal());
      order.setTotalAmount(updateAmount);
    }
    if (!compareOrderPrice(form, order)) {
      // 和前端传过来的价格比较
      throw new RuntimeMsgException("订单价格异常");
    }
    return save(order) ? order.getId() : "";
  }

  private boolean verifyOrderType(OrderVo form) {
    return StringUtils.equals(ACCELERATE, form.getType());
  }

  private boolean compareOrderPrice(OrderVo form, Order order) {
    return MoneyUtil.compareTo(form.getTotalAmount(), order.getTotalAmount());
  }

  @Override
  public String price(String orderId, String subject) {
    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUNT);
    // 1. 有次数就消耗次数

    try {
      // 扣了次数后，如果不需要额外支付，则将订单设为已支付
      // 减了次数，没支付成功；订单仍然处在未支付的状态
      balanceService.consumeTimes();
      // 加速订单 返回支付链接
      if (ACCELERATE.equals(order.getType())) {
        Dict map = dictService.getOne(Wrappers.<Dict>query().eq("code", "加速服务"));
        TradePlus plus = TradePlus.builder().subject(subject).totalAmount(map.getVal()).build();
        try {
          // 订单号下沉
          return aliPayService.toPayAsPc(plus);
        } catch (Exception e) {
          throw new RuntimeMsgException(ALIPAY_ERROR);
        }
      }
      order.setState(NOT_STARTED);
      baseMapper.updateById(order);
    } catch (TimesOverspendException ignored) {
      // 次数不够扣，返回付款链接 or 购买链接
      TradePlus plus = TradePlus.builder().subject(subject).totalAmount(order.getTotalAmount()).build();
      try {
        return aliPayService.toPayAsPc(plus);
      } catch (Exception e) {
        throw new RuntimeMsgException(ALIPAY_ERROR);
      }
    }
    return "success";
  }

  @Resource
  DictService dictService;

  private String calculatePrice(String content) {
    PlusService plusService = JSON.parseObject(content, PlusService.class);
    Assert.notNull(plusService, "订单格式错误，价格计算失败");

    List<PlusService.Element> elements = plusService.getData().stream()
      .filter((element -> "anchorNum".equals(element.getTitle()))).collect(Collectors.toList());
    Assert.isTrue(elements.size() == 1, "主播数量异常");

    int result = elements.stream().mapToInt(ele -> {
      List<Config> data = ele.getData();
      if (CollectionUtils.isEmpty(data)) {
        return 0;
      }
      Assert.isTrue(elements.size() == 1, "主播数量异常");
      Config config = data.get(0);
      Dict price = dictService.getOne(Wrappers.<Dict>query().eq("name", config.getValue()));
      return Integer.parseInt(price.getVal());
    }).sum();

    return String.valueOf(result);
  }

  @Override
  public void consume(String orderId) throws OrderException {
    String staffId = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();
    Assert.isTrue(roles.contains(ADMIN_ROLE_ID), "非后台员工无法认领订单");

    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUNT);

    order.setStaffId(staffId);
    order.setState(IN_PRODUCTION);
    saveOrUpdate(order);
  }

  @Override
  public List<Order> availableOrder() {
    List<Order> orders = baseMapper.selectList(Wrappers.query());
    orders = orders.stream().filter((order -> NOT_STARTED.equals(order.getState()))).collect(Collectors.toList());
    return orders;
  }

  @Override
  public void updateForm(SubOrderVo orderVo) {
    // 自己上传录音 直接给一个文件路径即可

    Video video = videoService.getOne(Wrappers.<Video>lambdaQuery().eq(Video::getOrderId, orderVo.getOrderId()));
    Assert.notNull(video, "未查询到该订单对应的视频记录");
    video.setAdUrl(orderVo.getAdUrl());
    video.setLogoUrl(orderVo.getLogoUrl());
    switch (orderVo.getType()) {
      case 0:
        // 自行上传配音
        dubbingBySelf(orderVo, video);
        break;
      case 1:
        // 人工配音 配音字段的属性及pojo
        artificialDubbing(orderVo);
        break;
      case 2:
        // tts配音
        machineDubbing(orderVo, video);
        break;
      default:
        throw new RuntimeMsgException("配音类型异常");
    }

  }

  private void dubbingBySelf(SubOrderVo orderVo, Video video) {
    video.setAudioUrl(orderVo.getAudioUrl());
    video.setAudioText(orderVo.getContent());
    videoService.updateById(video);
  }

  private void machineDubbing(SubOrderVo orderVo, Video video) {
    String filePath = generateAudio(orderVo.getContent(), "", orderVo.getOrderId());
    video.setAudioUrl(filePath);
    videoService.updateById(video);
  }

  private void artificialDubbing(SubOrderVo orderVo) {
    String totalAmount = "";
    String subject = "人工配音";
    TradePlus trade = TradePlus.builder().subject(subject).totalAmount(totalAmount).build();
    try {
      // 人工配音的下单方式
      Order order = new Order();
      order.setTotalAmount(totalAmount);
      order.setType(DUBBING);
      order.setUserId(SecurityUtil.getUser().getId());
      order.setContent(orderVo.getContent());
      order.setState(NOT_STARTED);
      baseMapper.insert(order);
      aliPayService.toPayAsPc(trade);
    } catch (Exception ignored) {
    }
  }

  /**
   * 1. 商品选择及商品crud
   */
  public String generateAudio(String text, String commodityIds, String orderId) {
    TtsParams build = new TtsParams();
    build.setText(text);
    File file = ttsSingleton.generateRadio(build);
    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUNT);
    // todo 商品创建完了要干啥
    String videoId = order.getVideoId();
    Video video = videoService.getById(videoId);
    return file.getAbsolutePath();
  }

  @Resource
  TtsSingleton ttsSingleton;

  @Override
  public List<Order> belongs() {
    List<String> roles = SecurityUtil.getRoles();
    Assert.isTrue(roles.contains(ADMIN_ROLE_ID), "非后台员工无法查看订单内容");

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
    order.setState(NOT_STARTED);
    return baseMapper.updateById(order) == 1;
  }
}
