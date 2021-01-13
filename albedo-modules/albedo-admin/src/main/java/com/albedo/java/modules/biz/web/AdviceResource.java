package com.albedo.java.modules.biz.web;

import java.util.Set;

import javax.validation.Valid;

import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.Query;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Advice;
import com.albedo.java.modules.biz.service.AdviceService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author arronshentu
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/advice")
@AllArgsConstructor
public class AdviceResource extends BaseResource {
  private final AdviceService service;

  @GetMapping(CommonConstants.URL_ID_REGEX)
  public Result<Advice> get(@PathVariable String id) {
    return Result.buildOkData(service.getById(id));
  }

  @GetMapping
  public Result<PageModel<Advice>> getPage(PageModel<Advice> pm, AdviceQueryCriteria adviceQueryCriteria) {
    QueryWrapper<Advice> wrapper = QueryWrapperUtil.getWrapper(pm, adviceQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  @Data
  public static class AdviceQueryCriteria {
    @Query(operator = Query.Operator.eq)
    String orderId;
  }

  @PostMapping
  public Result<String> save(@Valid @RequestBody Advice advice) {
    service.saveOrUpdate(advice);
    return Result.buildOk("保存配音表单配置成功");
  }

  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除配音表单配置成功");
  }

}
