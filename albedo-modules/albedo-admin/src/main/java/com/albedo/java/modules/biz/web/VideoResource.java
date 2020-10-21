package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.BusinessConstants.IN_PRODUCTION;

import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.domain.dto.VideoQueryCriteria;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import cn.hutool.core.lang.Assert;
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
    page.getRecords().forEach(record -> record.setOriginUrl(ossSingleton.getUrl(record.getOriginUrl())));
    return Result.buildOkData(page);
  }

  @Resource
  OssSingleton ossSingleton;

  @LogOperate(value = "删除视频")
  @ApiOperation(value = "删除视频")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    // 找到对应的订单
    Set<String> orders = service.listByIds(ids).stream().map(Video::getOrderId).collect(Collectors.toSet());
    Assert.isTrue(orders.size() == 1, "视频对应的订单数量异常");
    for (String orderId : orders) {
      // 找到订单的视频
      Video video = service.getOneByOrderId(orderId);
      Order order = orderService.getById(orderId);
      if (video == null) {
        // 视频被删光 回滚状态
        order.setVideoId("");
        order.setState(IN_PRODUCTION);
      } else {
        // 将videoId设为随机的video
        order.setVideoId(video.getId());
      }
      order.updateById();
    }
    service.removeByIds(ids);
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
