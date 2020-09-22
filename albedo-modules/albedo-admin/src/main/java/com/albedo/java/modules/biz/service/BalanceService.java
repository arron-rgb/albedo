package com.albedo.java.modules.biz.service;

import com.albedo.java.common.core.exception.TimesOverspendException;
import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.dto.BalanceDto;

/**
 * @author arronshentu
 */
public interface BalanceService extends BaseService<Balance> {
  /**
   * 给某个特定的用户添加次数
   *
   * @param times
   *          次数
   * @param userId
   *          用户
   */
  void addTimes(int times, String userId);

  /**
   * 查询某组织剩余次数
   *
   * @return
   *         企业剩余次数、个人剩余次数
   */
  Integer leftTimes();

  /**
   * 减次数
   *
   * @throws TimesOverspendException
   *           次数不够扣
   */
  void consumeTimes() throws TimesOverspendException;

  BalanceDto getBalanceInfo();
}
