package com.albedo.java.modules.biz.repository;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.biz.domain.Order;
import com.albedo.java.modules.biz.domain.Video;

/**
 * @author arronshentu
 */
public interface OrderRepository extends BaseRepository<Order> {

  /**
   * 查询订单的视频时长
   *
   * @param orderId
   * @return
   */
  Long getDuration(String orderId);

  Video getDub(String orderId);

}
