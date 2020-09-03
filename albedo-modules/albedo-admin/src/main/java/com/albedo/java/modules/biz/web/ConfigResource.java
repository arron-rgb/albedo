package com.albedo.java.modules.biz.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.biz.domain.Config;
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
  public Result<Map<String, Object>> get() {
    return Result.buildOkData(getMap());
  }

  private Map<String, Object> getMap() {
    List<Config> configs = repository.selectList(Wrappers.emptyWrapper());
    Map<String, Object> map = new HashMap<>();
    configs.forEach(config -> {
      map.putIfAbsent(config.getType(), new ArrayList<Config>());
      map.computeIfPresent(config.getType(), (key, value) -> {
        if (value instanceof ArrayList) {
          ((ArrayList<Config>)value).add(config);
        }
        return value;
      });
    });
    Object plusService = map.get("plusService");
    map.replace("plusService", new HashMap<String, List<Config>>());
    Map plusServiceMap = (Map)map.get("plusService");
    if (plusService instanceof List) {
      ((ArrayList<Config>)plusService).forEach(config -> {
        plusServiceMap.putIfAbsent(config.getName(), new ArrayList<Config>());
        plusServiceMap.computeIfPresent(config.getName(), (key, value) -> {
          if (value instanceof ArrayList) {
            ((ArrayList<Config>)value).add(config);
          }
          return value;
        });
      });
    }
    return map;
  }

}
