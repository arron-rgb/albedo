package com.albedo.java.modules.tool.service.impl;

import static com.albedo.java.common.core.constant.BusinessConstants.PRODUCT_CODE;
import static com.albedo.java.common.core.constant.ExceptionNames.ALIPAY_ERROR;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.jackson.JavaTimeModule;
import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.tool.domain.AlipayConfig;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.domain.vo.TradeQueryPlus;
import com.albedo.java.modules.tool.repository.AliPayConfigRepository;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.response.AlipayTradePagePayResponse;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.aliyun.oss.HttpMethod;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;

import lombok.AllArgsConstructor;

/**
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@CacheConfig(cacheNames = CacheNameConstants.ALIPAY_DETAILS)
@AllArgsConstructor
public class AliPayServiceImpl extends BaseServiceImpl<AliPayConfigRepository, AlipayConfig> implements AliPayService {
  private final AliPayConfigRepository alipayRepository;
  private final AliPayUtils aliPayUtils;

  @Override
  @Cacheable(key = "'id:1'")
  public AlipayConfig find() {
    AlipayConfig alipayConfig = alipayRepository.selectById(1L);
    return alipayConfig == null ? new AlipayConfig() : alipayConfig;
  }

  @Override
  @CachePut(key = "'id:1'")
  @Transactional(rollbackFor = Exception.class)
  public AlipayConfig config(AlipayConfig alipayConfig) {
    alipayConfig.setId(1L);
    saveOrUpdate(alipayConfig);
    return alipayConfig;
  }

  @Override
  public String toPayAsPc(TradePlus trade) {
    AlipayConfig alipay = find();
    if (alipay.getId() == null) {
      throw new BadRequestException("请先添加相应配置，再操作");
    }
    // 必带参数下沉至此
    trade.setProductCode(PRODUCT_CODE);
    // 构造请求
    AlipayClient alipayClient = buildAlipayClient();
    AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
    request.setReturnUrl(alipay.getReturnUrl());
    request.setNotifyUrl(alipay.getNotifyUrl());
    try {
      request.setBizContent(mapper.writeValueAsString(trade));
      AlipayTradePagePayResponse response = alipayClient.pageExecute(request, HttpMethod.GET.name());
      return response.getBody();
    } catch (AlipayApiException e) {
      e.printStackTrace();
      throw new RuntimeMsgException(ALIPAY_ERROR);
    } catch (JsonProcessingException e) {
      e.printStackTrace();
      throw new RuntimeMsgException("订单结构解析异常");
    }
  }

  @Resource
  PurchaseRecordService recordService;

  private final ObjectMapper mapper = new ObjectMapper().registerModule(new JavaTimeModule())
    .registerModule(new Jdk8Module()).setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE)
    .setSerializationInclusion(JsonInclude.Include.NON_NULL);

  @Override
  public String queryOrderStatus(String outTradeNo) {
    if (StringUtils.isBlank(outTradeNo)) {
      return "";
    }
    AlipayClient alipayClient = buildAlipayClient();
    AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
    TradeQueryPlus query = TradeQueryPlus.builder().outTradeNo(outTradeNo).build();
    try {
      request.setBizContent(mapper.writeValueAsString(query));
      AlipayTradeQueryResponse response = alipayClient.execute(request);
      if (!response.isSuccess()) {
        return "";
      }
      return response.getTradeStatus();
    } catch (AlipayApiException e) {
      e.printStackTrace();
      throw new RuntimeMsgException("支付宝侧接口异常");
    } catch (JsonProcessingException ignored) {
      throw new RuntimeMsgException("参数序列化异常");
    }
  }

  private AlipayClient buildAlipayClient() {
    AlipayConfig alipay = find();
    return new DefaultAlipayClient(alipay.getGatewayUrl(), alipay.getAppId(), alipay.getPrivateKey(),
      alipay.getFormat(), alipay.getCharset(), alipay.getPublicKey(), alipay.getSignType());
  }

}
