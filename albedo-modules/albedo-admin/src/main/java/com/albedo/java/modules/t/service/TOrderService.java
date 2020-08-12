/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.t.domain.TOrder;
import com.albedo.java.modules.t.domain.dto.TOrderDto;

/**
 * 订单管理Service t_order
 * @author admin
 * @version 2020-08-12 15:36:12
 */
public interface TOrderService extends DataService<TOrder, TOrderDto, String>{

}