package com.albedo.java.modules.biz.web;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Invoice;
import com.albedo.java.modules.biz.domain.dto.InvoiceDto;
import com.albedo.java.modules.biz.service.InvoiceService;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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
@Api(tags = "抬头")
public class InvoiceResource extends BaseResource {

  private final InvoiceService service;

  /**
   * @param id
   * @return
   */
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @ApiOperation("抬头查看")
  @PreAuthorize("@pms.hasPermission('biz_invoice_view')")
  public Result get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getOneDto(id));
  }

  /**
   * GET / : get all invoice.
   *
   * the pagination information
   *
   * @return the Result with status 200 (OK) and with body all invoice
   */

  @PreAuthorize("@pms.hasPermission('biz_invoice_view')")
  @GetMapping("list")
  @LogOperate(value = "发票抬头查询")
  @ApiOperation(value = "发票抬头查询")
  public Result<List<Invoice>> getPage() {
    List<Invoice> list = service.list(Wrappers.<Invoice>query().eq("user_id", SecurityUtil.getUser().getId()));
    String adminId = userService.getAdminIdByDeptId(SecurityUtil.getUser().getDeptId());
    List<Invoice> adminInvoices = service.list(Wrappers.<Invoice>query().eq("user_id", adminId));
    list.addAll(adminInvoices);
    list = list.stream().distinct().collect(Collectors.toList());
    return Result.buildOkData(list);
  }

  @Resource
  UserService userService;

  /**
   * POST / : Save a invoiceDto.
   *
   * @param invoiceDto
   *          the HTTP invoice
   */
  @PreAuthorize("@pms.hasPermission('biz_invoice_edit')")
  @LogOperate(value = "发票抬头编辑")
  @ApiOperation(value = "发票抬头编辑")
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
  @LogOperate(value = "发票抬头删除")
  @ApiOperation(value = "发票抬头删除")
  @DeleteMapping
  public Result delete(@RequestBody Set<String> ids) {
    log.debug("REST request to delete Invoice: {}", ids);
    service.removeByIds(ids);
    return Result.buildOk("删除发票抬头成功");
  }
}
