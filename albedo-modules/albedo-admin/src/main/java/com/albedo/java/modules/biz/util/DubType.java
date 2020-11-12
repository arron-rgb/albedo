package com.albedo.java.modules.biz.util;

import java.util.List;

import javax.annotation.Resource;

import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.modules.biz.domain.SubOrderVo;
import com.albedo.java.modules.biz.domain.Video;
import com.albedo.java.modules.biz.repository.VideoRepository;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.task.Signal;
import com.albedo.java.modules.tool.util.OssSingleton;

import cn.hutool.core.lang.Assert;

/**
 * @author arronshentu
 */
public class DubType {

  @Resource
  OssSingleton ossSingleton;
  @Resource
  OrderService orderService;
  @Resource
  VideoRepository videoRepository;

  DubType instance;

  void invoke() {
    instance = new Self();
    instance.invoke(null, null);
  }

  void invoke(SubOrderVo orderVo, Video video) {

  }

  class Self extends DubType {
    @Override
    void invoke(SubOrderVo orderVo, Video video) {
      super.invoke(orderVo, video);
      Assert.notEmpty(orderVo.getAudioUrl(), "音频链接不得为空，请检查后重试");
      video.setAudioUrl(orderVo.getAudioUrl());
      videoRepository.updateById(video);
      SpringContextHolder.publishEvent(new Signal(video.getId()));
    }
  }

  class Machine extends DubType {
    @Override
    void invoke(SubOrderVo orderVo, Video video) {
      List<String> voiceTypes = orderVo.getVoiceType();
      Assert.notEmpty(voiceTypes, "请选择配音音色");
      String voiceType = voiceTypes.get(0);
      String filePath = orderService.generateAudio(orderVo.getContent(), orderVo.getOrderId(), voiceType);
      Assert.notEmpty(orderVo.getContent(), "配音文本不允许为空");
      String audioUrl = ossSingleton.getUrl(filePath);
      video.setAudioText(orderVo.appendContent());
      video.setAudioUrl(audioUrl);
      video.updateById();
      SpringContextHolder.publishEvent(new Signal(video.getId()));
    }
  }

  class Artificial extends DubType {

  }
}
