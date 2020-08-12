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
 * 控制前端页面内容Dto t_front
 * @author admin
 * @version 2020-08-12 10:47:45
 */
@Data @ToString @NoArgsConstructor @AllArgsConstructor
public class TFrontDto extends DataDto<String> {

	private static final long serialVersionUID = 1L;
	/** F_NAME name  :  前端页面名字 */
	public static final String F_NAME = "name";
	/** F_PATH path  :  前端页面地址 */
	public static final String F_PATH = "path";
	/** F_ADWORD ad_word  :  广告语内容 */
	public static final String F_ADWORD = "adWord";


	/** name 前端页面名字 */
 @Size(max=64)
	private String name;
	/** path 前端页面地址 */
 @Size(max=255)
	private String path;
	/** adWord 广告语内容 */
 @Size(max=255)
	private String adWord;


}
