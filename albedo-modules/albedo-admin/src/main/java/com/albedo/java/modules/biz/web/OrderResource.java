/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.dto.OrderQueryCriteria;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.tool.domain.AlipayConfig;
import com.albedo.java.modules.tool.service.AliPayService;
import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 订单Controller Order
 *
 * @author admin
 * @version 2020-08-18 10:19:40
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/order")
@AllArgsConstructor
public class OrderResource extends BaseResource {

  private final OrderService service;

  /**
   * @param id
   * @return
   */
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_order_view')")
  public Result get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getById(id));
  }

  /**
   * GET / : get all Order.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all Order
   */

  @PreAuthorize("@pms.hasPermission('biz_order_view')")
  @GetMapping
  @LogOperate(value = "订单查询")
  public Result<PageModel> getPage(PageModel pm, OrderQueryCriteria orderQueryCriteria) {
    QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, orderQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  /**
   * POST / : Save a OrderDto.
   *
   * @param orderDto
   *          the HTTP Order
   */
  @PreAuthorize("@pms.hasPermission('biz_order_edit')")
  @LogOperate(value = "订单编辑")
  @PostMapping
  public Result save(@Valid @RequestBody Order orderDto) {
    service.saveOrUpdate(orderDto);
    return Result.buildOk("保存Order成功");

  }

  /**
   * DELETE //:ids : delete the "ids" Order.
   *
   * @param ids
   *          the id of the Order to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_order_del')")
  @LogOperate(value = "订单删除")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    log.debug("REST request to delete Order: {}", ids);
    service.removeByIds(ids);
    return Result.buildOk("删除Order成功");
  }

  @GetMapping("/purchase?orderId={orderId}")
  public Result<String> purchase(@PathVariable(value = "orderId") String orderId) {
    return Result.buildOk(service.price(orderId));
  }

  @Resource
  AliPayService aliPayService;

  @PostMapping("/callback")
  public String callback(@RequestParam String resultInfo) {
    boolean signVerified = isSignVerified(resultInfo);
    if (!signVerified) {
      return "";
    }
    // todo
    return "success";
  }

  /**
   * 验签
   *
   * @param resultInfo
   * @return
   */
  private boolean isSignVerified(String resultInfo) {
    AlipayConfig alipayConfig = aliPayService.find();
    // 编码格式
    String charset = "utf-8";
    // 支付宝公钥
    String publicKey = alipayConfig.getPublicKey();
    // 签名方式
    String signType = "RSA2";
    // 对待签名字符串数据通过&进行拆分
    String[] temp = resultInfo.split("&");
    Map<String, String> map = new LinkedHashMap<>();
    // 把拆分数据放在map集合内
    for (String s : temp) {
      String[] arr = s.split("=", 2);
      String[] tempAgain = new String[arr.length];
      System.arraycopy(arr, 0, tempAgain, 0, arr.length);
      map.put(tempAgain[0], tempAgain[1]);
    }
    // 验签方法
    boolean signVerified = false;
    try {
      signVerified = AlipaySignature.rsaCheckV1(map, publicKey, charset, signType);
    } catch (AlipayApiException e) {
      e.printStackTrace();
    }
    return signVerified;
  }

  @GetMapping("/list")
  public Result<List<Order>> list() {
    return Result.buildOkData(service.availableOrder());
  }

  @PostMapping(value = "/upload")
  public Result<String> uploadVideo(@RequestParam("file") MultipartFile file, String orderId) {
    try {
      videoService.uploadVideo(orderId, file);
    } catch (IOException e) {
      return Result.buildFail("保存失败");
    }
    return Result.buildOk("上传成功");
  }

  @Resource
  PurchaseRecordService purchaseRecordService;

  @Resource
  VideoService videoService;

  @Data
  class Request {
    LocalDate notifyTime;
    /**
     * 通知类型
     */
    String notifyType;
    String notifyId;
    String charset;
    String version;
    String sellerId;
    /**
     * RSA2
     */
    String signType;
    /**
     * 需验签
     */
    String sign;
    /**
     * 同appId
     */
    String authAppId;
    String appId;
    String tradeNo;
    /**
     * 原支付请求的商户订单号
     */
    String outTradeNo;
    /**
     * 交易状态，Business中状态枚举类
     */
    String tradeStatus;
    /**
     * 支付金额
     */
    BigDecimal buyerPayAmount;
    /**
     * 订单金额，用于验证
     */
    BigDecimal totalAmount;
    /**
     * 实收金额
     */
    BigDecimal receiptAmount;
  }

}
