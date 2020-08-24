package com.albedo.java.modules.biz.service;

import com.albedo.java.common.core.exception.TimesOverspendException;
import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Balance;

/**
 * @author arronshentu
 */
public interface BalanceService extends BaseService<Balance> {
  /**
   * 1. 验证交易是否完成 2. 给该用户所在部门或个人加上次数
   */
  void addTimes(int times);

  /**
   * 企业剩余次数、个人剩余次数
   */
  int leftTimes();

  /**
   * 减次数
   */
  void consumeTimes() throws TimesOverspendException;
}
