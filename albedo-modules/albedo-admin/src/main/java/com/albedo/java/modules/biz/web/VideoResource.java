package com.albedo.java.modules.biz.web;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import com.albedo.java.modules.biz.domain.Order;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
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

  @LogOperate(value = "删除素材视频")
  @ApiOperation(value = "删除素材视频")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> deleteIds) {
    // todo 删完以后检查order是否还有videoId字段
//    deleteIds.forEach(videoId->{
//      VideoMaterial material = materialRepository.selectById(videoId);
//      String orderId = material.getOrderId();
//    });
    List<VideoMaterial> videoMaterials = materialRepository.selectBatchIds(deleteIds);
    videoMaterials.forEach(video -> ossSingleton.remove(video.getOriginUrl()));
    Set<String> orderIds = videoMaterials.stream().map(VideoMaterial::getOrderId).collect(Collectors.toSet());
    orderIds.forEach(orderId->{
      Order order = orderService.getById(orderId);
      List<VideoMaterial> materials = materialRepository.selectList(Wrappers.<VideoMaterial>lambdaQuery().eq(VideoMaterial::getOrderId, orderId));
      if(materials.isEmpty()){
        // 为空肯定删完了
        order.setVideoId("");
        order.updateById();
      }else {
        // 不为空 表示没删完 检查一下当前的有没有被删
        String videoId = order.getVideoId();
        if (deleteIds.contains(videoId)) {
          order.setVideoId(materials.get(0).getId());
          order.updateById();
        }
      }
    });

    materialRepository.deleteBatchIds(deleteIds);


    return Result.buildOk("删除素材成功");
  }

  @LogOperate(value = "删除视频")
  @ApiOperation(value = "删除视频")
  @DeleteMapping("output")
  public Result<String> deleteOutput(@RequestBody Set<String> deleteIds) {
    service.listByIds(deleteIds).forEach(video -> ossSingleton.remove(video.getOutputUrl()));
    service.removeByIds(deleteIds);
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
