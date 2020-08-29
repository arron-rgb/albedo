/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain.dto;

import java.io.Serializable;

import com.albedo.java.common.core.annotation.Query;

import lombok.Data;

/**
 * 套餐QueryCriteria 套餐
 *
 * @author arronshentu
 * @version 2020-08-29 20:49:54
 */
@Data
public class PlanQueryCriteria implements Serializable {

  private static final long serialVersionUID = -2381630276712391985L;

  /** F_NAME name : 套餐名 */
  @Query(operator = Query.Operator.like)
  private String name;

}
