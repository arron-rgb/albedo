package com.albedo.java.modules.biz.web;

import java.util.Set;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.VideoQueryCriteria;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * @author arronshentu
 */

@RestController
@RequestMapping(value = "${application.admin-path}/biz/video")
@AllArgsConstructor
public class VideoResource extends BaseResource {

  private final VideoService service;

  @GetMapping
  @ApiOperation(value = "视频分页查询")
  @LogOperate(value = "视频分页查询")
  public Result<PageModel<Video>> getPage(PageModel<Video> pm, VideoQueryCriteria dubQueryCriteria) {
    QueryWrapper<Video> wrapper = QueryWrapperUtil.getWrapper(pm, dubQueryCriteria);
    PageModel<Video> page = service.page(pm, wrapper);
    page.getRecords().forEach(record -> {
      String url = record.getOriginUrl().replace("F:\\workplace\\virtual-live-web\\null\\upload\\", "");
      url = url.replace("\\", ".oss-cn-hangzhou.aliyuncs.com/");
      record.setOriginUrl(url);
    });
    return Result.buildOkData(page);
  }

  @Resource
  OssSingleton ossSingleton;

  @LogOperate(value = "删除视频")
  @ApiOperation(value = "删除视频")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除视频成功");
  }

}
