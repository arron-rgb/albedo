package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Plan;

/**
 * @author arronshentu
 */
public interface PlanService extends BaseService<Plan> {

  /**
   * 生成购买链接
   *
   * @param plan
   *          套餐实体
   * @return
   */
  String purchase(Plan plan);

  /**
   * 用途： 1. 支付宝异步通知接口更新
   * 验证订单支付成功后更新用户套餐使用情况
   *
   * @return
   */
  String updateTimes();
}
