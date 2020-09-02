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

import static com.albedo.java.common.core.constant.BusinessConstants.*;

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
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.tool.domain.AlipayConfig;
import com.albedo.java.modules.tool.domain.vo.TradeVo;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

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

  @Resource
  PurchaseRecordService recordService;

  /**
   * 商户需要验证该通知数据中的 out_trade_no 是否为商户系统中创建的订单号；
   * 判断 total_amount 是否确实为该订单的实际金额（即商户订单创建时的金额）；
   * 校验通知中的 seller_id（或者 seller_email) 是否为 out_trade_no 这笔单据的对应的操作方（有的时候，一个商户可能有多个 seller_id/seller_email）；
   * 验证 app_id 是否为该商户本身。
   *
   * @param request
   * @return
   */
  @ApiIgnore
  @RequestMapping("/notify")
  @AnonymousAccess
  @ApiOperation("")
  public String notify(HttpServletRequest request) {
    AlipayConfig alipay = alipayService.find();
    String appId = getParam(request, "app_id");
    if (!StringUtils.equals(appId, alipay.getAppId())) {
      return "";
    }
    if (alipayUtils.rsaCheck(request, alipay)) {
      // 交易状态
      String tradeStatus = getParam(request, "trade_status");
      if (!StringUtils.equals(tradeStatus, TRADE_SUCCESS)) {
        return "";
      }
      // 商户订单号
      String outTradeNo = getParam(request, "out_trade_no");
      PurchaseRecord record = recordService.getOne(Wrappers.<PurchaseRecord>query().eq("out_trade_no", outTradeNo));
      if (record == null) {
        return "";
      }
      // 付款金额
      String totalAmount = getParam(request, "total_amount");
      if (!StringUtils.equals(totalAmount, record.getTotalAmount())) {
        return "";
      }
      // 验证通过后应该根据业务需要处理订单
      if (record.getType().equals(PLAN)) {
        planService.callback(outTradeNo);
      } else if (record.getType().equals(ORDER)) {
        orderService.callback(record.getOuterId());
      }
      return "success";
    }
    return "";
  }

  @Resource
  OrderService orderService;

  @Resource
  PlanService planService;

  private String getParam(HttpServletRequest request, String paramName) {
    return new String(request.getParameter(paramName).getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
  }
}
