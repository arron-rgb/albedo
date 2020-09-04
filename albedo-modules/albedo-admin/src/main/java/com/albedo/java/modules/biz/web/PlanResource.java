/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import java.util.List;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.Token;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.service.PlanService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 *
 * @author arronshentu
 * @version 2020-08-16 16:19:02
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/plan")
@AllArgsConstructor
@Api(tags = "套餐")
public class PlanResource extends BaseResource {

  private final PlanService service;

  @ApiOperation(value = "获取套餐")
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_Plan_view')")
  public Result<List<Plan>> list() {
    return Result.buildOkData(service.list());
  }

  @ApiOperation(value = "更新套餐")
  @PreAuthorize("@pms.hasPermission('biz_Plan_edit')")
  @PostMapping
  public Result<String> save(@Valid @RequestBody Plan plan) {
    service.saveOrUpdate(plan);
    return Result.buildOk("保存成功");
  }

  @ApiOperation(value = "获取套餐支付链接")
  @Token
  @PostMapping("/purchase")
  public Result<String> purchase(String planId) {
    return Result.buildOk(service.purchase(planId));
  }

}
