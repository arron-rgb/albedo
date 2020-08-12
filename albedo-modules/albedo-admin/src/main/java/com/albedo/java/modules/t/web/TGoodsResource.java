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
import com.albedo.java.modules.t.domain.dto.TGoodsDto;
import com.albedo.java.modules.t.domain.dto.TGoodsQueryCriteria;
import com.albedo.java.modules.t.service.TGoodsService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import javax.validation.Valid;
import java.util.Set;

/**
 * 商品管理Controller t_goods
 * @author admin
 * @version 2020-08-12 15:55:52
 */
@RestController
@RequestMapping(value = "${application.admin-path}/t/t-goods")
@AllArgsConstructor
public class TGoodsResource extends BaseResource {

	private final TGoodsService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('t_tGoods_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return  Result.buildOkData(service.getOneDto(id));
	}
	/**
	 * GET / : get all tGoods.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all tGoods
	 */

	@PreAuthorize("@pms.hasPermission('t_tGoods_view')")
	@GetMapping
	@LogOperate(value = "商品管理查看")
	public Result getPage(PageModel pm, TGoodsQueryCriteria tGoodsQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tGoodsQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a tGoodsDto.
	 *
	 * @param tGoodsDto the HTTP tGoods
	 */
	@PreAuthorize("@pms.hasPermission('t_tGoods_edit')")
	@LogOperate(value = "商品管理编辑")
	@PostMapping
	public Result save(@Valid @RequestBody TGoodsDto tGoodsDto) {
		log.debug("REST request to save TGoodsDto : {}", tGoodsDto);
		service.saveOrUpdate(tGoodsDto);
		return Result.buildOk("保存t_goods成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" TGoods.
	 *
	 * @param ids the id of the tGoods to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('t_tGoods_del')")
	@LogOperate(value = "商品管理删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete TGoods: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除t_goods成功");
	}
}