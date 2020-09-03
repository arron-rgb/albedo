package com.albedo.java.modules.biz.domain;

import javax.validation.constraints.Size;

import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author arronshentu
 */
@Data
@Builder
@TableName("t_balance_record")
@EqualsAndHashCode(callSuper = true)
public class BalanceRecord extends IdEntity<Invoice> {

  /** userId 用户id */
  @Size(max = 32)
  @TableField("user_id")
  private String userId;
  private Integer amount;
  /** type 0-减，1-加 */
  private Integer type;
  /** 0下单次数 1子账号数量 2存储空间 */
  private Integer dimension;

}
