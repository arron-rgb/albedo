package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.ADMIN_ROLE_ID;
import static com.albedo.java.common.core.constant.ExceptionNames.*;

import java.io.File;
import java.util.List;
import java.util.Objects;
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
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.biz.util.MoneyUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.tool.domain.TtsParams;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.albedo.java.modules.tool.util.TtsSingleton;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;
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
  PurchaseRecordService recordService;
  @Resource
  AliPayUtils aliPayUtils;
  @Resource
  AliPayService aliPayService;
  @Resource
  BalanceService balanceService;
  String val = "加速服务";

  /**
   * 非配音订单
   * 并且
   * 正在流程中的
   * 订单
   *
   * @return
   */
  private Order currentOrder() {
    return getOne(Wrappers.<Order>query().eq("user_id", SecurityUtil.getUser().getId()).ne("type", DUBBING)
      .ne("state", COMPLETED_SUCCESS).orderByAsc("created_date"), false);
  }

  @Override
  public String place(OrderVo form) {

    if (!Objects.isNull(currentOrder())) {
      throw new RuntimeMsgException("当前仍有订单未完成，无法创建新订单");
    }

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
    Assert.isTrue(UNPAID_ORDER.equals(order.getState()), ORDER_ERROR);

    Integer times = balanceService.leftTimes();
    if (times == null || times.equals(0)) {
      // 1. 先检验次数 没次数的话返回支付整个订单的链接
      TradePlus plus = TradePlus.builder().outTradeNo(aliPayUtils.getOrderCode()).subject(subject)
        .totalAmount(order.getTotalAmount()).build();
      PurchaseRecord record;
      record =
        recordService.getOne(Wrappers.<PurchaseRecord>lambdaQuery().eq(PurchaseRecord::getOuterId, orderId), false);
      if (record == null) {
        record = PurchaseRecord.builder().userId(SecurityUtil.getUser().getId()).type(ORDER_TYPE)
          .totalAmount(order.getTotalAmount()).outTradeNo(plus.getOutTradeNo()).outerId(order.getId()).build();
      }
      // todo orderId应该唯一索引 异常要处理
      recordService.saveOrUpdate(record);
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
    return aliPayService.toPayAsPc(plus);
  }

  @Resource
  DictService dictService;

  private String calculatePrice(String content) {

    PlusService<Config> plusService;
    try {
      plusService = JSON.parseObject(content.trim(), new TypeReference<PlusService<Config>>() {});
    } catch (JSONException e) {
      throw new RuntimeMsgException(ORDER_PARSE_ERROR);
    }
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
    if (!UPLOAD_AUDIO.equals(orderVo.getType())) {
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
    TradePlus trade =
      TradePlus.builder().outTradeNo(aliPayUtils.getOrderCode()).subject(subject).totalAmount(totalAmount).build();

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

      PurchaseRecord record = PurchaseRecord.builder().userId(SecurityUtil.getUser().getId()).type(ORDER_TYPE)
        .totalAmount(trade.getTotalAmount()).outTradeNo(trade.getOutTradeNo()).outerId(order.getId()).build();
      recordService.save(record);

      return aliPayService.toPayAsPc(trade);
    } catch (Exception e) {
      e.printStackTrace();
      throw new RuntimeMsgException(ALIPAY_ERROR);
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
    // 订单状态
    Assert.notNull(order.getState(), "订单状态异常");
    // 拒绝非未付款订单
    Assert.isTrue(UNPAID_ORDER.equals(order.getState()), "订单状态异常");
    // 拒绝已进入付款后状态订单
    Assert.isTrue(order.getState() < NOT_STARTED, "订单已支付");
    order.setState(NOT_STARTED);
    PurchaseRecord record =
      recordService.getOne(Wrappers.<PurchaseRecord>lambdaQuery().eq(PurchaseRecord::getType, ORDER_TYPE)
        .eq(PurchaseRecord::getOuterId, orderId).orderByAsc(PurchaseRecord::getCreatedDate));
    Assert.notNull(record, PURCHASE_RECORD_NOT_FOUND);
    record.setStatus(TRADE_FINISHED);
    recordService.updateById(record);

    return baseMapper.updateById(order) == 1;
  }

}
