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
import com.albedo.java.modules.biz.domain.dto.PurchaseRecordDto;
import com.albedo.java.modules.biz.domain.dto.PurchaseRecordQueryCriteria;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import javax.validation.Valid;
import java.util.Set;

/**
 * 购买记录Controller PurchaseRecord
 * @author admin
 * @version 2020-08-29 23:58:02
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/purchase-record")
@AllArgsConstructor
public class PurchaseRecordResource extends BaseResource {

	private final PurchaseRecordService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('biz_purchaseRecord_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all purchaseRecord.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all purchaseRecord
	 */

	@PreAuthorize("@pms.hasPermission('biz_purchaseRecord_view')")
	@GetMapping
	@LogOperate(value = "购买记录查看")
	public Result getPage(PageModel pm, PurchaseRecordQueryCriteria purchaseRecordQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, purchaseRecordQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a purchaseRecordDto.
	 *
	 * @param purchaseRecordDto the HTTP purchaseRecord
	 */
	@PreAuthorize("@pms.hasPermission('biz_purchaseRecord_edit')")
	@LogOperate(value = "购买记录编辑")
	@PostMapping
	public Result save(@Valid @RequestBody PurchaseRecordDto purchaseRecordDto) {
		log.debug("REST request to save PurchaseRecordDto : {}", purchaseRecordDto);
		service.saveOrUpdate(purchaseRecordDto);
		return Result.buildOk("保存PurchaseRecord成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" PurchaseRecord.
	 *
	 * @param ids the id of the purchaseRecord to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('biz_purchaseRecord_del')")
	@LogOperate(value = "购买记录删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete PurchaseRecord: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除PurchaseRecord成功");
	}
}