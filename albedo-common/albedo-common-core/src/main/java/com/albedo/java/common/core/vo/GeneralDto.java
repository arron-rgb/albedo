package com.albedo.java.common.core.vo;

import java.io.Serializable;

import lombok.Data;

/**
 *
 * @author somewhere
 */
@Data
public class GeneralDto implements Serializable {

  /*** 状态 正常 */
  public static final String FLAG_NORMAL = "0";
  /*** 状态 已删除 */
  public static final String FLAG_DELETE = "1";
  /**
   * 状态（0：正常 1：删除）
   */
  public static final String F_DELFLAG = "delFlag";
  /*** ID */
  public static final String F_ID = "id";
  public static final String F_CREATEDBY = "createdBy";
  public static final String F_CREATOR = "creator";
  public static final String F_CREATEDDATE = "createdDate";
  public static final String F_LASTMODIFIEDBY = "lastModifiedBy";
  public static final String F_MODIFIER = "modifier";
  public static final String F_LASTMODIFIEDDATE = "lastModifiedDate";
  public static final String F_VERSION = "version";
  public static final String F_DESCRIPTION = "description";
  private static final long serialVersionUID = 1L;

}
