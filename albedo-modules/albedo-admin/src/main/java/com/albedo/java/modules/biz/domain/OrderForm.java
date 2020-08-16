/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.domain;

import lombok.*;
import com.baomidou.mybatisplus.annotation.*;
import com.albedo.java.common.persistence.domain.IdEntity;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import com.albedo.java.common.core.annotation.DictType;


import javax.validation.constraints.*;

/**
 * 表单Entity OrderForm
 * @author admin
 * @version 2020-08-18 10:19:40
 */
@TableName(value = "t_order_form")
@Data @ToString @NoArgsConstructor @AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class OrderForm extends IdEntity<OrderForm> {

	private static final long serialVersionUID = 1L;
	/** F_LABELS labels  :  标签文本 */
	public static final String F_LABELS = "labels";
	/** F_USERID user_id  :  user_id */
	public static final String F_USERID = "userId";
	/** F_ANCHORNUM anchor_num  :  是否站立，0站1坐 */
	public static final String F_ANCHORNUM = "anchorNum";
	/** F_SEAT seat  :  活力青春 */
	public static final String F_SEAT = "seat";
	/** F_ANCHORTYPE anchor_type  :  直播间风格 */
	public static final String F_ANCHORTYPE = "anchorType";
	/** F_PLUSSERVICE plus_service  :  vip服务 */
	public static final String F_PLUSSERVICE = "plusService";


	/** labels 标签文本 */@NotBlank @Size(max=65535)
	
	private String labels;
	/** userId user_id */@Size(max=200)
	@TableField("user_id")
	private String userId;
	/** anchorNum 是否站立，0站1坐 */@Size(max=500)
	@TableField("anchor_num")
	private String anchorNum;
	/** seat 活力青春 */@Size(max=20)
	
	private String seat;
	/** anchorType 直播间风格 */@Size(max=50)
	@TableField("anchor_type")
	private String anchorType;
	/** plusService vip服务 */@Size(max=100)
	@TableField("plus_service")
	private String plusService;


	@Override
    public boolean equals(Object o) {
        return super.equals(o);
    }
    @Override
    public int hashCode() {
        return super.hashCode();
    }
}
