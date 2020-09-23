package com.albedo.java.modules.biz.web;

import java.util.Set;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.dto.BalanceDto;
import com.albedo.java.modules.biz.service.BalanceService;

import cn.hutool.core.lang.Assert;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * @author arronshentu
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/balance")
@AllArgsConstructor
public class BalanceResource extends BaseResource {

  private final BalanceService service;

  @ApiOperation(value = "获取用户套餐余量")
  @GetMapping
  public Result<BalanceDto> get() {
    BalanceDto balance = service.getBalanceInfo();
    Assert.notNull(balance, "用户未购买任何套餐");
    return Result.buildOkData(balance);
  }

  @PreAuthorize("@pms.hasPermission('biz_calance_edit')")
  @LogOperate(value = "套餐余量管理编辑")
  @ApiOperation(value = "编辑套餐余量")
  @PostMapping
  public Result<String> save(@Valid @RequestBody Balance balance) {
    service.saveOrUpdate(balance);
    return Result.buildOk("保存套餐余量成功");
  }

  @PreAuthorize("@pms.hasPermission('biz_calance_del')")
  @LogOperate(value = "套餐余量管理删除")
  @ApiOperation(value = "删除套餐余量")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除套餐余量成功");
  }
}
