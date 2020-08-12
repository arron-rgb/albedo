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
 * 视频管理Dto t_video
 * @author admin
 * @version 2020-08-12 15:59:38
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class TVideoDto extends DataDto<String> {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	public static final String F_USERID = "userId";
	/** F_NAME name  :  视频名字 */
	public static final String F_NAME = "name";
	/** F_ORIGINURL origin_url  :  origin_url */
	public static final String F_ORIGINURL = "originUrl";
	/** F_LOGOURL logo_url  :  logo的地址 */
	public static final String F_LOGOURL = "logoUrl";
	/** F_OUTPUTURL output_url  :  输出地址 */
	public static final String F_OUTPUTURL = "outputUrl";
	/** F_DURATION duration  :  视频长度，单位是秒 */
	public static final String F_DURATION = "duration";


	/** userId 用户id */
 @Size(max=32)
	private String userId;
	/** name 视频名字 */
 @Size(max=255)
	private String name;
	/** originUrl origin_url */
 @Size(max=255)
	private String originUrl;
	/** logoUrl logo的地址 */
 @Size(max=255)
	private String logoUrl;
	/** outputUrl 输出地址 */
 @Size(max=255)
	private String outputUrl;
	/** duration 视频长度，单位是秒 */
 
	private Long duration;


}
