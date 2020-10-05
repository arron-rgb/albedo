package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.BusinessConstants.COMMON;
import static com.albedo.java.common.core.constant.BusinessConstants.PLUS_SERVICE;

import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.validation.Valid;

import com.albedo.java.modules.biz.domain.Element;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.modules.biz.domain.Config;
import com.albedo.java.modules.biz.domain.PlusService;
import com.albedo.java.modules.biz.domain.dto.ConfigQueryCriteria;
import com.albedo.java.modules.biz.repository.ConfigRepository;
import com.albedo.java.modules.biz.service.ConfigService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 表单可选项配置内容
 *
 * @author arronshentu
 */
@RestController
@Slf4j
@RequestMapping(value = "${application.admin-path}/biz/config")
@Api(tags = "表单项配置")
@AllArgsConstructor
public class ConfigResource {
  @Resource
  ConfigService service;
  @Resource
  ConfigRepository repository;

  @GetMapping("/list")
  public Result<PlusService<Config>> get() {
    PlusService<Config> build = new PlusService<>();

    List<Config> configs = repository.selectList(Wrappers.<Config>query().eq("type", COMMON));
    configs.stream().collect(Collectors.groupingBy(Config::getTitle))
      .forEach((title, data) -> build.addList(data, title));

    PlusService<Config> innerService = new PlusService<>();
    build.setPlusService(innerService);
    List<Config> plusService = repository.selectList(Wrappers.<Config>query().eq("type", PLUS_SERVICE));
    plusService.stream().collect(Collectors.groupingBy(Config::getTitle))
      .forEach((key, value) -> build.getPlusService().addList(value, key));

    plusService.sort(Comparator.comparing(Config::getSort));
	  build.getData().forEach(data -> data.getData().sort(Comparator.comparing(Config::getSort)));
	  build.getData().sort(Comparator.comparing(Element::getTitle));

	  return Result.buildOkData(build);
  }

  @GetMapping(CommonConstants.URL_ID_REGEX)
  @ApiOperation("表单项配置获取")
  public Result<Config> get(@PathVariable String id) {
    return Result.buildOkData(service.getById(id));
  }

  /**
   * GET / : get all Config.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all Config
   */

  @GetMapping
  @ApiOperation("表单项配置查看")
  @LogOperate(value = "表单项配置查看")
  public Result<PageModel<Config>> getPage(PageModel<Config> pm, ConfigQueryCriteria configQueryCriteria) {
    QueryWrapper<Config> wrapper = QueryWrapperUtil.getWrapper(pm, configQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  @LogOperate(value = "表单项配置编辑")
  @ApiOperation("表单项配置编辑")
  @PostMapping
  public Result<String> save(@Valid @RequestBody Config config) {
    service.saveOrUpdate(config);
    return Result.buildOk("保存表单项配置成功");
  }

  /**
   * DELETE //:ids : delete the "ids" Config.
   *
   * @param ids
   *          the id of the Config to delete
   * @return the Result with status 200 (OK)
   */
  @LogOperate(value = "表单项配置删除")
  @ApiOperation(value = "表单项配置删除")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除表单项配置成功");
  }

}
