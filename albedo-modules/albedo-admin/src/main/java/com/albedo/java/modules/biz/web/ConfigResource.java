package com.albedo.java.modules.biz.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.biz.domain.Config;
import com.albedo.java.modules.biz.domain.PlusService;
import com.albedo.java.modules.biz.repository.ConfigRepository;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;

/**
 * 表单可选项配置内容
 *
 * @author arronshentu
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/config")
@Api(tags = "表单项配置")
@AllArgsConstructor
public class ConfigResource {
  @Resource
  ConfigRepository repository;

  @GetMapping
  public Result<PlusService> get() {
    PlusService build = PlusService.builder().build();
    for (String elementName : PlusService.ELEMENT_NAMES) {
      List<Config> left = repository.selectList(Wrappers.<Config>query().eq("type", elementName));
      String title = left.get(0).getTitle();
      build.addList(left, "请选择" + title);
    }
    return Result.buildOkData(build);
  }

}
