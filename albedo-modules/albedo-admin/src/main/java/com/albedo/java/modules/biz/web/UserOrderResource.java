package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.BusinessConstants.NOT_UPDATED;
import static com.albedo.java.common.core.constant.BusinessConstants.PRODUCTION_COMPLETED;
import static com.albedo.java.common.core.constant.ExceptionNames.ORDER_NOT_FOUND;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.Token;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.SubOrderVo;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.OrderVo;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 订单Controller Order
 *
 * @author admin
 * @version 2020-08-18 10:19:40
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/order")
@AllArgsConstructor
@Api(tags = "用户相关订单接口")
public class UserOrderResource extends BaseResource {

  private final OrderService service;

  @Resource
  VideoService videoService;

  @ApiOperation(value = "查看当前订单")
  @GetMapping("/current")
  public Result<Order> currentOrder() {
    // 判断条件
    // 1. 当前用户的订单
    // 2. 未处于结单状态
    Order order = service.currentOrder();
    Assert.notNull(order, "未查询到正在进行的订单");
    Video video = videoService.getById(order.getVideoId());
    if (video != null && StringUtils.isNotEmpty(video.getOriginUrl())) {
      String originUrl = video.getOriginUrl();
      originUrl = ossSingleton.localPathToUrl(originUrl);

      if (StringUtils.isNotEmpty(video.getOutputUrl())) {
        originUrl = ossSingleton.localPathToUrl(video.getOutputUrl());
      }
      order.setVideoId(originUrl);
    }
    User user = userService.getById(order.getUserId());
    if (user != null) {
      String username = user.getUsername();
      if (StringUtils.isNotBlank(username)) {
        order.setUserId(username);
      }
    }

    return Result.buildOkData(order);
  }

  @Resource
  UserService userService;
  @Resource
  OssSingleton ossSingleton;

  @ApiOperation(value = "查看历史订单")
  @GetMapping("/list")
  public Result<List<Order>> listOrder() {
    List<Order> orders = service.list(Wrappers.<Order>query().eq("user_id", SecurityUtil.getUser().getId()));
    orders.forEach(order -> {
      Video video = videoService.getById(order.getVideoId());
      if (video != null) {
        String originUrl = video.getOriginUrl();
        originUrl = ossSingleton.localPathToUrl(originUrl);
        if (StringUtils.isNotEmpty(video.getOutputUrl())) {
          originUrl = ossSingleton.localPathToUrl(video.getOutputUrl());
        }
        order.setVideoId(originUrl);
      }
      User user = userService.getById(order.getUserId());
      if (user != null) {
        String username = user.getUsername();
        if (StringUtils.isNotBlank(username)) {
          order.setUserId(username);
        }
      }
    });
    return Result.buildOkData(orders);
  }

  @ApiOperation(value = "获取订单支付链接")
  @Token
  @PostMapping("/purchase")
  public Result<String> purchase(@RequestParam(value = "token", required = false) String token,
    @RequestParam(value = "orderId") String orderId, String subject) {
    return Result.buildOkData(service.price(orderId, subject));
  }

  @Resource
  PurchaseRecordService purchaseRecordService;

  @ApiOperation(value = "用户下单")
  @PostMapping(value = "/place")
  public Result<String> place(@RequestBody OrderVo orderVo) {
    return Result.buildOkData(service.place(orderVo), "下单成功");
  }

  @ApiOperation(value = "用户上传二次订单")
  @PostMapping(value = "/placeSecond")
  @Transactional(rollbackFor = Exception.class)
  public Result<String> placeSecond(@RequestBody SubOrderVo orderVo) {
    // 通用流程
    Video video = service.updateForm(orderVo);
    String orderId = orderVo.getOrderId();
    Order order = service.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    Assert.state(order.getState().equals(PRODUCTION_COMPLETED), "订单状态出现错误");
    Assert.notNull(orderVo.getType(), "请选择配音方式");
    switch (orderVo.getType()) {
      case 0:
        // 自行上传配音
        service.dubbingBySelf(orderVo, video);
        break;
      case 1:
        // 人工配音 配音字段的属性及pojo
        return Result.buildOkData(service.artificialDubbing(orderVo), "请前往支付链接支付，支付后等待工作人员接单即可");
      case 2:
        // tts配音
        service.machineDubbing(orderVo, video);
        break;
      default:
        return Result.buildFail("配音类型异常");
    }
    order.setState(NOT_UPDATED);
    service.updateById(order);
    return Result.buildOk("上传成功");
  }

  @ApiOperation(value = "更新支付方式")
  @GetMapping("edit")
  public Result<Order> edit(String orderId, String method) {
    Order order = service.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    order.setMethod(method);
    Assert.isTrue(METHODS.contains(method), "支付方式异常");
    service.updateById(order);
    return Result.buildOkData(order);
  }

  private static final List<String> METHODS = new ArrayList<>(Arrays.asList("ali", "balance", "wechat"));
}
