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
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.t.domain.dto.TInvoiceDto;
import com.albedo.java.modules.t.domain.dto.TInvoiceQueryCriteria;
import com.albedo.java.modules.t.service.TInvoiceService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import javax.validation.Valid;
import java.util.Set;

/**
 * 管理发票抬头Controller t_invoice
 * @author admin
 * @version 2020-08-12 11:17:40
 */
@RestController
@RequestMapping(value = "${application.admin-path}/t/t-invoice")
@AllArgsConstructor
public class TInvoiceResource extends BaseResource {

	private final TInvoiceService service;

	@Autowired
	UserService userService;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('t_tInvoice_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all tInvoice.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all tInvoice
	 */

	@PreAuthorize("@pms.hasPermission('t_tInvoice_view')")
	@GetMapping
	@LogOperate(value = "管理发票抬头查看")
	public Result getPage(PageModel pm, TInvoiceQueryCriteria tInvoiceQueryCriteria) {
		//用户只能查看自己的发票。从数据库中插入数据，然后系统中只能看到uid是自己的抬头
		String uid=SecurityUtil.getUser().getId();
		tInvoiceQueryCriteria.setUserId(uid);

		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tInvoiceQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a tInvoiceDto.
	 *
	 * @param tInvoiceDto the HTTP tInvoice
	 */
	@PreAuthorize("@pms.hasPermission('t_tInvoice_edit')")
	@LogOperate(value = "管理发票抬头编辑")
	@PostMapping
	public Result save(@Valid @RequestBody TInvoiceDto tInvoiceDto) {
		log.debug("REST request to save TInvoiceDto : {}", tInvoiceDto);
		//这里保存的时候，userid是默认的，前端要去掉
		String uid= SecurityUtil.getUser().getId();
		tInvoiceDto.setUserId(uid);

		service.saveOrUpdate(tInvoiceDto);
		return Result.buildOk("保存t_invoice成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" TInvoice.
	 *
	 * @param ids the id of the tInvoice to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('t_tInvoice_del')")
	@LogOperate(value = "管理发票抬头删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete TInvoice: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除t_invoice成功");
	}
}
