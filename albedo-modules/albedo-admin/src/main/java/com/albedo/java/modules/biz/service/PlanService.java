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
   *
   * @param planId
   *          套餐id
   * @return
   *         购买链接
   */
  String purchase(String planId);

  /**
   * 只负责更新 验证由上层负责
   *
   * return_url接口生成消费记录
   * 给用户更新套餐使用情况
   * 将用户角色设为企业管理员
   *
   * @return
   */
  String callback(String outTradeNo);

}
