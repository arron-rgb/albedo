/*
 * Copyright 2019-2020 somewhere
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.albedo.java.modules.tool.web;

import static com.albedo.java.common.core.constant.BusinessConstants.TRADE_SUCCESS;

import java.nio.charset.StandardCharsets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.AnonymousAccess;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.tool.domain.AlipayConfig;
import com.albedo.java.modules.tool.domain.vo.TradeVo;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import springfox.documentation.annotations.ApiIgnore;

/**
 * @author somewhere
 * @date 2018-12-31
 */
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("${application.admin-path}/tool/aliPay")
@Api(tags = "工具：支付宝管理")
public class AliPayResource {

  private final AliPayUtils alipayUtils;
  private final AliPayService alipayService;

  @GetMapping
  public Result<AlipayConfig> get() {
    return Result.buildOkData(alipayService.find());
  }

  @LogOperate("配置支付宝")
  @ApiOperation("配置支付宝")
  @PutMapping
  public Result<Object> updateConfig(@Validated @RequestBody AlipayConfig alipayConfig) {
    alipayService.config(alipayConfig);
    return new Result<>(HttpStatus.OK);
  }

  @LogOperate("支付宝PC网页支付")
  @ApiOperation("PC网页支付")
  @PostMapping(value = "/toPayAsPC")
  public Result<String> toPayAsPc(@Validated @RequestBody TradeVo trade) throws Exception {
    AlipayConfig aliPay = alipayService.find();
    trade.setOutTradeNo(alipayUtils.getOrderCode());
    String payUrl = alipayService.toPayAsPc(aliPay, trade);
    return Result.buildOkData(payUrl);
  }

  @ApiIgnore
  @GetMapping("/return")
  @AnonymousAccess
  @ApiOperation("支付之后跳转的链接")
  public Result<String> returnPage(HttpServletRequest request, HttpServletResponse response) {
    AlipayConfig alipay = alipayService.find();
    response.setContentType("text/html;charset=" + alipay.getCharset());
    // 内容验签，防止黑客篡改参数
    if (alipayUtils.rsaCheck(request, alipay)) {
      // 商户订单号
      String outTradeNo = getParam(request, "out_trade_no");
      // 支付宝交易号
      String tradeNo = getParam(request, "trade_no");
      // 根据业务需要返回数据，这里统一返回OK
      // return new Result<>("payment successful", HttpStatus.OK);
    } else {
      // 根据业务需要返回数据
      // return new Result<>(HttpStatus.BAD_REQUEST);
    }
    return null;
  }

  @ApiIgnore
  @RequestMapping("/notify")
  @AnonymousAccess
  @ApiOperation("")
  public Result<Object> notify(HttpServletRequest request) {
    AlipayConfig alipay = alipayService.find();

    if (alipayUtils.rsaCheck(request, alipay)) {
      // 交易状态
      String tradeStatus = getParam(request, "trade_status");
      if (!StringUtils.equals(tradeStatus, TRADE_SUCCESS)) {
        return new Result<>(HttpStatus.BAD_REQUEST);
      }
      // 商户订单号
      String outTradeNo = getParam(request, "out_trade_no");
      // 付款金额
      String totalAmount = getParam(request, "total_amount");
      // 支付宝交易号
      String tradeNo = getParam(request, "trade_no");
      // 验证通过后应该根据业务需要处理订单
      planService.callback(outTradeNo);
      return new Result<>(HttpStatus.OK);
    }
    return new Result<>(HttpStatus.BAD_REQUEST);
  }

  @Resource
  PlanService planService;

  private String getParam(HttpServletRequest request, String paramName) {
    return new String(request.getParameter(paramName).getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
  }
}
