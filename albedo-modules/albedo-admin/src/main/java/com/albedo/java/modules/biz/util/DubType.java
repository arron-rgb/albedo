package com.albedo.java.modules.biz.util;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.ExceptionNames.PRICE_ERROR;
import static com.albedo.java.common.core.constant.ExceptionNames.PRICE_FIELD_NOT_FOUND;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;

import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.*;
import com.albedo.java.modules.biz.repository.OrderRepository;
import com.albedo.java.modules.biz.repository.VideoRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.math.Money;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Data
@NoArgsConstructor
@Slf4j
public class DubType {

  String textPerMin = "200";
  String subject = "人工配音";
  String perMinute = "100";
  @Resource
  RedisTemplate<String, String> redisTemplate;
  @Resource
  DictService dictService;
  @Resource
  BalanceService balanceService;
  @Resource
  AliPayService aliPayService;
  @Resource
  OrderRepository baseMapper;
  @Resource
  OssSingleton ossSingleton;
  @Resource
  OrderService orderService;
  @Resource
  VideoRepository videoRepository;

  private DubType instance;

  private SubOrderVo orderVo;
  private Video video;

  public DubType(SubOrderVo orderVo, Video video) {
    this.orderVo = orderVo;
    this.video = video;
  }

  public String invoke() {
    switch (orderVo.getType()) {
      case 0:
        instance = new Self();
        break;
      case 2:
        instance = new Machine();
        break;
      case 1:
        instance = new Artificial();
        break;
      default:
        instance = null;
        log.error("instance is null");
        return "";
    }
    redisTemplate.opsForList().rightPush("video_encode", video.getId());

    return instance.invoke(orderVo, video);
  }

  public String invoke(SubOrderVo orderVo, Video video) {
    return "";
  }

  static class Self extends DubType {
    @Override
    public String invoke(SubOrderVo orderVo, Video video) {
      super.invoke(orderVo, video);
      Assert.notEmpty(orderVo.getAudioUrl(), "音频链接不得为空，请检查后重试");
      video.setAudioUrl(orderVo.getAudioUrl());
      videoRepository.updateById(video);
      return "";
    }
  }

  static class Machine extends DubType {
    @Override
    public String invoke(SubOrderVo orderVo, Video video) {
      List<String> voiceTypes = orderVo.getVoiceType();
      Assert.notEmpty(voiceTypes, "请选择配音音色");
      String voiceType = voiceTypes.get(0);
      String filePath = orderService.generateAudio(orderVo.getContent(), orderVo.getOrderId(), voiceType);
      Assert.notEmpty(orderVo.getContent(), "配音文本不允许为空");
      String audioUrl = ossSingleton.getUrl(filePath);
      video.setVoiceType(voiceType);
      video.setAudioText(orderVo.appendContent());
      video.setAudioUrl(audioUrl);
      video.updateById();
      return "";
    }
  }

  static class Artificial extends DubType {
    @Override
    public String invoke(SubOrderVo orderVo, Video video) {
      Assert.notEmpty(orderVo.getTotalAmount(), PRICE_FIELD_NOT_FOUND);
      String content = orderVo.appendContent();
      int length = orderVo.appendContent().length();
      String userId = SecurityUtil.getUser().getId();
      // 向上取整 几分钟 几分钟再乘以单位价格
      Integer minutes = Double.valueOf(Math.ceil(length / Double.parseDouble(textPerMin))).intValue();
      Dict price = dictService.getOne(Wrappers.<Dict>query().eq("code", "人工配音单位时间价格"));
      if (price != null) {
        perMinute = price.getVal();
      }
      double amount = Double.parseDouble(perMinute) * minutes;
      BigDecimal totalAmount = BigDecimal.valueOf(amount);
      Balance balance = balanceService.getByUserId(userId);
      String orderId = orderVo.getOrderId();
      Order order = orderService.getOne(Wrappers.<Order>lambdaQuery().eq(Order::getVideoId, orderId), false);
      if (order == null) {
        order = new Order();
      }
      // 人工配音的下单方式
      order.setTotalAmount(totalAmount.toString());
      order.setType(DUBBING);
      order.setUserId(userId);
      order.setContent(content);
      order.setDescription(String.valueOf(orderVo.getVoiceType()));
      order.setVideoId(orderId);
      order.setState(UNPAID_ORDER);
      order.insertOrUpdate();

      if (balance != null) {
        Integer audioTime = balance.getAudioTime();
        // audioTime为可抵扣的时间 单位为分
        if (audioTime >= minutes) {
          // 可抵扣
          balance.setAudioTime(audioTime - minutes);
          balanceService.updateById(balance);
          order.setState(NOT_STARTED);
          baseMapper.updateById(order);
          return "支付成功，请等待工作人员接单";
        } else {
          // 不够抵扣 计算剩余应该支付的价格
          balance.setAudioTime(0);
          balanceService.updateById(balance);
          amount = Double.parseDouble(perMinute) * (minutes - audioTime);
          totalAmount = new BigDecimal(amount);
          order.setTotalAmount(totalAmount.toPlainString());
          order.updateById();
        }
      }
      Assert.isTrue(new Money(totalAmount).equals(new Money(orderVo.getTotalAmount())), PRICE_ERROR);
      TradePlus trade = TradePlus.build(totalAmount.toPlainString(), subject);
      PurchaseRecord record = PurchaseRecord.buildDub(trade, order.getId());
      record.insert();
      return aliPayService.toPayAsPc(trade);
    }
  }
}
