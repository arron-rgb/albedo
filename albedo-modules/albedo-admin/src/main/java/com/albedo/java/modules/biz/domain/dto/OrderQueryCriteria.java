package com.albedo.java.modules.biz.domain.dto;

import com.albedo.java.common.core.annotation.Query;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;
/**
 * @author arronshentu
 */
@Data
public class OrderQueryCriteria implements Serializable {

  private static final long serialVersionUID = 7720335628732511097L;

	@Query(propName = "staff_id", operator = Query.Operator.like)
	private String staffId;

	@Query(propName = "state", operator = Query.Operator.like)
	private String state;

	@Query(propName = "last_modified_date", operator = Query.Operator.between)
	private List<Date> lastModifiedDate;
}
