/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.biz.domain.Coupon;
import com.albedo.java.modules.biz.domain.dto.CouponDto;

/**
 * 增删改查Service 优惠券
 * @author admin
 * @version 2020-10-04 08:44:10
 */
public interface CouponService extends DataService<Coupon, CouponDto, String>{

}