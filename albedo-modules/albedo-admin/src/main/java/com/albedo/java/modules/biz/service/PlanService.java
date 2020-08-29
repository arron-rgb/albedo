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
}
