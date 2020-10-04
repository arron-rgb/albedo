package com.albedo.java.modules.biz.service;

import com.albedo.java.common.core.exception.TimesOverspendException;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.dto.BalanceDto;

/**
 * @author arronshentu
 */
public interface BalanceService extends BaseService<Balance> {

  /**
   * 减次数
   *
   * @throws TimesOverspendException
   *           次数不够扣
   */
  @LogOperate(value = "消耗次数")
  void consumeTimes() throws TimesOverspendException;

  /**
   * 获取用户套餐余量
   *
   * @return
   *         套餐余量信息
   */
  BalanceDto getBalanceInfo();

  /**
   * 获取某个用户的套餐余量记录，自己没买就找企业的；
   *
   * @param userId
   *          用户id
   * @return 套餐余量
   */
  Balance getByUserId(String userId);
}
