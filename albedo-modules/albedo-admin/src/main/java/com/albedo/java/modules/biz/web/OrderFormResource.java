/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import java.util.Set;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.dto.OrderFormDto;
import com.albedo.java.modules.biz.domain.dto.OrderFormQueryCriteria;
import com.albedo.java.modules.biz.service.OrderFormService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 订单内容Controller OrderForm
 *
 * @author admin
 * @version 2020-08-18 10:19:40
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/order-form")
@AllArgsConstructor
@Api(tags = "订单内容")
public class OrderFormResource extends BaseResource {

  private final OrderFormService service;

  /**
   * @param id
   * @return
   */
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_orderForm_view')")
  public Result get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getOneDto(id));
  }

  /**
   * GET / : get all orderForm.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all orderForm
   */

  @PreAuthorize("@pms.hasPermission('biz_orderForm_view')")
  @GetMapping
  @LogOperate(value = "订单内容查看")
  @ApiOperation(value = "订单内容查看")
  public Result getPage(PageModel pm, OrderFormQueryCriteria orderFormQueryCriteria) {
    QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, orderFormQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  /**
   * POST / : Save a orderFormDto.
   *
   * @param orderFormDto
   *          the HTTP orderForm
   */
  @PreAuthorize("@pms.hasPermission('biz_orderForm_edit')")
  @LogOperate(value = "订单内容修改")
  @ApiOperation(value = "订单内容修改")
  @PostMapping
  public Result save(@Valid @RequestBody OrderFormDto orderFormDto) {
    log.debug("REST request to save OrderFormDto : {}", orderFormDto);
    String userId = SecurityUtil.getUser().getId();
    orderFormDto.setUserId(userId);
    service.saveOrUpdate(orderFormDto);
    return Result.buildOk("保存订单内容成功");

  }

  /**
   * DELETE //:ids : delete the "ids" OrderForm.
   *
   * @param ids
   *          the id of the orderForm to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_orderForm_del')")
  @LogOperate(value = "订单内容删除")
  @ApiOperation(value = "订单内容删除")
  @DeleteMapping
  public Result delete(@RequestBody Set<String> ids) {
    log.debug("REST request to delete OrderForm: {}", ids);
    service.removeByIds(ids);
    return Result.buildOk("删除成功");
  }
}
