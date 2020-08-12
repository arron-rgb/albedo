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
 * 订单管理Dto t_order
 * @author admin
 * @version 2020-08-12 15:36:12
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class TOrderDto extends DataDto<String> {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	public static final String F_USERID = "userId";
	/** F_STATUS status  :  订单状态（具体细节后面再说） */
	public static final String F_STATUS = "status";
	/** F_TYPE type  :  订单类型（加速卡，单次，多次） */
	public static final String F_TYPE = "type";
	/** F_VIDEOID video_id  :  视频id，等视频上传后更新 */
	public static final String F_VIDEOID = "videoId";
	/** F_TRADENO trade_no  :  支付宝订单交易号 */
	public static final String F_TRADENO = "tradeNo";
	/** F_PRICE price  :  支付金额 */
	public static final String F_PRICE = "price";
	/** F_USERNAME user_name  :  用户名字 */
	public static final String F_USERNAME = "userName";
	/** F_USERPHONE user_phone  :  用户电话 */
	public static final String F_USERPHONE = "userPhone";


	/** userId 用户id */
 @NotBlank @Size(max=32)
	private String userId;
	/** status 订单状态（具体细节后面再说） */
 @Size(max=255)
	private String status;
	/** type 订单类型（加速卡，单次，多次） */
 @Size(max=255)
	private String type;
	/** videoId 视频id，等视频上传后更新 */
 @Size(max=32)
	private String videoId;
	/** tradeNo 支付宝订单交易号 */
 @Size(max=50)
	private String tradeNo;
	/** price 支付金额 */
 
	private Double price;
	/** userName 用户名字 */
 @Size(max=255)
	private String userName;
	/** userPhone 用户电话 */
 @Size(max=255)
	private String userPhone;


}
