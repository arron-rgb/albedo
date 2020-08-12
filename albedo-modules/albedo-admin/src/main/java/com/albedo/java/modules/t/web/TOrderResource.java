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
import com.albedo.java.modules.t.domain.dto.TOrderDto;
import com.albedo.java.modules.t.domain.dto.TOrderQueryCriteria;
import com.albedo.java.modules.t.service.TOrderService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import javax.validation.Valid;
import java.util.Set;

/**
 * 订单管理Controller t_order
 * @author admin
 * @version 2020-08-12 15:36:12
 */
@RestController
@RequestMapping(value = "${application.admin-path}/t/t-order")
@AllArgsConstructor
public class TOrderResource extends BaseResource {

	private final TOrderService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('t_tOrder_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all tOrder.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all tOrder
	 */

	@PreAuthorize("@pms.hasPermission('t_tOrder_view')")
	@GetMapping
	@LogOperate(value = "订单管理查看")
	public Result getPage(PageModel pm, TOrderQueryCriteria tOrderQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tOrderQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a tOrderDto.
	 *
	 * @param tOrderDto the HTTP tOrder
	 */
	@PreAuthorize("@pms.hasPermission('t_tOrder_edit')")
	@LogOperate(value = "订单管理编辑")
	@PostMapping
	public Result save(@Valid @RequestBody TOrderDto tOrderDto) {
		log.debug("REST request to save TOrderDto : {}", tOrderDto);
		service.saveOrUpdate(tOrderDto);
		return Result.buildOk("保存t_order成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" TOrder.
	 *
	 * @param ids the id of the tOrder to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('t_tOrder_del')")
	@LogOperate(value = "订单管理删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete TOrder: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除t_order成功");
	}
}