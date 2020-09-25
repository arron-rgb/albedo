package com.albedo.java.modules.biz.web;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Invoice;
import com.albedo.java.modules.biz.domain.InvoiceRequest;
import com.albedo.java.modules.biz.domain.dto.InvoiceRequestDto;
import com.albedo.java.modules.biz.domain.dto.InvoiceRequestQueryCriteria;
import com.albedo.java.modules.biz.service.InvoiceRequestService;
import com.albedo.java.modules.biz.service.InvoiceService;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 开票请求Controller 开票请求
 *
 * @author arronshentu
 * @version 2020-09-18 22:41:18
 */
@RestController
@Api("开票请求增删改查")
@RequestMapping(value = "${application.admin-path}/biz/invoice-request")
@AllArgsConstructor
public class InvoiceRequestResource extends BaseResource {

  private final InvoiceRequestService service;

  /**
   * @param id
   * @return
   */
  @ApiOperation(value = "获取单个开票请求")
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_invoiceRequest_view')")
  public Result<InvoiceRequestDto> get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getOneDto(id));
  }

  /**
   * GET / : get all invoiceRequest.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all invoiceRequest
   */

  @Resource
  InvoiceService invoiceService;

  @PreAuthorize("@pms.hasPermission('biz_invoiceRequest_view')")
  @GetMapping
  @ApiOperation(value = "查询开票请求")
  @LogOperate(value = "开票请求查看")
  public Result<PageModel<InvoiceRequest>> getPage(PageModel<InvoiceRequest> pm,
    InvoiceRequestQueryCriteria invoiceRequestQueryCriteria) {
    QueryWrapper<InvoiceRequest> wrapper = QueryWrapperUtil.getWrapper(pm, invoiceRequestQueryCriteria);
    PageModel<InvoiceRequest> page = service.page(pm, wrapper);
    List<InvoiceRequest> records = page.getRecords();
    records.forEach(record -> {
      Invoice invoice = invoiceService.getById(record.getInvoiceId());
      if (invoice != null) {
        record.setInvoiceId(invoice.getName());
      }

      UserDto user = userService.findDtoById(record.getCreatedBy());
      if (user != null) {
        if (StringUtils.isNotEmpty(user.getUsername())) {
          record.setCreatedBy(user.getUsername());
        }
      }
    });
    return Result.buildOkData(page);
  }

  @Resource
  UserService userService;

  /**
   * POST / : Save a invoiceRequestDto.
   *
   * @param invoiceRequestDto
   *          the HTTP invoiceRequest
   */
  @PreAuthorize("@pms.hasPermission('biz_invoiceRequest_edit')")
  @LogOperate(value = "开票请求编辑")
  @ApiOperation(value = "开票请求编辑")
  @PostMapping
  public Result<String> save(@Valid @RequestBody InvoiceRequestDto invoiceRequestDto) {
    log.debug("REST request to save InvoiceRequestDto : {}", invoiceRequestDto);
    service.saveOrUpdate(invoiceRequestDto);
    return Result.buildOk("保存开票请求成功");
  }

  /**
   * DELETE //:ids : delete the "ids" InvoiceRequest.
   *
   * @param ids
   *          the id of the invoiceRequest to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_invoiceRequest_del')")
  @LogOperate(value = "开票请求删除")
  @ApiOperation(value = "删除开票请求")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除开票请求成功");
  }
}
