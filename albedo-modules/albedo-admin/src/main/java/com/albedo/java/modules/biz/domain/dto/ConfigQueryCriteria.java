/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain.dto;

import java.io.Serializable;

import com.albedo.java.common.core.annotation.Query;

import lombok.Data;

/**
 * @author arronshentu
 */
@Data
public class ConfigQueryCriteria implements Serializable {

  @Query(propName = "value", operator = Query.Operator.like)
  private String value;
}
