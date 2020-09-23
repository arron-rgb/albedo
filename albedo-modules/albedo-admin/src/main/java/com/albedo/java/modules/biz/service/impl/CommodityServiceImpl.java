/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.domain.Commodity;
import com.albedo.java.modules.biz.domain.dto.CommodityDto;
import com.albedo.java.modules.biz.repository.CommodityRepository;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.biz.service.CommodityService;

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
    // todo 加上商品数量的验证
    // String id = SecurityUtil.getUser().getId();
    // Balance byId = balanceService.getById(id);
    // Assert.notNull(byId, "未购买任何");
    super.saveOrUpdate(entityDto);
  }

  @Resource
  BalanceService balanceService;
}
