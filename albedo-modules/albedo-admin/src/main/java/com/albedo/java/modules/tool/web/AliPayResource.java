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
import static com.alipay.api.msg.MsgConstants.SUCCESS;

import java.nio.charset.StandardCharsets;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.PlanService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.biz.util.MoneyUtil;
import com.albedo.java.modules.tool.domain.AlipayConfig;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.domain.vo.TradeVo;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import springfox.documentation.annotations.ApiIgnore;

/**
 * @author somewhere
 * @date 2018-12-31
 */
@Slf4j
@RestController
@RequestMapping(value = "${application.admin-path}/tool/aliPay")
@Api(tags = "支付宝管理")
public class AliPayResource {

  @Resource
  AliPayUtils alipayUtils;
  @Resource
  AliPayService alipayService;

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
    TradePlus build = TradePlus.builder().totalAmount(trade.getTotalAmount()).subject(trade.getSubject()).build();
    String payUrl = alipayService.toPayAsPc(build);
    return Result.buildOkData(payUrl);
  }

  @Resource
  OrderService orderService;

  @ApiIgnore
  @GetMapping("/return")
  @ApiOperation("回调接口")
  public Result<String> returnPage(HttpServletRequest request) {
    AlipayConfig alipay = alipayService.find();
    // 内容验签，防止黑客篡改参数
    if (alipayUtils.rsaCheck(request, alipay)) {
      String update = update(request);
      if (StringUtils.equals(SUCCESS.toLowerCase(), update)) {
        return Result.buildOk("支付成功");
      }
    } else {
      // 根据业务需要返回数据
      return Result.buildFail("支付异常");
    }
    return null;
  }

  @Resource
  PurchaseRecordService recordService;

  /**
   * 商户需要验证该通知数据中的 out_trade_no 是否为商户系统中创建的订单号；
   * 判断 total_amount 是否确实为该订单的实际金额（即商户订单创建时的金额）；
   * 校验通知中的 seller_id（或者 seller_email) 是否为 out_trade_no 这笔单据的对应的操作方
   * （有的时候，一个商户可能有多个 seller_id/seller_email）；
   * 验证 app_id 是否为该商户本身。
   *
   * @param request
   * @return
   */
  @ApiIgnore
  @PostMapping("/notify")
  @ApiOperation("异步通知接口")
  public String notify(HttpServletRequest request) {
    AlipayConfig alipay = alipayService.find();
    String appId = getParam(request, "app_id");
    Assert.isTrue(StringUtils.equals(appId, alipay.getAppId()), "");
    if (alipayUtils.rsaCheck(request, alipay)) {
      String update = update(request);
      if (StringUtils.equals(SUCCESS.toLowerCase(), update)) {
        return update;
      }
    }
    return "";
  }

  private String update(HttpServletRequest request) {
    // 订单状态 似乎没有这个字段
    // String tradeStatus = getParam(request, "trade_status");
    // Assert.isTrue(StringUtils.equals(tradeStatus, TRADE_SUCCESS), "");
    // 商户订单号
    String outTradeNo = getParam(request, "out_trade_no");
    PurchaseRecord record = recordService.getOne(Wrappers.<PurchaseRecord>query().eq("out_trade_no", outTradeNo));
    Assert.notNull(record, "未查询到交易记录");
    // 商户号
    String sellerId = getParam(request, "seller_id");
    // 2088621955056287
    Assert.isTrue(sellerId.equals(record.getSellerId()), "商户号为空");
    // 付款金额
    String totalAmount = getParam(request, "total_amount");
    Assert.isTrue(MoneyUtil.equals(totalAmount, record.getTotalAmount().toString()), "金额数量异常");
    // appId
    boolean callback = false;
    record.setStatus(TRADE_FINISHED);
    record.setAvailable("1");
    recordService.updateById(record);
    if (PLAN_TYPE.equals(record.getType())) {
      callback = planService.callback(outTradeNo);
    } else if (ORDER_TYPE.equals(record.getType())) {
      callback = orderService.callback(record.getOuterId());
    }
    if (callback) {
      return "success";
    } else {
      return null;
    }
  }

  @Resource
  PlanService planService;

  private String getParam(HttpServletRequest request, String paramName) {
    String parameter = request.getParameter(paramName);
    if (StringUtils.isEmpty(parameter)) {
      return "";
    }
    return new String(parameter.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
  }
}
