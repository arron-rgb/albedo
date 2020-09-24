/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service.impl;

import static com.albedo.java.common.core.constant.ExceptionNames.BALANCE_NOT_FOUND;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.domain.Commodity;
import com.albedo.java.modules.biz.domain.dto.CommodityDto;
import com.albedo.java.modules.biz.repository.CommodityRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.CommodityService;

import cn.hutool.core.lang.Assert;

/**
 * 商品管理ServiceImpl 商品管理
 *
 * @author arronshentu
 * @version 2020-09-07 14:58:36
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class CommodityServiceImpl extends DataServiceImpl<CommodityRepository, Commodity, CommodityDto, String>
  implements CommodityService {

  @Override
  public void saveOrUpdate(CommodityDto entityDto) {
    String id = SecurityUtil.getUser().getId();
    Balance byId = balanceService.getById(id);
    Assert.notNull(byId, BALANCE_NOT_FOUND);
    Integer customTimes = byId.getCustomTimes();
    Assert.isTrue(customTimes > 1, "上传商品数量超出限制");
    customTimes = customTimes - 1;
    byId.setCustomTimes(customTimes);

    super.saveOrUpdate(entityDto);
  }

  @Resource
  BalanceService balanceService;
}
