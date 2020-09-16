package com.albedo.java.modules.biz.web;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.OrderQueryCriteria;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import io.micrometer.core.instrument.util.StringUtils;
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
@Api(tags = "后台订单相关接口")
public class WebOrderResource extends BaseResource {

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
    Order key = service.getById(id);
    Video video = videoService.getById(key.getVideoId());
    if (video != null) {
      key.setVideoId(video.getOriginUrl());
    }
    String username = SecurityUtil.getUser().getUsername();
    if (StringUtils.isNotBlank(username)) {
      key.setUserId(username);
    }
    return Result.buildOkData(key);
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
    page.setRecords(updateInfo(page.getRecords()));
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

  @ApiOperation(value = "员工查看待处理订单")
  @GetMapping("/todo/list")
  public Result<List<Order>> list() {
    List<Order> orders = service.availableOrder();
    orders = updateInfo(orders);
    return Result.buildOkData(orders);
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
    List<Order> belongs = service.belongs();
    updateInfo(belongs);
    return Result.buildOkData(belongs);
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

  private List<Order> updateInfo(List<Order> orders) {
    return orders.stream().peek((key) -> {
      Video video = videoService.getById(key.getVideoId());
      if (video != null) {
        key.setVideoId(video.getOriginUrl());
      }
      String username = SecurityUtil.getUser().getUsername();
      if (StringUtils.isNotBlank(username)) {
        key.setUserId(username);
      }
    }).collect(Collectors.toList());
  }
}