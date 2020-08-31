/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import java.util.List;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.service.PlanService;

import lombok.AllArgsConstructor;

/**
 * 发票抬头管理Controller 发票抬头
 *
 * @author arronshentu
 * @version 2020-08-16 16:19:02
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/plan")
@AllArgsConstructor
public class PlanResource extends BaseResource {

  private final PlanService service;

  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_Plan_view')")
  public Result<List<Plan>> list() {
    return Result.buildOkData(service.list());
  }

  @PreAuthorize("@pms.hasPermission('biz_Plan_edit')")
  @PostMapping
  public Result<String> save(@Valid @RequestBody Plan plan) {
    service.saveOrUpdate(plan);
    return Result.buildOk("保存成功");
  }

  @PostMapping("/purchase")
  public Result<String> purchase(String planId) {
    return Result.buildOk(service.purchase(planId));
  }

  @GetMapping("/callback")
  public Result<String> callback() {
    // todo 购买套餐的支付宝回调接口
    // 验证没问题后才更新套餐次数
    return Result.buildOk("");
  }

}
