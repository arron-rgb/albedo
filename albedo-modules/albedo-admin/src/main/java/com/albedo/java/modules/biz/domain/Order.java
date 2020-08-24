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

  private String userId;
  /**
   * 订单状态 分为 1. 完成下单 2. 员工接单，制作中 3. 制作完成 4. 制作修改 5. 结单
   */
  private Integer state;
  /**
   * 1. 普通 2. 加速
   */
  private String type;
  /**
   * oss链接
   */
  private String videoId;
  // todo 似乎没必要
  // private String userName;
  // private String userPhone;

  /**
   * 接单员工Id
   */
  private String staffId;

}
