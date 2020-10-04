/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service.impl;

import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.service.CouponService;
import com.albedo.java.modules.biz.domain.Coupon;
import com.albedo.java.modules.biz.domain.dto.CouponDto;
import com.albedo.java.modules.biz.repository.CouponRepository;

/**
 * 增删改查ServiceImpl 优惠券
 * @author admin
 * @version 2020-10-04 08:44:10
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class CouponServiceImpl extends DataServiceImpl<CouponRepository, Coupon, CouponDto, String> implements CouponService{
	@Override
	public void saveOrUpdate(CouponDto couponDto) {
													super.saveOrUpdate(couponDto);
	}

}