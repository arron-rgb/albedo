/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.web;


import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.t.domain.dto.TVideoDto;
import com.albedo.java.modules.t.domain.dto.TVideoQueryCriteria;
import com.albedo.java.modules.t.service.TVideoService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import javax.validation.Valid;
import java.util.Set;

/**
 * 视频管理Controller t_video
 * @author admin
 * @version 2020-08-12 15:59:38
 */
@RestController
@RequestMapping(value = "${application.admin-path}/t/t-video")
@AllArgsConstructor
public class TVideoResource extends BaseResource {

	private final TVideoService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('t_tVideo_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all tVideo.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all tVideo
	 */

	@PreAuthorize("@pms.hasPermission('t_tVideo_view')")
	@GetMapping
	@LogOperate(value = "视频管理查看")
	public Result getPage(PageModel pm, TVideoQueryCriteria tVideoQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tVideoQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a tVideoDto.
	 *
	 * @param tVideoDto the HTTP tVideo
	 */
	@PreAuthorize("@pms.hasPermission('t_tVideo_edit')")
	@LogOperate(value = "视频管理编辑")
	@PostMapping
	public Result save(@Valid @RequestBody TVideoDto tVideoDto) {
		log.debug("REST request to save TVideoDto : {}", tVideoDto);
		service.saveOrUpdate(tVideoDto);
		return Result.buildOk("保存t_video成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" TVideo.
	 *
	 * @param ids the id of the tVideo to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('t_tVideo_del')")
	@LogOperate(value = "视频管理删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete TVideo: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除t_video成功");
	}
}