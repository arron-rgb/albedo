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
import com.albedo.java.modules.biz.domain.VideoMaterial;
import com.albedo.java.modules.biz.domain.dto.VideoQueryCriteria;
import com.albedo.java.modules.biz.repository.MaterialRepository;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

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
    return Result.buildOkData(page);
  }

  @GetMapping("list")
  @ApiOperation(value = "获取素材视频")
  @LogOperate(value = "获取素材视频")
  public Result<PageModel<VideoMaterial>> getPage(PageModel<VideoMaterial> pm, String orderId) {
    PageModel<VideoMaterial> page = materialRepository.selectPage(pm,
      Wrappers.<VideoMaterial>lambdaQuery().eq(VideoMaterial::getOrderId, orderId).orderByAsc(VideoMaterial::getSort));
    return Result.buildOkData(page);
  }

  @Resource
  MaterialRepository materialRepository;
  @Resource
  OssSingleton ossSingleton;

  @LogOperate(value = "删除视频")
  @ApiOperation(value = "删除视频")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> deleteIds) {
    materialRepository.selectBatchIds(deleteIds).forEach(video -> {
      ossSingleton.remove(video.getOriginUrl());
    });
    materialRepository.deleteBatchIds(deleteIds);
    return Result.buildOk("删除视频成功");
  }

  @Resource
  OrderService orderService;

  @GetMapping("refresh")
  public Result<String> refresh(String videoId) {
    service.addAudio(videoId);
    return Result.buildOk("触发成功");
  }

}
