/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.domain;

import lombok.*;
import com.baomidou.mybatisplus.annotation.*;
import com.albedo.java.common.persistence.domain.IdEntity;
import javax.validation.constraints.Size;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.NotBlank;
import com.albedo.java.common.core.annotation.DictType;


import javax.validation.constraints.*;

/**
 * 商品管理Entity t_goods
 * @author admin
 * @version 2020-08-12 15:55:52
 */
@TableName(value = "t_goods")
@Data @ToString @NoArgsConstructor @AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class TGoods extends IdEntity<TGoods> {

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


	/** userId 用户id */@Size(max=32)
	@TableField("user_id")
	private String userId;
	/** name 商品名字 */@Size(max=255)
	
	private String name;
	/** videoId 视频id */@Size(max=32)
	@TableField("video_id")
	private String videoId;
	/** voiceUrl 这一小段文本的音频地址 */@Size(max=255)
	@TableField("voice_url")
	private String voiceUrl;
	/** voiceTime 音频时间，单位是秒 */@NotNull 
	@TableField("voice_time")
	private Long voiceTime;
	/** adWords 文本介绍 */@Size(max=255)
	@TableField("ad_words")
	private String adWords;
	/** templateWords 这是啥意思？ */@Size(max=255)
	@TableField("template_words")
	private String templateWords;
	/** photoUrls 多个图片，用英文逗号分开。怕太长用longtext */@Size(max=65535)
	@TableField("photo_urls")
	private String photoUrls;


	@Override
    public boolean equals(Object o) {
        return super.equals(o);
    }
    @Override
    public int hashCode() {
        return super.hashCode();
    }
}
