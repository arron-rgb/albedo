/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.domain.dto;

import com.albedo.java.common.core.vo.DataDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 管理发票抬头Dto t_invoice
 * @author admin
 * @version 2020-08-12 11:17:40
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class TInvoiceDto extends DataDto<String> {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	public static final String F_USERID = "userId";
	/** F_TYPE type  :  0-个人，1-企业 */
	public static final String F_TYPE = "type";
	/** F_NAME name  :  企业名称/个人名称 */
	public static final String F_NAME = "name";
	/** F_TAXNUM tax_num  :  公司税号 */
	public static final String F_TAXNUM = "taxNum";
	/** F_COMPANYLOCATION company_location  :  注册地址 */
	public static final String F_COMPANYLOCATION = "companyLocation";
	/** F_COMPANYPHONE company_phone  :  公司电话 */
	public static final String F_COMPANYPHONE = "companyPhone";
	/** F_ACCOUNTBANK account_bank  :  开户公司 */
	public static final String F_ACCOUNTBANK = "accountBank";
	/** F_ACCOUNTNUMBER account_number  :  开户账号 */
	public static final String F_ACCOUNTNUMBER = "accountNumber";


	/** userId 用户id */
 @Size(max=32)
	private String userId;
	/** type 0-个人，1-企业 */
 @NotBlank @Size(max=1)
	private String type;
	/** name 企业名称/个人名称 */
 @NotBlank @Size(max=255)
	private String name;
	/** taxNum 公司税号 */
 @Size(max=0)
	private String taxNum;
	/** companyLocation 注册地址 */
 @Size(max=255)
	private String companyLocation;
	/** companyPhone 公司电话 */
 @Size(max=255)
	private String companyPhone;
	/** accountBank 开户公司 */
 @Size(max=255)
	private String accountBank;
	/** accountNumber 开户账号 */
 @Size(max=32)
	private String accountNumber;


}
