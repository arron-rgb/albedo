/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import java.util.Set;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.dto.InvoiceDto;
import com.albedo.java.modules.biz.domain.dto.InvoiceQueryCriteria;
import com.albedo.java.modules.biz.service.InvoiceService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import lombok.AllArgsConstructor;

/**
 * 发票抬头管理Controller 发票抬头
 *
 * @author arronshentu
 * @version 2020-08-16 16:19:02
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/invoice")
@AllArgsConstructor
public class InvoiceResource extends BaseResource {

  private final InvoiceService service;

  /**
   * @param id
   * @return
   */
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_invoice_view')")
  public Result get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getOneDto(id));
  }

  /**
   * GET / : get all invoice.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all invoice
   */

  @PreAuthorize("@pms.hasPermission('biz_invoice_view')")
  @GetMapping
  @LogOperate(value = "发票抬头管理查看")
  public Result getPage(PageModel pm, InvoiceQueryCriteria invoiceQueryCriteria) {
    QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, invoiceQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  /**
   * POST / : Save a invoiceDto.
   *
   * @param invoiceDto
   *          the HTTP invoice
   */
  @PreAuthorize("@pms.hasPermission('biz_invoice_edit')")
  @LogOperate(value = "发票抬头管理编辑")
  @PostMapping
  public Result save(@Valid @RequestBody InvoiceDto invoiceDto) {
    log.debug("REST request to save InvoiceDto : {}", invoiceDto);
    service.saveOrUpdate(invoiceDto);
    return Result.buildOk("保存发票抬头成功");

  }

  /**
   * DELETE //:ids : delete the "ids" Invoice.
   *
   * @param ids
   *          the id of the invoice to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_invoice_del')")
  @LogOperate(value = "发票抬头管理删除")
  @DeleteMapping
  public Result delete(@RequestBody Set<String> ids) {
    log.debug("REST request to delete Invoice: {}", ids);
    service.removeByIds(ids);
    return Result.buildOk("删除发票抬头成功");
  }
}
