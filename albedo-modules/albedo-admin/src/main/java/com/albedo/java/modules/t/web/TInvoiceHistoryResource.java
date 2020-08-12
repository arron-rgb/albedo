/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.web;


import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.t.domain.dto.TInvoiceHistoryDto;
import com.albedo.java.modules.t.domain.dto.TInvoiceHistoryQueryCriteria;
import com.albedo.java.modules.t.service.TInvoiceHistoryService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import javax.validation.Valid;
import java.util.Set;

/**
 * 查看发票申请历史Controller t_invoice_history
 * @author admin
 * @version 2020-08-12 11:02:01
 */
@RestController
@RequestMapping(value = "${application.admin-path}/t/t-invoice-history")
@AllArgsConstructor
public class TInvoiceHistoryResource extends BaseResource {

	private final TInvoiceHistoryService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('t_tInvoiceHistory_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all tInvoiceHistory.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all tInvoiceHistory
	 */

	@PreAuthorize("@pms.hasPermission('t_tInvoiceHistory_view')")
	@GetMapping
	@LogOperate(value = "查看发票申请历史查看")
	public Result getPage(PageModel pm, TInvoiceHistoryQueryCriteria tInvoiceHistoryQueryCriteria) {
		//只能查看自己的发票记录
		String uid= SecurityUtil.getUser().getId();
		tInvoiceHistoryQueryCriteria.setUserId(uid);

		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tInvoiceHistoryQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a tInvoiceHistoryDto.
	 *
	 * @param tInvoiceHistoryDto the HTTP tInvoiceHistory
	 */
	@PreAuthorize("@pms.hasPermission('t_tInvoiceHistory_edit')")
	@LogOperate(value = "查看发票申请历史编辑")
	@PostMapping
	public Result save(@Valid @RequestBody TInvoiceHistoryDto tInvoiceHistoryDto) {
		log.debug("REST request to save TInvoiceHistoryDto : {}", tInvoiceHistoryDto);
		//设置uid，前端记得要取消掉
		String uid= SecurityUtil.getUser().getId();
		tInvoiceHistoryDto.setUserId(uid);

		service.saveOrUpdate(tInvoiceHistoryDto);
		return Result.buildOk("保存t_invoice_history成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" TInvoiceHistory.
	 *
	 * @param ids the id of the tInvoiceHistory to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('t_tInvoiceHistory_del')")
	@LogOperate(value = "查看发票申请历史删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete TInvoiceHistory: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除t_invoice_history成功");
	}
}
