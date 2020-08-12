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
import com.albedo.java.modules.t.domain.dto.TFrontDto;
import com.albedo.java.modules.t.domain.dto.TFrontQueryCriteria;
import com.albedo.java.modules.t.service.TFrontService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import javax.validation.Valid;
import java.util.Set;

/**
 * 控制前端页面内容Controller t_front
 * @author admin
 * @version 2020-08-12 10:47:45
 */
@RestController
@RequestMapping(value = "${application.admin-path}/t/t-front")
@AllArgsConstructor
public class TFrontResource extends BaseResource {

	private final TFrontService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('t_tFront_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all tFront.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all tFront
	 */

	@PreAuthorize("@pms.hasPermission('t_tFront_view')")
	@GetMapping
	@LogOperate(value = "控制前端页面内容查看")
	public Result getPage(PageModel pm, TFrontQueryCriteria tFrontQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tFrontQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a tFrontDto.
	 *
	 * @param tFrontDto the HTTP tFront
	 */
	@PreAuthorize("@pms.hasPermission('t_tFront_edit')")
	@LogOperate(value = "控制前端页面内容编辑")
	@PostMapping
	public Result save(@Valid @RequestBody TFrontDto tFrontDto) {
		log.debug("REST request to save TFrontDto : {}", tFrontDto);
		service.saveOrUpdate(tFrontDto);
		return Result.buildOk("保存t_front成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" TFront.
	 *
	 * @param ids the id of the tFront to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('t_tFront_del')")
	@LogOperate(value = "控制前端页面内容删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete TFront: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除t_front成功");
	}
}