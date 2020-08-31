package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Plan;

/**
 * @author arronshentu
 */
public interface PlanService extends BaseService<Plan> {

  /**
   *
   * 购买套餐流程： 1. 通过post请求生成一条支付宝pc消费记录
   * 2. return_url接口生成消费记录
   * 3. 给用户更新套餐使用情况
   *
   * @param planId
   *          套餐id
   * @return
   *         购买链接
   */
  String purchase(String planId);

  /**
   * 用途： 1. 支付宝异步通知接口更新
   * 验证订单支付成功后更新用户套餐使用情况
   *
   * @return
   */
  String updateTimes(String outTradeNo);
}
