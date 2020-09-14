package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.BusinessConstants.PRODUCTION_COMPLETED;
import static com.albedo.java.common.core.constant.ExceptionNames.ORDER_NOT_FOUND;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.core.annotation.Token;
import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.OrderException;
import com.albedo.java.common.core.util.FileUploadUtil;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.SubOrderVo;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.OrderQueryCriteria;
import com.albedo.java.modules.biz.domain.dto.OrderVo;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.biz.service.VideoService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
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
@Api(tags = "订单")
public class OrderResource extends BaseResource {

  private final OrderService service;

  /**
   * @param id
   *          id
   * @return 实体
   */
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_order_view')")
  public Result<Order> get(@PathVariable String id) {
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
  @Resource
  VideoService videoService;

  @PreAuthorize("@pms.hasPermission('biz_order_view')")
  @GetMapping
  @LogOperate(value = "订单查询")
  @ApiOperation(value = "订单查询")
  public Result<PageModel<Order>> getPage(PageModel<Order> pm, OrderQueryCriteria orderQueryCriteria) {
    QueryWrapper<Order> wrapper = QueryWrapperUtil.getWrapper(pm, orderQueryCriteria);
    PageModel<Order> page = service.page(pm, wrapper);
    List<Order> collect = page.getRecords().stream().map((key) -> {
      Video video = videoService.getById(key.getVideoId());
      if (video != null) {
        key.setVideoId(video.getOriginUrl());
      }
      return key;
    }).collect(Collectors.toList());
    page.setRecords(collect);
    return Result.buildOkData(page);
  }

  /**
   * POST / : Save a OrderDto.
   *
   * @param orderDto
   *          the HTTP Order
   */
  @PreAuthorize("@pms.hasPermission('biz_order_edit')")
  @LogOperate(value = "订单编辑")
  @ApiOperation(value = "订单编辑")
  @PostMapping
  public Result<String> save(@Valid @RequestBody Order orderDto) {
    service.saveOrUpdate(orderDto);
    return Result.buildOk("保存订单成功");
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
  @ApiOperation(value = "订单删除")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    log.debug("REST request to delete Order: {}", ids);
    service.removeByIds(ids);
    return Result.buildOk("删除订单成功");
  }

  @ApiOperation(value = "获取订单支付链接")
  @Token
  @PostMapping("/purchase")
  public Result<String> purchase(@RequestParam(value = "token", required = false) String token,
    @RequestParam(value = "orderId") String orderId, String subject) {
    return Result.buildOk(service.price(orderId, subject));
  }

  @ApiOperation(value = "员工查看待处理订单")
  @GetMapping("/list")
  public Result<List<Order>> list() {
    return Result.buildOkData(service.availableOrder());
  }

  @ApiOperation(value = "员工接单")
  @GetMapping("/consume")
  public Result<String> consume(String orderId) {
    try {
      service.consume(orderId);
      return Result.buildOk("接单成功");
    } catch (OrderException e) {
      return Result.buildFail(e.getMessage());
    }
  }

  @ApiOperation(value = "员工查看个人名下订单")
  @GetMapping("/list/belong")
  public Result<List<Order>> listBelongs() {
    return Result.buildOkData(service.belongs());
  }

  @ApiOperation(value = "员工上传订单视频")
  @PostMapping(value = "/upload")
  public Result<String> uploadVideo(MultipartFile file, String orderId) {
    try {
      String tempPath = FileUploadUtil.upload(ApplicationConfig.getUploadPath(), file);
      videoService.uploadVideo(orderId, tempPath);
    } catch (Exception e) {
      e.printStackTrace();
      return Result.buildFail("保存失败");
    }
    return Result.buildOk("上传成功");
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
  public Result<String> placeSecond(SubOrderVo orderVo) {
    // 通用流程
    Video video = service.updateForm(orderVo);
    String orderId = orderVo.getOrderId();
    Order order = service.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    Assert.state(order.getState().equals(PRODUCTION_COMPLETED), "订单状态出现错误");
    switch (orderVo.getType()) {
      case 0:
        // 自行上传配音
        service.dubbingBySelf(orderVo, video);
        break;
      case 1:
        // 人工配音 配音字段的属性及pojo
        return Result.buildOkData(service.artificialDubbing(orderVo), "请前往支付链接支付，等待工作人员接单");
      case 2:
        // tts配音
        service.machineDubbing(orderVo, video);
        break;
      default:
        return Result.buildFail("配音类型异常");
    }
    return Result.buildOk("上传成功");
  }

  @ApiOperation(value = "用户拉取自己的订单状态")
  @PostMapping(value = "/query")
  public Result<List<Order>> query() {
    return Result.buildOkData(service.list(Wrappers.<Order>query().eq("user_id", SecurityUtil.getUser().getId())));
  }
}
