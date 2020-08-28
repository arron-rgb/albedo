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

import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.tool.domain.AlipayConfig;
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
    trade.setOutTradeNo(AliPayUtils.getOrderCode());
    return toPayAsPc(alipay, trade);
  }

  @Override
  public String toPayAsPc(AlipayConfig alipay, TradeVo trade) throws Exception {
    if (alipay.getId() == null) {
      throw new BadRequestException("请先添加相应配置，再操作");
    }
    AlipayClient alipayClient = buildAlipayClient();
    // 创建API对应的request(电脑网页版)
    AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();

    // 订单完成后返回的页面和异步通知地址
    request.setReturnUrl(alipay.getReturnUrl());
    request.setNotifyUrl(alipay.getNotifyUrl());

    // 填充订单参数 todo 修改字段值 与业务对齐
    request.setBizContent("{" + "'out_trade_no':'" + trade.getOutTradeNo() + "',"
      + "'product_code':'FAST_INSTANT_TRADE_PAY'," + "'total_amount':" + trade.getTotalAmount() + "," + "'subject':'"
      + trade.getSubject() + "'," + "'body':'" + trade.getBody() + "'," + "'extend_params':{"
      + "'sys_service_provider_id':'" + alipay.getSysServiceProviderId() + "'" + "}" + "  }");// 填充业务参数
    // 调用SDK生成表单, 通过GET方式，口可以获取url
    return alipayClient.pageExecute(request, "GET").getBody();
  }

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
    request.setNotifyUrl(alipay.getNotifyUrl());
    request.setBizContent("{" + "'out_trade_no':'" + trade.getOutTradeNo() + "',"
      + "'product_code':'FAST_INSTANT_TRADE_PAY'," + "'total_amount':" + trade.getTotalAmount() + "," + "'subject':'"
      + trade.getSubject() + "'," + "'body':'" + trade.getBody() + "'," + "'extend_params':{"
      + "'sys_service_provider_id':'" + alipay.getSysServiceProviderId() + "'" + "}" + "  }");
    return alipayClient.pageExecute(request, "GET").getBody();
  }

  @Override
  public String queryOrderStatus(String outTradeNo) throws AlipayApiException {
    AlipayClient alipayClient = buildAlipayClient();

    AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
    request.setBizContent("{" + "'out_trade_no':'20150320010101001'," + "'trade_no':'2014112611001004680 073956707',"
      + "'org_pid':'2088101117952222'," + "      'query_options':[" + "        'trade_settle_info'" + "      ]"
      + "  }");
    AlipayTradeQueryResponse response = alipayClient.execute(request);
    if (response.isSuccess()) {
      System.out.println("调用成功");
    } else {
      System.out.println("调用失败");
    }
    // todo 查询订单状态
    return "";
  }

  private AlipayClient buildAlipayClient() {
    AlipayConfig alipay = find();
    return new DefaultAlipayClient(alipay.getGatewayUrl(), alipay.getAppId(), alipay.getPrivateKey(),
      alipay.getFormat(), alipay.getCharset(), alipay.getPublicKey(), alipay.getSignType());
  }

}
