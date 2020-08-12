/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.domain;

import lombok.*;
import com.baomidou.mybatisplus.annotation.*;
import com.albedo.java.common.persistence.domain.IdEntity;
import javax.validation.constraints.Size;
import javax.validation.constraints.NotBlank;
import com.albedo.java.common.core.annotation.DictType;


import javax.validation.constraints.*;

/**
 * 查看发票申请历史Entity t_invoice_history
 * @author admin
 * @version 2020-08-12 11:02:01
 */
@TableName(value = "t_invoice_history")
@Data @ToString @NoArgsConstructor @AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class TInvoiceHistory extends IdEntity<TInvoiceHistory> {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	public static final String F_USERID = "userId";
	/** F_INVOICEID invoice_id  :  发票id(数量统计用后台加一下就好) */
	public static final String F_INVOICEID = "invoiceId";


	/** userId 用户id */@NotBlank @Size(max=32)
	@TableField("user_id")
	private String userId;
	/** invoiceId 发票id(数量统计用后台加一下就好) */@Size(max=32)
	@TableField("invoice_id")
	private String invoiceId;


	@Override
    public boolean equals(Object o) {
        return super.equals(o);
    }
    @Override
    public int hashCode() {
        return super.hashCode();
    }
}
