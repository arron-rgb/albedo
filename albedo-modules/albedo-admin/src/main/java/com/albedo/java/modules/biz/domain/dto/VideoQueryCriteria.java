package com.albedo.java.modules.biz.domain.dto;

import java.io.Serializable;

import com.albedo.java.common.core.annotation.Query;

/**
 * @author arronshentu
 */
public class VideoQueryCriteria implements Serializable {

  private static final long serialVersionUID = 1L;

  @Query(propName = "order_id", operator = Query.Operator.like)
  private String orderId;

}
