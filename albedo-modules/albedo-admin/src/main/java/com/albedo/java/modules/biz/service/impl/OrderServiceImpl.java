package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.ADMIN_ROLE_ID;
import static com.albedo.java.common.core.constant.ExceptionNames.*;

import java.io.File;
import java.math.BigDecimal;
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
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.service.UserDetail;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.*;
import com.albedo.java.modules.biz.domain.dto.OrderDto;
import com.albedo.java.modules.biz.domain.dto.OrderVo;
import com.albedo.java.modules.biz.repository.OrderRepository;
import com.albedo.java.modules.biz.repository.VideoRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.biz.service.task.Signal;
import com.albedo.java.modules.biz.service.task.VideoEncodeTask;
import com.albedo.java.modules.biz.util.MoneyUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.sys.service.UserService;
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
  @Override
  public Order currentOrder() {
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
    order.setLogoUrl(form.getLogoUrl());
    order.setAdUrl(form.getAdUrl());
    order.setState(UNPAID_ORDER);
    order.setType(form.getType());
    order.setMethod(form.getMethod());
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
    Assert.isTrue(compareOrderPrice(form, order), PRICE_ERROR);
    return save(order) ? order.getId() : "";
  }

  private boolean verifyOrderType(OrderVo form) {
    return StringUtils.equals(ACCELERATE, form.getType());
  }

  private boolean compareOrderPrice(OrderVo form, Order order) {
    return MoneyUtil.equals(form.getTotalAmount(), order.getTotalAmount());
  }

  @Override
  public String price(String orderId, String subject) {
    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    Assert.isTrue(UNPAID_ORDER.equals(order.getState()), ORDER_ERROR);
    TradePlus plus;
    switch (order.getMethod()) {
      case "ali":
        plus = TradePlus.builder().outTradeNo(aliPayUtils.getOrderCode()).subject(subject)
          .totalAmount(order.getTotalAmount()).build();
        PurchaseRecord record;
        record =
          recordService.getOne(Wrappers.<PurchaseRecord>lambdaQuery().eq(PurchaseRecord::getOuterId, orderId), false);
        if (record == null) {
          record = PurchaseRecord.buildOrder(plus, order.getId());
        } else {
          record.setOutTradeNo(plus.getOutTradeNo());
        }
        record.setSellerId("2088331270404521");
        recordService.saveOrUpdate(record);
        return getPurchaseUrl(plus);
      case "balance":
        // 扣了次数后，如果不需要额外支付，则将订单设为已支付
        // 减了次数，没支付成功；订单仍然处在未支付的状态
        balanceService.consumeTimes();
        if (ACCELERATE.equals(order.getType())) {
          // 加速订单 返回加速服务付款链接
          Dict map = dictService.getOne(Wrappers.<Dict>query().eq("code", val));
          if (map == null) {
            map = new Dict();
            map.setVal("99");
          }
          plus = TradePlus.builder().subject(subject).totalAmount(map.getVal()).outTradeNo(orderId).build();
          return getPurchaseUrl(plus);
        }
        break;
      case "wechat":
        throw new RuntimeMsgException("暂不支持微信支付");
      default:
        throw new RuntimeMsgException("支付方式异常");
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
    return baseMapper.selectList(Wrappers.<Order>lambdaQuery().eq(Order::getState, NOT_STARTED));
  }

  @Resource
  UserService userService;

  @Override
  public Video updateForm(SubOrderVo orderVo) {
    String orderId = orderVo.getOrderId();
    Order order = baseMapper.selectById(orderId);
    String videoId = order.getVideoId();
    Video video = videoRepository.selectById(videoId);
    Assert.notNull(video, ORDER_VIDEO_NOT_FOUNT);
    UserDetail user = SecurityUtil.getUser();
    Balance one = balanceService.getOne(Wrappers.<Balance>lambdaQuery().eq(Balance::getUserId, user.getId()));
    String adminId = userService.getAdminIdByDeptId(user.getDeptId());
    if (one == null) {
      one = balanceService.getOne(Wrappers.<Balance>lambdaQuery().eq(Balance::getUserId, adminId));
    }
    Assert.notNull(one, BALANCE_NOT_FOUND);
    Long duration = orderVo.getDuration();
    // todo 套餐余量获取的标准需要考虑到企业、个人的情况
    Balance byUserId = balanceService.getByUserId(user.getId());
    Assert.isTrue(byUserId.getVideoTime().longValue() < duration, "视频时长超出套餐允许");
    video.setDuration(duration);
    videoRepository.updateById(video);
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
    Assert.notEmpty(orderVo.getAudioUrl(), "音频链接不得为空，请检查后重试");
    video.setAudioUrl(orderVo.getAudioUrl());
    videoRepository.updateById(video);
    SpringContextHolder.publishEvent(new Signal(video.getId()));
  }

  @Async
  @Override
  public void machineDubbing(SubOrderVo orderVo, Video video) {
    List<String> voiceTypes = orderVo.getVoiceType();
    Assert.notEmpty(voiceTypes, "请选择配音音色");
    String voiceType = voiceTypes.get(0);
    String filePath = generateAudio(orderVo.appendContent(), orderVo.getOrderId(), voiceType);
    Assert.notEmpty(orderVo.getContent(), "配音文本不允许为空");
    video.setAudioText(orderVo.appendContent());
    video.setAudioUrl(filePath);
    videoRepository.updateById(video);
    SpringContextHolder.publishEvent(new Signal(video.getId()));
  }

  @Override
  public void uploadAudio(String orderId, String audioUrl) {
    Order audioOrder = baseMapper.selectById(orderId);
    Assert.notNull(audioOrder, ORDER_NOT_FOUND);
    Assert.isTrue(Objects.equals(audioOrder.getType(), DUBBING));
    String videoOrderId = audioOrder.getVideoId();
    Order videoOrder = baseMapper.selectById(videoOrderId);
    Assert.notNull(videoOrder, ORDER_NOT_FOUND);
    String videoId = videoOrder.getVideoId();
    Video video = videoRepository.selectById(videoId);
    Assert.notNull(video, VIDEO_NOT_FOUND);
    video.setAudioUrl(audioUrl);
    videoRepository.updateById(video);
    audioOrder.setState(COMPLETED_SUCCESS);
    baseMapper.updateById(audioOrder);

    SpringContextHolder.publishEvent(new VideoEncodeTask(video));
  }

  String textPerMin = "200";
  String subject = "人工配音";
  String perMinute = "100";

  @Override
  public String artificialDubbing(SubOrderVo orderVo) {
    Assert.notEmpty(orderVo.getTotalAmount(), "价格字段缺失");
    String content = orderVo.appendContent();
    int length = orderVo.appendContent().length();
    String userId = SecurityUtil.getUser().getId();
    // 向上取整 几分钟 几分钟再乘以单位价格
    double minutes = Math.ceil(length / Double.parseDouble(textPerMin));
    Dict price = dictService.getOne(Wrappers.<Dict>query().eq("code", "人工配音单位时间价格"));
    if (price != null) {
      perMinute = price.getVal();
    }
    double amount = Double.parseDouble(perMinute) * minutes;
    BigDecimal totalAmount = BigDecimal.valueOf(amount);
    Balance balance = balanceService.getByUserId(userId);

    if (balance != null && balance.getAudioTime() > 0) {
      totalAmount = MoneyUtil.moneySub(totalAmount, BigDecimal.valueOf(balance.getAudioTime()));
    }

    Assert.isTrue(MoneyUtil.equals(totalAmount.toString(), orderVo.getTotalAmount()), "订单价格异常");

    TradePlus trade = TradePlus.builder().outTradeNo(aliPayUtils.getOrderCode()).subject(subject)
      .totalAmount(totalAmount.toString()).build();
    // 人工配音的下单方式
    Order order = new Order();
    order.setTotalAmount(totalAmount.toString());
    order.setType(DUBBING);

    order.setUserId(userId);
    order.setContent(content);
    order.setDescription(String.valueOf(orderVo.getVoiceType()));
    order.setVideoId(orderVo.getOrderId());
    order.setState(NOT_STARTED);

    baseMapper.insert(order);
    PurchaseRecord record = PurchaseRecord.buildDub(trade, order.getId());
    recordService.save(record);

    return aliPayService.toPayAsPc(trade);
  }

  public String generateAudio(String text, String orderId) {
    return generateAudio(text, orderId, "");
  }

  public String generateAudio(String text, String orderId, String voiceType) {
    TtsParams build = new TtsParams();
    build.setVoiceType(voiceType);
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
    Assert.notNull(order, "未查询到订单");
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
