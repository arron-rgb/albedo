package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.BusinessConstants.PRODUCTION_COMPLETED;
import static com.albedo.java.common.core.constant.ExceptionNames.ORDER_NOT_FOUND;

import java.io.File;
import java.io.IOException;
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
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.OrderQueryCriteria;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import cn.hutool.core.lang.Assert;
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
    return Result.buildOkData(orderDto.getId(), "保存订单成功");
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

  @Resource
  UserService userService;

  @ApiOperation(value = "员工上传配音订单音频")
  @PostMapping(value = "/audio/upload")
  public Result<String> uploadAudio(String audioUrl, String orderId) {
    service.uploadAudio(orderId, audioUrl);
    return Result.buildOkData("上传成功");
  }

  @Resource
  OrderService orderService;

  @ApiOperation(value = "员工上传订单视频")
  @PostMapping(value = "/upload")
  public Result<String> uploadVideo(MultipartFile file, String orderId) throws IOException {
    Order order = orderService.getById(orderId);
    Assert.notNull(order, ORDER_NOT_FOUND);
    String userId = order.getUserId();
    String uploadPath = ApplicationConfig.getUploadPath() + File.separator + userService.getBucketName(userId);
    String tempPath = FileUploadUtil.upload(uploadPath, file);
    videoService.uploadVideo(orderId, tempPath);
    return Result.buildOkData("上传成功");
  }

  @ApiOperation(value = "员工更新订单状态")
  @GetMapping(value = "/update")
  public Result<String> update(String orderId) {
    Order order = service.getById(orderId);
    order.setState(PRODUCTION_COMPLETED);
    Assert.notNull(order.getVideoId(), "未查询到视频信息，请稍后重试");
    Video video = videoService.getById(order.getVideoId());
    Assert.notNull(video, "未查询到视频信息，请稍后重试或联系工作人员");
    service.updateById(order);
    return Result.buildOkData("更新成功");
  }

  private List<Order> updateInfo(List<Order> orders) {
    return orders.stream().peek((order) -> {
      Video video = videoService.getById(order.getVideoId());
      if (video != null) {
        String originUrl = video.getOriginUrl();
        originUrl = ossSingleton.localPathToUrl(originUrl);
        order.setVideoId(originUrl);
      }
      UserVo user = userService.findUserVoById(order.getUserId());
      if (user != null) {
        String username = user.getUsername();
        if (StringUtils.isNotBlank(username)) {
          order.setUserId(username);
        }
      }
    }).collect(Collectors.toList());
  }

  @Resource
  OssSingleton ossSingleton;
}
