package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.BusinessConstants.*;
import static com.albedo.java.common.core.constant.ExceptionNames.BALANCE_NOT_FOUND;
import static com.albedo.java.common.core.constant.ExceptionNames.ORDER_NOT_FOUND;

import java.util.*;

import javax.annotation.Resource;
import javax.validation.constraints.NotEmpty;

import com.albedo.java.common.log.annotation.LogOperate;
import org.apache.commons.lang3.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.Token;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.*;
import com.albedo.java.modules.biz.domain.dto.OrderVo;
import com.albedo.java.modules.biz.repository.MaterialRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.collection.CollectionUtil;
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
  MaterialRepository materialRepository;
  @Resource
  VideoService videoService;


  @ApiOperation(value = "订单删除")
  @DeleteMapping("/cancel")
  public Result<String> delete(@RequestParam("orderId") String orderId) {
    Order order = service.getById(orderId);
    if(!order.getUserId().equals(SecurityUtil.getUser().getId())){
      return Result.buildFail("无法删除");
    }
    service.removeById(order);
    return Result.buildOk("删除订单成功");
  }

  @ApiOperation(value = "查看当前订单")
  @GetMapping("/current")
  public Result<Order> currentOrder() {
    // 判断条件
    // 1. 当前用户的订单
    // 2. 未处于结单状态
    Order order = service.currentOrder();
    if (Objects.isNull(order)) {
      return Result.buildOkData(order);
    }
    UserVo user = userService.findUserVoById(order.getUserId());
    if (user != null) {
      String username = user.getUsername();
      if (StringUtils.isNotBlank(username)) {
        order.setUserId(username);
      }
    }
    // videoId为空直接返回
    if (StringUtils.isEmpty(order.getVideoId())) {
      return Result.buildOkData(order);
    }
    // 把videoId更新为url
    List<VideoMaterial> videos = videoService.getMaterials(order.getId());
    if (CollectionUtil.isNotEmpty(videos)) {
      order.setVideoId(videos.get(0).getOriginUrl());
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
      List<Video> list = videoService.list(Wrappers.<Video>lambdaQuery().eq(Video::getOrderId, order.getId()));
      if (CollectionUtils.isNotEmpty(list)) {
        list.stream().filter(video -> StringUtils.isNotEmpty(video.getOutputUrl())).findFirst().ifPresent(video -> {
          order.setVideoId(video.getOutputUrl());
        });
      }
      order.setVideoList(list);
      UserVo user = userService.findUserVoById(order.getUserId());
      if (user != null) {
        String username = user.getUsername();
        if (StringUtils.isNotBlank(username)) {
          order.setUserId(username);
        }
      }
		 user = userService.findUserVoById(order.getLastModifiedBy());
		if (user != null) {
			String username = user.getUsername();
			if (StringUtils.isNotBlank(username)) {
				order.setLastModifiedBy(username);
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
    String orderId = service.place(orderVo);
    if (StringUtils.isNotEmpty(orderId)) {
      return Result.buildOkData(orderId, "下单成功");
    }
    return Result.buildFail("下单失败");
  }

  @ApiOperation(value = "用户上传二次订单")
  @PostMapping(value = "/placeSecond")

  public Result<String> placeSecond(@RequestBody SubOrderVo orderVo) {
    // 通用流程
    Video video = service.updateForm(orderVo);
    String orderId = orderVo.getOrderId();
    Order order = service.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    Assert.notNull(orderVo.getType(), "请选择配音方式");
    String dub = service.dub(orderVo, video);
    order.setState(NOT_UPDATED);
    service.updateById(order);
    if (StringUtils.isNotEmpty(dub)) {
      return Result.buildOkData(dub, "请前往支付链接支付");
    }
    return Result.buildOk("下单成功");
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

  @ApiOperation(value = "用户确认视频")
  @GetMapping("accept")
  public Result<String> accept(@NotEmpty(message = "请选择订单") String orderId, @NotEmpty(message = "请选择是否满意") String state,
    String editDescription) {
    Order order = service.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    switch (state) {
      case SATISFIED:
        return Result.buildOk("订单状态更新成功");
      case DISSATISFIED:
        String id = SecurityUtil.getUser().getId();
        Balance balance = balanceService.getByUserId(id);
        Assert.notNull(balance, BALANCE_NOT_FOUND);
        Assert.isTrue(balance.getEditTimes() > 0, "套餐内已无可修改次数");
        balance.setEditTimes(balance.getEditTimes() - 1);
        balanceService.updateById(balance);
        // 员工上传完视频后 用户决定是否需要重做
        order.setState(IN_PRODUCTION);
        String description = order.getDescription();
        description = "【用户打回】" + editDescription + "【原订单信息】" + description;
        order.setDescription(description);
        service.updateById(order);
        return Result.buildOk("已通知员工对视频进行修改");
      default:
        return Result.buildFail("订单状态异常");
    }
  }

  @Resource
  BalanceService balanceService;
  private static final List<String> METHODS = new ArrayList<>(Arrays.asList("ali", "balance", "wechat"));
}
