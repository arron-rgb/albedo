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
 * 商品管理Dto t_goods
 * @author admin
 * @version 2020-08-12 15:55:52
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class TGoodsDto extends DataDto<String> {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	public static final String F_USERID = "userId";
	/** F_NAME name  :  商品名字 */
	public static final String F_NAME = "name";
	/** F_VIDEOID video_id  :  视频id */
	public static final String F_VIDEOID = "videoId";
	/** F_VOICEURL voice_url  :  这一小段文本的音频地址 */
	public static final String F_VOICEURL = "voiceUrl";
	/** F_VOICETIME voice_time  :  音频时间，单位是秒 */
	public static final String F_VOICETIME = "voiceTime";
	/** F_ADWORDS ad_words  :  文本介绍 */
	public static final String F_ADWORDS = "adWords";
	/** F_TEMPLATEWORDS template_words  :  这是啥意思？ */
	public static final String F_TEMPLATEWORDS = "templateWords";
	/** F_PHOTOURLS photo_urls  :  多个图片，用英文逗号分开。怕太长用longtext */
	public static final String F_PHOTOURLS = "photoUrls";


	/** userId 用户id */
 @Size(max=32)
	private String userId;
	/** name 商品名字 */
 @Size(max=255)
	private String name;
	/** videoId 视频id */
 @Size(max=32)
	private String videoId;
	/** voiceUrl 这一小段文本的音频地址 */
 @Size(max=255)
	private String voiceUrl;
	/** voiceTime 音频时间，单位是秒 */
 @NotNull 
	private Long voiceTime;
	/** adWords 文本介绍 */
 @Size(max=255)
	private String adWords;
	/** templateWords 这是啥意思？ */
 @Size(max=255)
	private String templateWords;
	/** photoUrls 多个图片，用英文逗号分开。怕太长用longtext */
 @Size(max=65535)
	private String photoUrls;


}
