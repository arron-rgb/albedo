/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.biz.domain.Commodity;
import com.albedo.java.modules.biz.domain.dto.CommodityDto;

/**
 * 商品管理Service 商品管理
 * @author arronshentu
 * @version 2020-09-07 14:58:36
 */
public interface CommodityService extends DataService<Commodity, CommodityDto, String>{

}