/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;


import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.biz.domain.dto.TestBookDto;
import com.albedo.java.modules.biz.domain.dto.TestBookQueryCriteria;
import com.albedo.java.modules.biz.service.TestBookService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import javax.validation.Valid;
import java.util.Set;

/**
 * testController test
 * @author admin
 * @version 2020-08-08 21:20:40
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/test-book")
@AllArgsConstructor
public class TestBookResource extends BaseResource {

	private final TestBookService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('biz_testBook_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all testBook.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all testBook
	 */

	@PreAuthorize("@pms.hasPermission('biz_testBook_view')")
	@GetMapping
	@LogOperate(value = "test查看")
	public Result getPage(PageModel pm, TestBookQueryCriteria testBookQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, testBookQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a testBookDto.
	 *
	 * @param testBookDto the HTTP testBook
	 */
	@PreAuthorize("@pms.hasPermission('biz_testBook_edit')")
	@LogOperate(value = "test编辑")
	@PostMapping
	public Result save(@Valid @RequestBody TestBookDto testBookDto) {
		log.debug("REST request to save TestBookDto : {}", testBookDto);
		service.saveOrUpdate(testBookDto);
		return Result.buildOk("保存test成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" TestBook.
	 *
	 * @param ids the id of the testBook to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('biz_testBook_del')")
	@LogOperate(value = "test删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete TestBook: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除test成功");
	}
}
