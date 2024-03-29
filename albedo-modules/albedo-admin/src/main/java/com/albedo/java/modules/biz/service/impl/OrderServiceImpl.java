package com.albedo.java.modules.biz.service.impl;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.math.Money;
import cn.hutool.core.util.IdUtil;
import com.albedo.java.common.core.constant.BusinessConstants;
import com.albedo.java.common.core.exception.OrderException;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.FileUploadUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.*;
import com.albedo.java.modules.biz.domain.dto.OrderDto;
import com.albedo.java.modules.biz.domain.dto.OrderVo;
import com.albedo.java.modules.biz.repository.OrderRepository;
import com.albedo.java.modules.biz.service.*;
import com.albedo.java.modules.biz.util.FfmpegUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.domain.TtsParams;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.albedo.java.modules.tool.util.TtsSingleton;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.CommonConstants.*;
import static com.albedo.java.common.core.constant.ExceptionNames.*;

/**
 * @author arronshentu
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class OrderServiceImpl extends DataServiceImpl<OrderRepository, Order, OrderDto, String>
  implements OrderService {

  @Resource
  UserService userService;
  @Resource
  CouponService couponService;
  @Resource
  PurchaseRecordService recordService;
  @Resource
  DubService dubService;
  @Resource
  AliPayService aliPayService;
  @Resource
  BalanceService balanceService;

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
    // todo 似乎还有问题
    return getOne(Wrappers.<Order>query().eq("user_id", SecurityUtil.getUser().getId()).ne("type", DUBBING)
      .lt("state", BusinessConstants.VALID).orderByAsc("created_date"), false);
  }

  @Override
  @Transactional(rollbackFor = Exception.class)
  public String place(OrderVo form) {
    Order order;
    if (!Objects.isNull(currentOrder())) {
      order = currentOrder();
      if (StringUtils.isNotEmpty(form.getCouponCode())) {
        Assert.isTrue(StringUtil.isBlank(order.getCouponCode()), "订单已使用优惠码");
      }
    } else {
      order = new Order();
      BeanUtils.copyProperties(form, order);
    }
    String couponCode = form.getCouponCode();
    // 验证是否优惠码有效
    if (StringUtil.isNotEmpty(couponCode)) {
      Coupon coupon = couponService.getOne(Wrappers.<Coupon>query().eq("code", couponCode).eq("status", STR_YES));
      Assert.notNull(coupon, INVALID_COUPON);
      coupon.setUserId(SecurityUtil.getUser().getId());
      coupon.setOrderId(order.getId());
      coupon.setStatus(STR_NO);
      coupon.updateById();
    }
    order.setState(UNPAID_ORDER);
    order.setCouponCode(form.getCouponCode());
    order.setUserId(SecurityUtil.getUser().getId());
    order.setContent(StringEscapeUtils.unescapeHtml4(form.getContent()));
    order.setTotalAmount(calculatePrice(form));
    Assert.isTrue(compareOrderPrice(form, order), PRICE_ERROR);
    boolean flag = order.insertOrUpdate();
    Assert.isTrue(flag, "下单失败");
    if ("balance".equals(order.getMethod()) && new Money(order.getTotalAmount()).equals(new Money())) {
      price(order.getId(), "");
    }
    return order.getId();
  }

  private boolean verifyOrderType(OrderVo form) {
    return StringUtils.equals(ACCELERATE, form.getType());
  }

  private boolean compareOrderPrice(OrderVo form, Order order) {
    return new Money(form.getTotalAmount()).equals(new Money(order.getTotalAmount()));
  }

  @Override
  public String price(String orderId, String subject) {
    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    Assert.isTrue(UNPAID_ORDER.equals(order.getState()), ORDER_ERROR);
    boolean purchaseFlag = false;
    TradePlus plus;
    PurchaseRecord record =
      recordService.getOne(Wrappers.<PurchaseRecord>lambdaQuery().eq(PurchaseRecord::getOuterId, orderId), false);
    switch (order.getMethod()) {
      case "ali":
        // 需要支付就break 走后面的公共方法
        plus = TradePlus.build(order.getTotalAmount(), subject);
        break;
      case "balance":
        // 扣了次数后，如果不需要额外支付，则将订单设为已支付
        // 减了次数，没支付成功；订单仍然处在未支付的状态
        balanceService.consumeTimes();
        // 加速订单
        Money money = new Money();
        purchaseFlag = money.equals(new Money(order.getTotalAmount()));
        // 无需获取支付链接
        if (purchaseFlag) {
          order.setState(NOT_STARTED);
          baseMapper.updateById(order);
          return "success";
        } else {
          // 需要获取支付链接
          plus = TradePlus.build(money.getAmount().toPlainString(), subject);
          break;
        }
      case "wechat":
        throw new RuntimeMsgException(WECHAT_PAY_ERROR);
      default:
        throw new RuntimeMsgException(PAY_METHOD_ERROR);
    }
    // 获取支付链接需要 1. 更新record的outTradeNo 2. 插入record
    if (record == null) {
      record = PurchaseRecord.buildOrder(plus, order.getId());
    } else {
      record.setOutTradeNo(plus.getOutTradeNo());
    }
    recordService.saveOrUpdate(record);
    return getPurchaseUrl(plus);
  }

  private String getPurchaseUrl(TradePlus plus) {
    return aliPayService.toPayAsPc(plus);
  }

  @Resource
  DictService dictService;

  private String getAnchorNum(String content) {
    PlusService<Config> plusService;
    try {
      plusService = JSON.parseObject(content.trim(), new TypeReference<PlusService<Config>>() {
      });
    } catch (JSONException e) {
      throw new RuntimeMsgException(ORDER_PARSE_ERROR);
    }
    Assert.notNull(plusService, ORDER_PARSE_ERROR);
    List<Element<Config>> elements = plusService.getData().stream()
      .filter((element -> "主播数量".equals(element.getTitle()))).collect(Collectors.toList());
    Assert.isTrue(elements.size() == 1, ANCHOR_NUM_ERROR);
    List<Config> anchorNumList = elements.get(0).getData();
    Assert.isTrue(anchorNumList.size() == 1, ANCHOR_NUM_ERROR);
    Config config = anchorNumList.get(0);
    return config.getValue();
  }

  private void add(Money price, String addValue) {
    price.addTo(new Money(addValue));
  }

  private String calculatePrice(OrderVo order) {
    // 1. 主播价格
    Money price = new Money();
    String content = order.getContent().trim();
    String anchorNum = getAnchorNum(content);
    Dict priceDict = dictService.getOne(Wrappers.<Dict>query().eq("name", anchorNum));
    add(price, Optional.ofNullable(priceDict).orElse(new Dict(defaultPrice(anchorNum))).getVal());
    // 2. 加速服务
    if (verifyOrderType(order)) {
      Dict map = dictService.getOne(Wrappers.<Dict>query().eq("code", BusinessConstants.ACCELERATE_STR));
      String accPrice = Optional.ofNullable(map).orElse(new Dict("99")).getVal();
      add(price, accPrice);
    }
    // 3. 余额 减一个单人主播的价格
    if ("balance".equals(order.getMethod())) {
      price.subtractFrom(new Money(defaultPrice(SINGLE_ANCHOR)));
    }
    // 4. 打折
    if (StringUtils.isNotEmpty(order.getCouponCode())) {
      Coupon code = couponService.getOne(Wrappers.<Coupon>query().eq("code", order.getCouponCode()));
      code = Optional.ofNullable(code).orElse(new Coupon("1.0"));
      String discount = code.getDiscount();
      price.multiplyBy(Double.parseDouble(discount));
    }
    return price.getAmount().toPlainString();
  }

  private String defaultPrice(String type) {
    switch (type) {
      case SINGLE_ANCHOR:
        return "1599";
      case DOUBLE_ANCHOR:
        return "2599";
      default:
        throw new RuntimeMsgException("订单主播类型状态异常");
    }
  }

  @Override
  public void consume(String orderId) throws OrderException {
    String staffId = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();
    Assert.isTrue(roles.contains(ADMIN_ROLE_ID), CONSUME_NOT_PERMITTED);
    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    Assert.isTrue(NOT_STARTED.equals(order.getState()), "订单状态异常");
    Assert.isTrue(StringUtils.isEmpty(order.getStaffId()), "该订单已被认领");
    order.setStaffId(staffId);
    order.setState(IN_PRODUCTION);
    saveOrUpdate(order);
  }

  @Override
  public List<Order> availableOrder() {
    return baseMapper
      .selectList(Wrappers.<Order>lambdaQuery().eq(Order::getState, NOT_STARTED).isNull(Order::getStaffId));
  }

  @Resource
  OssSingleton ossSingleton;

  @Override
  public Video updateForm(SubOrderVo orderVo) {
    if (!UPLOAD_AUDIO.equals(orderVo.getType())) {
      Assert.notEmpty(orderVo.getContent(), "配音文本不允许为空");
    }
    String orderId = orderVo.getOrderId();
    Order order = baseMapper.selectById(orderId);
    Balance balance = balanceService.getByUserId(order.getUserId());
    Long duration = orderVo.getDuration();
    Assert.isTrue(balance.getVideoTime().longValue() * 60 > duration, "视频时长超出套餐允许");
    LocalDateTime availableDate = order.getCreatedDate().plusDays(balance.getLicenseDuration());
    if (availableDate.isBefore(LocalDateTime.now())) {
      order.setState(FINISHED);
      order.updateById();
      throw new RuntimeMsgException("该订单已超过有效期，请重新下单");
    }
    Video video = Video.builder().dubType(orderVo.getType()).audioText(orderVo.getContentText())
      .userId(order.getUserId()).orderId(orderId).build();
    video.insert();
    return video;
  }

  @Override
  public void uploadAudio(String orderId, String audioUrl) {
    Order audioOrder = baseMapper.selectById(orderId);
    Assert.notNull(audioOrder, ORDER_NOT_FOUND);
    Assert.isTrue(Objects.equals(audioOrder.getType(), DUBBING), "订单类型不匹配");
    String videoOrderId = audioOrder.getVideoId();
    Order videoOrder = baseMapper.selectById(videoOrderId);
    Assert.notNull(videoOrder, ORDER_NOT_FOUND);
    Video video = Video.builder().orderId(videoOrderId).audioText(audioOrder.getContent())
      .userId(videoOrder.getUserId()).dubType(1).build();
    String uploadPath = userService.getUploadPath(videoOrder.getUserId());
    String objectName = ossSingleton.getPath(audioUrl);
    String filePath = uploadPath + File.separator + objectName;
    ossSingleton.downloadFile("vlivest-2", objectName, filePath);
    ossSingleton.uploadFileNonAsync(new File(filePath), objectName, userService.getBucketName(videoOrder.getUserId()));
    video.setAudioUrl(ossSingleton.getUrl(filePath));
    // video.setStatus("等待配音");
    video.insert();
    audioOrder.setState(FINISHED);
    audioOrder.updateById();
    redisTemplate.opsForList().rightPush("dub_task", video.getId());
  }

  @Resource
  RedisTemplate<String, String> redisTemplate;

  @Override
  public String generateAudio(List<String> text, String orderId, String voiceType) {
    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    String userId = order.getUserId();
    String bucketName = userService.getBucketName(userId);

    List<String> audioPaths = new ArrayList<>();
    text.forEach(content -> {
      TtsParams ttsParam = new TtsParams();
      ttsParam.setVoiceType(voiceType);
      ttsParam.setText(content);
      ttsParam.setCodec("mp3");
      String audioPath = FileUploadUtil.getBucketPath(bucketName, IdUtil.fastSimpleUUID() + "." + ttsParam.getCodec());
      ttsSingleton.generateAudio(ttsParam, audioPath);
      audioPaths.add(audioPath);
    });

    String audioPath = ffmpegUtil.concatMedia(audioPaths, bucketName);
    File audio = FileUtil.file(audioPath);
    ossSingleton.uploadFile(audio, FileUtil.getName(audio), bucketName);
    try {
      audioPaths.forEach(FileUtil::del);
    } catch (Exception ignored) {
    }
    return audio.getAbsolutePath();
  }

  @Resource
  FfmpegUtil ffmpegUtil;
  @Resource
  TtsSingleton ttsSingleton;

  @Override
  public List<Order> belongs() {
    List<String> roles = SecurityUtil.getRoles();
    Assert.isTrue(roles.contains(ADMIN_ROLE_ID), VIEW_NOT_PERMITTED);
    return baseMapper.selectList(Wrappers.<Order>query().eq("staff_id", SecurityUtil.getUser().getId()));
  }

  @Override
  public boolean callback(String orderId) {
    Order order = baseMapper.selectById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    Assert.isTrue(Objects.equals(order.getState(), UNPAID_ORDER), ORDER_ERROR);
    order.setState(NOT_STARTED);
    PurchaseRecord record = recordService.getOne(Wrappers.<PurchaseRecord>lambdaQuery()
      .eq(PurchaseRecord::getType, ORDER_TYPE).eq(PurchaseRecord::getOuterId, orderId));
    Assert.notNull(record, PURCHASE_RECORD_NOT_FOUND);
    record.setStatus(TRADE_FINISHED);
    recordService.updateById(record);
    return baseMapper.updateById(order) == 1;
  }

  @Override
  public Video getDub(String orderId) {
    return baseMapper.getDub(orderId);
  }

  @Override
  public String dub(SubOrderVo orderVo, Video video) {
    return dubService.dub(orderVo, video);
  }
}
