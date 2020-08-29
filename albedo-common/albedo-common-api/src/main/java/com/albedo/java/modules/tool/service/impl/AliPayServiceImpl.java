/*
 * Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
 * <p>
 * Licensed under the GNU Lesser General Public License 3.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * https://www.gnu.org/licenses/lgpl.html
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.modules.tool.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.core.jackson.JavaTimeModule;
import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.tool.domain.AlipayConfig;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.domain.vo.TradeQueryPlus;
import com.albedo.java.modules.tool.domain.vo.TradeVo;
import com.albedo.java.modules.tool.repository.AliPayConfigRepository;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.alipay.api.response.AlipayTradeQueryResponse;
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
  public String toPayAsPc(TradeVo trade) throws Exception {
    AlipayConfig alipay = find();
    trade.setOutTradeNo(aliPayUtils.getOrderCode());
    return toPayAsPc(alipay, trade);
  }

  @Override
  public String toPayAsPc(TradePlus trade) throws Exception {
    AlipayConfig alipay = find();
    trade.setOutTradeNo(aliPayUtils.getOrderCode());
    return toPayAsPc(alipay, trade);
  }

  private String toPayAsPc(AlipayConfig alipay, TradePlus trade) throws Exception {
    if (alipay.getId() == null) {
      throw new BadRequestException("请先添加相应配置，再操作");
    }
    AlipayClient alipayClient = buildAlipayClient();
    AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
    request.setReturnUrl(alipay.getReturnUrl());
    request.setNotifyUrl(alipay.getNotifyUrl());
    request.setBizContent(mapper.writeValueAsString(trade));
    return alipayClient.pageExecute(request, "GET").getBody();
  }

  @Override
  public String toPayAsPc(AlipayConfig alipay, TradeVo trade) throws Exception {
    if (alipay.getId() == null) {
      throw new BadRequestException("请先添加相应配置，再操作");
    }
    AlipayClient alipayClient = buildAlipayClient();
    AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
    request.setReturnUrl(alipay.getReturnUrl());
    request.setNotifyUrl(alipay.getNotifyUrl());
    // {"out_trade_no":"202008292138176837","product_code":"FAST_INSTANT_TRADE_PAY","total_amount":"1","subject":"1"}
    TradePlus plus = new TradePlus();
    BeanUtils.copyProperties(trade, plus);
    request.setBizContent(mapper.writeValueAsString(plus));
    return alipayClient.pageExecute(request, "GET").getBody();
  }

  private final ObjectMapper mapper =
    new ObjectMapper().registerModule(new JavaTimeModule()).registerModule(new Jdk8Module())
      .setPropertyNamingStrategy(PropertyNamingStrategy.CAMEL_CASE_TO_LOWER_CASE_WITH_UNDERSCORES)
      .setSerializationInclusion(JsonInclude.Include.NON_NULL);

  @Override
  public String toPayAsWeb(AlipayConfig alipay, TradeVo trade) throws Exception {
    if (alipay.getId() == null) {
      throw new BadRequestException("请先添加相应配置，再操作");
    }
    AlipayClient alipayClient = buildAlipayClient();
    double money = Double.parseDouble(trade.getTotalAmount());
    double maxMoney = 5000;
    if (money <= 0 || money >= maxMoney) {
      throw new BadRequestException("测试金额过大");
    }
    // 创建API对应的request(手机网页版)
    AlipayTradeWapPayRequest request = new AlipayTradeWapPayRequest();
    request.setReturnUrl(alipay.getReturnUrl());
    // 收不到异步通知自查方案-支付宝接口常见错误系列 https://openclub.alipay.com/club/history/read/1677
    request.setNotifyUrl(alipay.getNotifyUrl());
    request.setBizContent("{" + "'out_trade_no':'" + trade.getOutTradeNo() + "',"
      + "'product_code':'FAST_INSTANT_TRADE_PAY'," + "'total_amount':" + trade.getTotalAmount() + "," + "'subject':'"
      + trade.getSubject() + "'," + "'body':'" + trade.getBody() + "'," + "'extend_params':{"
      + "'sys_service_provider_id':'" + alipay.getSysServiceProviderId() + "'" + "}" + "  }");
    return alipayClient.pageExecute(request, "GET").getBody();
  }

  @Override
  public String queryOrderStatus(String outTradeNo) throws AlipayApiException {
    if (StringUtils.isBlank(outTradeNo)) {
      return "";
    }
    AlipayClient alipayClient = buildAlipayClient();

    AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
    TradeQueryPlus query = TradeQueryPlus.builder().outTradeNo(outTradeNo).build();
    try {
      request.setBizContent(mapper.writeValueAsString(query));
    } catch (JsonProcessingException ignored) {
      request.setBizContent("");
    }

    AlipayTradeQueryResponse response = alipayClient.execute(request);
    if (!response.isSuccess()) {
      return "";
    }
    return response.getTradeStatus();
  }

  private AlipayClient buildAlipayClient() {
    AlipayConfig alipay = find();
    return new DefaultAlipayClient(alipay.getGatewayUrl(), alipay.getAppId(), alipay.getPrivateKey(),
      alipay.getFormat(), alipay.getCharset(), alipay.getPublicKey(), alipay.getSignType());
  }

}
