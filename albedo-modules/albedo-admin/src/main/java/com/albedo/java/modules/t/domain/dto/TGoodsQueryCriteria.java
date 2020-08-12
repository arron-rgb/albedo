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
 * 商品管理QueryCriteria t_goods
 * @author admin
 * @version 2020-08-12 15:55:52
 */
@Data
public class TGoodsQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/** F_USERID user_id  :  用户id */
	@Query(propName = "user_id")
	private String userId;
	/** F_NAME name  :  商品名字 */
	@Query(operator = Query.Operator.like)
	private String name;
	/** F_VIDEOID video_id  :  视频id */
	@Query(propName = "video_id")
	private String videoId;
	/** F_VOICEURL voice_url  :  这一小段文本的音频地址 */
	@Query(propName = "voice_url")
	private String voiceUrl;
	/** F_VOICETIME voice_time  :  音频时间，单位是秒 */
	@Query(propName = "voice_time")
	private Long voiceTime;
	/** F_ADWORDS ad_words  :  文本介绍 */
	@Query(propName = "ad_words")
	private String adWords;
	/** F_TEMPLATEWORDS template_words  :  这是啥意思？ */
	@Query(propName = "template_words")
	private String templateWords;
	/** F_PHOTOURLS photo_urls  :  多个图片，用英文逗号分开。怕太长用longtext */
	@Query(propName = "photo_urls")
	private String photoUrls;

}