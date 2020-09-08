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
import com.albedo.java.modules.biz.domain.Holder;
import com.albedo.java.modules.biz.domain.Script;
import com.albedo.java.modules.biz.domain.dto.DubQueryCriteria;
import com.albedo.java.modules.biz.service.ScriptService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 套词Controller 套词
 *
 * @author admin
 * @version 2020-09-07 18:24:16
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/script")
@AllArgsConstructor
public class ScriptResource extends BaseResource {

  private final ScriptService service;

  /**
   * @param id
   * @return
   */
  @ApiOperation(value = "获取单个套词")
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_script_view')")
  public Result<Script> get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getById(id));
  }

  /**
   * GET / : get all Script.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all Script
   */

  @PreAuthorize("@pms.hasPermission('biz_script_view')")
  @GetMapping
  @ApiOperation(value = "查询套词")
  @LogOperate(value = "套词查看")
  public Result<PageModel<Script>> getPage(PageModel<Script> pm, DubQueryCriteria scriptQueryCriteria) {
    QueryWrapper<Script> wrapper = QueryWrapperUtil.getWrapper(pm, scriptQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  /**
   * POST / : Save a ScriptDto.
   *
   * @param script
   *          the HTTP Script
   */
  @PreAuthorize("@pms.hasPermission('biz_script_edit')")
  @LogOperate(value = "套词编辑")
  @ApiOperation(value = "编辑套词")
  @PostMapping
  public Result<String> save(@Valid @RequestBody Script script) {
    service.saveOrUpdate(script);
    return Result.buildOk("保存套词成功");
  }

  /**
   * DELETE //:ids : delete the "ids" Script.
   *
   * @param ids
   *          the id of the Script to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_script_del')")
  @LogOperate(value = "套词删除")
  @ApiOperation(value = "删除套词")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除套词成功");
  }

  @LogOperate(value = "获取套词")
  @ApiOperation(value = "获取套词")
  @GetMapping("/list")
  public Result<Holder<Script>> list() {
    List<Script> list = service.list(Wrappers.emptyWrapper());
    Holder<Script> holder = new Holder<>();
    list.stream().collect(Collectors.groupingBy(Script::getTitle))
      .forEach((title, data) -> holder.addList(data, title));
    return Result.buildOkData(holder, "获取成功");
  }

  @LogOperate(value = "获取套词")
  @ApiOperation(value = "获取所有套词名")
  @GetMapping("/title/list")
  public Result<List<String>> listTitle() {
    List<Script> list = service.list(Wrappers.emptyWrapper());
    return Result.buildOkData(list.stream().map(Script::getTitle).collect(Collectors.toList()), "获取成功");
  }
}
