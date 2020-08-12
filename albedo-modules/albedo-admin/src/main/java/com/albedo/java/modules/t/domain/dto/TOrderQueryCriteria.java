/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.*;

/**
 * 订单管理QueryCriteria t_order
 * @author admin
 * @version 2020-08-12 15:36:12
 */
@Data
public class TOrderQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	@Query(propName = "user_id")
	private String userId;
	/** F_STATUS status  :  订单状态（具体细节后面再说） */
	@Query()
	private String status;
	/** F_TYPE type  :  订单类型（加速卡，单次，多次） */
	@Query()
	private String type;
	/** F_VIDEOID video_id  :  视频id，等视频上传后更新 */
	@Query(propName = "video_id")
	private String videoId;
	/** F_TRADENO trade_no  :  支付宝订单交易号 */
	@Query(propName = "trade_no")
	private String tradeNo;
	/** F_PRICE price  :  支付金额 */
	@Query()
	private Double price;
	/** F_USERNAME user_name  :  用户名字 */
	@Query(propName = "user_name")
	private String userName;
	/** F_USERPHONE user_phone  :  用户电话 */
	@Query(propName = "user_phone")
	private String userPhone;

}