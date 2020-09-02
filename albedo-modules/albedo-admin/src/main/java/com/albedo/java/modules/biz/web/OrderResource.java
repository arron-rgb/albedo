package com.albedo.java.modules.biz.web;

import java.io.IOException;
import java.util.List;
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
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

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

  @PreAuthorize("@pms.hasPermission('biz_order_view')")
  @GetMapping
  @LogOperate(value = "订单查询")
  public Result<PageModel<Order>> getPage(PageModel<Order> pm, OrderQueryCriteria orderQueryCriteria) {
    QueryWrapper<Order> wrapper = QueryWrapperUtil.getWrapper(pm, orderQueryCriteria);
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
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    log.debug("REST request to delete Order: {}", ids);
    service.removeByIds(ids);
    return Result.buildOk("删除订单成功");
  }

  @GetMapping("/purchase?orderId={orderId}")
  public Result<String> purchase(@PathVariable(value = "orderId") String orderId) {
    return Result.buildOk(service.price(orderId));
  }

  @GetMapping("/list")
  public Result<List<Order>> list() {
    return Result.buildOkData(service.availableOrder());
  }

  @GetMapping("/list/belong")
  public Result<List<Order>> listBelongs() {
    return Result.buildOkData(service.belongs());
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

}
