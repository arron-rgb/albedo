/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.domain.dto.PurchaseRecordQueryCriteria;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 购买记录Controller PurchaseRecord
 *
 * @author admin
 * @version 2020-08-29 23:58:02
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/purchase-record")
@AllArgsConstructor
@Api(tags = "购买记录")
public class PurchaseRecordResource extends BaseResource {

  private final PurchaseRecordService service;

  /**
   * @param id
   * @return
   */
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_purchaseRecord_view')")
  public Result<PurchaseRecord> get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getById(id));
  }

  /**
   * GET / : get all purchaseRecord.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all purchaseRecord
   */

  @PreAuthorize("@pms.hasPermission('biz_purchaseRecord_view')")
  @GetMapping
  @LogOperate(value = "购买记录查看")
  @ApiOperation(value = "购买记录查看")
  public Result<PageModel<PurchaseRecord>> getPage(PageModel<PurchaseRecord> pm,
    PurchaseRecordQueryCriteria purchaseRecordQueryCriteria) {
    QueryWrapper<PurchaseRecord> wrapper = QueryWrapperUtil.getWrapper(pm, purchaseRecordQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

}
