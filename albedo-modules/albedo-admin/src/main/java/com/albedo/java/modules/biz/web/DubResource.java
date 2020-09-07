/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Dub;
import com.albedo.java.modules.biz.domain.Holder;
import com.albedo.java.modules.biz.domain.dto.DubQueryCriteria;
import com.albedo.java.modules.biz.service.DubService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 配音表单配置Controller 配音表单配置
 *
 * @author admin
 * @version 2020-09-07 18:24:16
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/dub")
@AllArgsConstructor
public class DubResource extends BaseResource {

  private final DubService service;

  /**
   * @param id
   * @return
   */
  @ApiOperation(value = "获取单个配音表单配置")
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_dub_view')")
  public Result<Dub> get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getById(id));
  }

  /**
   * GET / : get all dub.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all dub
   */

  @PreAuthorize("@pms.hasPermission('biz_dub_view')")
  @GetMapping
  @ApiOperation(value = "查询配音表单配置")
  @LogOperate(value = "配音表单配置查看")
  public Result<PageModel<Dub>> getPage(PageModel<Dub> pm, DubQueryCriteria dubQueryCriteria) {
    QueryWrapper<Dub> wrapper = QueryWrapperUtil.getWrapper(pm, dubQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  /**
   * POST / : Save a dubDto.
   *
   * @param dub
   *          the HTTP dub
   */
  @PreAuthorize("@pms.hasPermission('biz_dub_edit')")
  @LogOperate(value = "配音表单配置编辑")
  @ApiOperation(value = "编辑配音表单配置")
  @PostMapping
  public Result<String> save(@Valid @RequestBody Dub dub) {
    service.saveOrUpdate(dub);
    return Result.buildOk("保存配音表单配置成功");
  }

  /**
   * DELETE //:ids : delete the "ids" Dub.
   *
   * @param ids
   *          the id of the dub to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_dub_del')")
  @LogOperate(value = "配音表单配置删除")
  @ApiOperation(value = "删除配音表单配置")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除配音表单配置成功");
  }

  @LogOperate(value = "获取配音表单配置")
  @ApiOperation(value = "获取配音表单配置")
  @GetMapping("/list")
  public Result<Holder<Dub>> list() {
    List<Dub> list = service.list(Wrappers.emptyWrapper());
    Holder<Dub> holder = new Holder<>();
    list.stream().collect(Collectors.groupingBy(Dub::getTitle)).forEach((title, data) -> holder.addList(data, title));
    return Result.buildOkData(holder, "获取成功");
  }

  @LogOperate(value = "获取配音表单配置")
  @ApiOperation(value = "获取所有配音表单名")
  @GetMapping("/title/list")
  public Result<List<String>> listTitle() {
    List<Dub> list = service.list(Wrappers.emptyWrapper());
    return Result.buildOkData(list.stream().map(Dub::getTitle).collect(Collectors.toList()), "获取成功");
  }
}
