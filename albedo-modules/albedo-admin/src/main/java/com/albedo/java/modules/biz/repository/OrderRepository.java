package com.albedo.java.modules.biz.repository;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;

/**
 * @author arronshentu
 */
public interface OrderRepository extends BaseRepository<Order> {

  Video getDub(String orderId);

}
