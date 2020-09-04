package com.albedo.java.modules.biz.domain;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author arronshentu
 */
@TableName("t_order")
@Data
@EqualsAndHashCode(callSuper = true)
public class Order extends IdEntity<Invoice> {

  private static final Long serialVersionUID = -7669566132599781021L;

  /**
   * 下单用户Id
   */
  private String userId;
  /**
   * 订单状态 分为 0. 创建未付款 1. 付款未制作 2. 员工接单，制作中 3. 视频已上传 4. 商品、logo、贴片 5. 结单
   */
  private Integer state;
  /**
   * 1. 普通 2. 加速
   */
  private String type;
  /**
   * 存储的视频id
   */
  private String videoId;
  /**
   * 接单员工Id
   */
  private String staffId;
  /**
   * 订单价格
   */
  private String totalAmount;
  /**
   * 填写的表单信息
   */
  private String content;

}
