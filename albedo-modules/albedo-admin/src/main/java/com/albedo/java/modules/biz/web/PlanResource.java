package com.albedo.java.modules.biz.web;

import java.util.List;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.Token;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Plan;
import com.albedo.java.modules.biz.domain.dto.PlanQueryCriteria;
import com.albedo.java.modules.biz.service.PlanService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

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
  @GetMapping("/list")
  public Result<List<Plan>> list() {
    return Result.buildOkData(service.list());
  }

  @ApiOperation(value = "更新套餐")
  @PreAuthorize("@pms.hasPermission('biz_plan_edit')")
  @PostMapping
  public Result<String> save(@Valid @RequestBody Plan plan) {
    service.saveOrUpdate(plan);
    return Result.buildOk("保存成功");
  }

  @ApiOperation(value = "获取套餐支付链接")
  @Token
  @PostMapping("/purchase")
  public Result<String> purchase(String planId, String token) {
    return Result.buildOk(service.purchase(planId));
  }

  /**
   * @param id
   * @return
   */
  @ApiOperation(value = "套餐查询")
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_plan_view')")
  public Result<Plan> get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getById(id));
  }

  /**
   * GET / : get all Plan.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all Plan
   */
  @PreAuthorize("@pms.hasPermission('biz_plan_view')")
  @GetMapping
  @LogOperate(value = "套餐分页查询")
  @ApiOperation(value = "套餐分页查询")
  public Result<PageModel<Plan>> getPage(PageModel<Plan> pm, PlanQueryCriteria planQueryCriteria) {
    QueryWrapper<Plan> wrapper = QueryWrapperUtil.getWrapper(pm, planQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  @PreAuthorize("@pms.hasPermission('biz_plan_del')")
  @LogOperate(value = "套餐删除")
  @ApiOperation(value = "删除套餐")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除套餐成功");
  }
}
