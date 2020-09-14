package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.ADMIN_ROLE_ID;
import static com.albedo.java.common.core.constant.ExceptionNames.*;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.text.StringEscapeUtils;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.albedo.java.common.core.exception.OrderException;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.*;
import com.albedo.java.modules.biz.domain.dto.OrderDto;
import com.albedo.java.modules.biz.domain.dto.OrderVo;
import com.albedo.java.modules.biz.repository.OrderRepository;
import com.albedo.java.modules.biz.repository.VideoRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.util.MoneyUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.tool.domain.TtsParams;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.TtsSingleton;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
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
  AliPayService aliPayService;
  @Resource
  BalanceService balanceService;
  String val = "加速服务";

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
      Dict map = dictService.getOne(Wrappers.<Dict>query().eq("code", val));
      if (map == null) {
        map = new Dict();
        map.setVal("99");
      }
      String updateAmount = MoneyUtil.moneyAdd(order.getTotalAmount(), map.getVal());
      order.setTotalAmount(updateAmount);
    }
    if (!compareOrderPrice(form, order)) {
      // 和前端传过来的价格比较
      throw new RuntimeMsgException(PRICE_ERROR);
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
    Assert.notNull(order, ORDER_NOT_FOUND);
    Assert.isTrue(order.getState().equals(UNPAID_ORDER), ORDER_ERROR);

    Integer times = balanceService.leftTimes();
    if (times == null) {
      // 1. 先检验次数 没次数的话返回支付整个订单的链接
      TradePlus plus = TradePlus.builder().subject(subject).totalAmount(order.getTotalAmount()).build();
      return getPurchaseUrl(plus);
    }
    // 2. 有次数，就消耗次数
    // 扣了次数后，如果不需要额外支付，则将订单设为已支付
    // 减了次数，没支付成功；订单仍然处在未支付的状态
    balanceService.consumeTimes();
    // 加速订单 返回加速服务付款链接
    if (ACCELERATE.equals(order.getType())) {
      Dict map = dictService.getOne(Wrappers.<Dict>query().eq("code", val));
      if (map == null) {
        map = new Dict();
        map.setVal("99");
      }
      TradePlus plus = TradePlus.builder().subject(subject).totalAmount(map.getVal()).build();
      return getPurchaseUrl(plus);
    }
    order.setState(NOT_STARTED);
    baseMapper.updateById(order);
    return "success";
  }

  private String getPurchaseUrl(TradePlus plus) {
    try {
      return aliPayService.toPayAsPc(plus);
    } catch (Exception e) {
      throw new RuntimeMsgException(ALIPAY_ERROR);
    }
  }

  @Resource
  DictService dictService;

  private String calculatePrice(String content) {

    PlusService<Config> plusService = JSON.parseObject(content.trim(), new TypeReference<PlusService<Config>>() {});

    Assert.notNull(plusService, ORDER_PARSE_ERROR);

    List<Element<Config>> elements = plusService.getData().stream()
      .filter((element -> "主播数量".equals(element.getTitle()))).collect(Collectors.toList());

    Assert.isTrue(elements.size() == 1, ANCHOR_NUM_ERROR);

    int result = elements.stream().mapToInt(ele -> {
      List<Config> data = ele.getData();
      if (CollectionUtils.isEmpty(data)) {
        return 0;
      }
      Assert.isTrue(elements.size() == 1, ANCHOR_NUM_ERROR);
      Config config = data.get(0);
      Dict price = dictService.getOne(Wrappers.<Dict>query().eq("name", config.getValue()));
      if (price == null) {
        price = new Dict();
        String val = "单人主播".equals(config.getValue()) ? "999" : "1999";
        price.setVal(val);
      }
      Assert.notNull(price, PRICE_NOT_FOUND);
      return Integer.parseInt(price.getVal());
    }).sum();

    return String.valueOf(result);
  }

  @Override
  public void consume(String orderId) throws OrderException {
    String staffId = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();

    Assert.isTrue(roles.contains(ADMIN_ROLE_ID), UNALLOWED_ACTION);

    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);

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
  public Video updateForm(SubOrderVo orderVo) {
    // 自己上传录音 直接给一个文件路径即可
    Video video = videoRepository.selectOne(Wrappers.<Video>lambdaQuery().eq(Video::getOrderId, orderVo.getOrderId()));
    Assert.notNull(video, ORDER_VIDEO_NOT_FOUNT);
    // video.setAdUrl(orderVo.getAdUrl());
    // video.setLogoUrl(orderVo.getLogoUrl());
    if (orderVo.getType() != 1) {
      Assert.notEmpty(orderVo.getContent(), "配音文本不允许为空");
    }
    return video;
  }

  /**
   * 自行上传配音
   *
   * @param orderVo
   * @param video
   */
  @Override
  public void dubbingBySelf(SubOrderVo orderVo, Video video) {
    video.setAudioUrl(orderVo.getAudioUrl());
    video.setAudioText(orderVo.appendContent());
    videoRepository.updateById(video);
  }

  @Async
  @Override
  public void machineDubbing(SubOrderVo orderVo, Video video) {
    String filePath = generateAudio(orderVo.appendContent(), orderVo.getOrderId());
    video.setAudioText(orderVo.appendContent());
    video.setAudioUrl(filePath);
    videoRepository.updateById(video);
  }

  @Override
  public String artificialDubbing(SubOrderVo orderVo) {
    String totalAmount = "999";
    Dict price = dictService.getOne(Wrappers.<Dict>query().eq("code", "人工配音"));
    if (price != null) {
      totalAmount = price.getVal();
    }
    String subject = "人工配音";
    TradePlus trade = TradePlus.builder().subject(subject).totalAmount(totalAmount).build();
    try {
      // 人工配音的下单方式
      Order order = new Order();
      order.setTotalAmount(totalAmount);
      order.setType(DUBBING);
      order.setUserId(SecurityUtil.getUser().getId());
      order.setContent(orderVo.appendContent());
      order.setDescription(orderVo.getDescription());
      order.setState(NOT_STARTED);
      baseMapper.insert(order);
      return aliPayService.toPayAsPc(trade);
    } catch (Exception ignored) {
      throw new RuntimeMsgException("生成支付链接时发生错误");
    }
  }

  public String generateAudio(String text, String orderId) {
    TtsParams build = new TtsParams();
    build.setText(text);
    build.setCodec("mp3");
    File file = ttsSingleton.generateAudio(build);
    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    String videoId = order.getVideoId();
    // 更新视频中的音频信息
    Video video = videoRepository.selectById(videoId);
    Assert.notNull(video, VIDEO_NOT_FOUND);
    video.setAudioUrl(file.getAbsolutePath());
    video.setAudioText(text);
    videoRepository.updateById(video);
    return file.getAbsolutePath();
  }

  @Resource
  TtsSingleton ttsSingleton;

  @Override
  public List<Order> belongs() {
    List<String> roles = SecurityUtil.getRoles();
    String template = "非后台员工无法查看订单内容";
    Assert.isTrue(roles.contains(ADMIN_ROLE_ID), template);
    return baseMapper.selectList(Wrappers.<Order>query().eq("staff_id", SecurityUtil.getUser().getId()));
  }

  @Resource
  VideoRepository videoRepository;

  @Override
  public boolean callback(String orderId) {
    Order order = baseMapper.selectById(orderId);
    order.setState(NOT_STARTED);
    return baseMapper.updateById(order) == 1;
  }
}
