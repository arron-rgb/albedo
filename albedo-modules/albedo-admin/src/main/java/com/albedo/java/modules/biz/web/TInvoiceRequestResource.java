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
import com.albedo.java.modules.biz.domain.TInvoiceRequest;
import com.albedo.java.modules.biz.domain.dto.TInvoiceRequestDto;
import com.albedo.java.modules.biz.domain.dto.TInvoiceRequestQueryCriteria;
import com.albedo.java.modules.biz.service.TInvoiceRequestService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;


import io.swagger.annotations.ApiOperation;
import javax.validation.Valid;
import java.util.Set;

/**
 * 开票请求管理Controller 开票请求
 * @author admin
 * @version 2020-10-03 16:15:33
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/t-invoice-request")
@AllArgsConstructor
public class TInvoiceRequestResource extends BaseResource {

	private final TInvoiceRequestService service;

	/**
	 * @param id
	 * @return
	 */
	@ApiOperation(value = "获取单个开票请求管理")
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('biz_tInvoiceRequest_view')")
	public Result<TInvoiceRequestDto> get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all tInvoiceRequest.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all tInvoiceRequest
	 */

	@PreAuthorize("@pms.hasPermission('biz_tInvoiceRequest_view')")
	@GetMapping
	@ApiOperation(value = "查询开票请求管理")
	@LogOperate(value = "开票请求管理查看")
	public Result<PageModel<TInvoiceRequest>> getPage(PageModel<TInvoiceRequest> pm, TInvoiceRequestQueryCriteria tInvoiceRequestQueryCriteria) {
		QueryWrapper<TInvoiceRequest> wrapper = QueryWrapperUtil.getWrapper(pm, tInvoiceRequestQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a tInvoiceRequestDto.
	 *
	 * @param tInvoiceRequestDto the HTTP tInvoiceRequest
	 */
	@PreAuthorize("@pms.hasPermission('biz_tInvoiceRequest_edit')")
	@LogOperate(value = "开票请求管理编辑")
	@ApiOperation(value = "编辑开票请求管理")
	@PostMapping
	public Result<String> save(@Valid @RequestBody TInvoiceRequestDto tInvoiceRequestDto) {
		log.debug("REST request to save TInvoiceRequestDto : {}", tInvoiceRequestDto);
		service.saveOrUpdate(tInvoiceRequestDto);
		return Result.buildOk("保存开票请求管理成功");
	}

	/**
	 * DELETE //:ids : delete the "ids" TInvoiceRequest.
	 *
	 * @param ids the id of the tInvoiceRequest to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('biz_tInvoiceRequest_del')")
	@LogOperate(value = "开票请求管理删除")
	@ApiOperation(value = "删除开票请求管理")
	@DeleteMapping
	public Result<String> delete(@RequestBody Set<String> ids) {
		service.removeByIds(ids);
		return Result.buildOk("删除开票请求管理成功");
	}
}
