package com.albedo.java.modules.biz.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author arronshentu
 */
@Data
@Builder
@TableName("t_video_material")
@EqualsAndHashCode(callSuper = true)
public class VideoMaterial extends Model<VideoMaterial> {

  private String id;
  private String orderId;
  @TableField(value = "url")
  private String originUrl;

}
