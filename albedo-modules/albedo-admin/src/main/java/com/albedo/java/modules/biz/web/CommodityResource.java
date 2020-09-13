package com.albedo.java.modules.biz.web;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Commodity;
import com.albedo.java.modules.biz.domain.dto.CommodityDto;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.CommodityService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 商品管理Controller 商品管理
 *
 * @author arronshentu
 * @version 2020-09-07 14:58:36
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/commodity")
@AllArgsConstructor
public class CommodityResource extends BaseResource {

  private final CommodityService service;

  /**
   * @param id
   * @return
   */
  @ApiOperation(value = "获取单个商品管理")
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_commodity_view')")
  public Result<CommodityDto> get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getOneDto(id));
  }

  /**
   * GET / : get all commodity.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all commodity
   */

  @PreAuthorize("@pms.hasPermission('biz_commodity_view')")
  @GetMapping
  @ApiOperation(value = "查询商品管理")
  @LogOperate(value = "商品管理查看")
  public Result<List<Commodity>> getPage() {
    List<Commodity> commodities =
      service.list(Wrappers.<Commodity>query().eq("user_id", SecurityUtil.getUser().getId()));
    return Result.buildOkData(commodities);
  }

  /**
   * POST / : Save a commodityDto.
   *
   * @param commodityDto
   *          the HTTP commodity
   */
  @PreAuthorize("@pms.hasPermission('biz_commodity_edit')")
  @LogOperate(value = "商品管理编辑")
  @ApiOperation(value = "编辑商品管理")
  @PostMapping
  public Result<String> save(@Valid @RequestBody CommodityDto commodityDto) {
    log.debug("REST request to save CommodityDto : {}", commodityDto);
    service.saveOrUpdate(commodityDto);
    return Result.buildOk("保存商品管理成功");
  }

  @PreAuthorize("@pms.hasPermission('biz_commodity_edit')")
  @LogOperate(value = "商品管理编辑")
  @ApiOperation(value = "批量保存商品")
  @PostMapping("/batch")
  public Result<String> saveBatch(@Valid @RequestBody List<Commodity> commodityDto) {
    // Balance balance =
    // balanceService.getOne(Wrappers.<Balance>lambdaQuery().eq(Balance::getUserId, SecurityUtil.getUser().getId()));
    // Assert.notNull(balance, "未查询到相关套餐");
    int size = commodityDto.size();
    // Assert.isTrue(size < balance.get);
    service.saveBatch(commodityDto);
    return Result.buildOk("保存商品管理成功");
  }

  @Resource
  BalanceService balanceService;

  /**
   * DELETE //:ids : delete the "ids" Commodity.
   *
   * @param ids
   *          the id of the commodity to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_commodity_del')")
  @LogOperate(value = "商品管理删除")
  @ApiOperation(value = "删除商品管理")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除商品管理成功");
  }
}
