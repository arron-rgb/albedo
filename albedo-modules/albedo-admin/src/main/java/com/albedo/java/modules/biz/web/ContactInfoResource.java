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
import com.albedo.java.modules.biz.domain.ContactInfo;
import com.albedo.java.modules.biz.domain.dto.ContactInfoDto;
import com.albedo.java.modules.biz.domain.dto.ContactInfoQueryCriteria;
import com.albedo.java.modules.biz.service.ContactInfoService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 联系单Controller 联系单
 *
 * @author arronshentu
 * @version 2020-09-02 13:51:29
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/contact-info")
@AllArgsConstructor
@Api(tags = "企业联系方式")
public class ContactInfoResource extends BaseResource {

  private final ContactInfoService service;

  /**
   * @param id
   * @return
   */
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @ApiOperation("联系单获取")
  @PreAuthorize("@pms.hasPermission('biz_contactInfo_view')")
  public Result<ContactInfoDto> get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(service.getOneDto(id));
  }

  /**
   * GET / : get all contactInfo.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all contactInfo
   */

  @PreAuthorize("@pms.hasPermission('biz_contactInfo_view')")
  @GetMapping
  @ApiOperation("联系单查看")
  @LogOperate(value = "联系单查看")
  public Result<PageModel<ContactInfo>> getPage(PageModel<ContactInfo> pm,
    ContactInfoQueryCriteria contactInfoQueryCriteria) {
    QueryWrapper<ContactInfo> wrapper = QueryWrapperUtil.getWrapper(pm, contactInfoQueryCriteria);
    return Result.buildOkData(service.page(pm, wrapper));
  }

  /**
   * POST / : Save a contactInfoDto.
   *
   * @param contactInfoDto
   *          the HTTP contactInfo
   */
  @PreAuthorize("@pms.hasPermission('biz_contactInfo_edit')")
  @LogOperate(value = "联系单编辑")
  @ApiOperation("联系单编辑")
  @PostMapping
  public Result<String> save(@Valid @RequestBody ContactInfoDto contactInfoDto) {
    log.debug("REST request to save ContactInfoDto : {}", contactInfoDto);
    service.saveOrUpdate(contactInfoDto);
    return Result.buildOk("保存联系单成功");
  }

  @PreAuthorize("@pms.hasPermission('biz_contactInfo_edit')")
  @LogOperate(value = "联系单更新")
  @ApiOperation("联系单状态更新")
  @GetMapping("/update?{id}")
  public Result<String> update(@PathVariable("id") String id) {
    ContactInfo info = service.getById(id);
    info.setStatus("1");
    service.updateById(info);
    return Result.buildOk("更新成功");
  }

  /**
   * DELETE //:ids : delete the "ids" ContactInfo.
   *
   * @param ids
   *          the id of the contactInfo to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_contactInfo_del')")
  @LogOperate(value = "联系单删除")
  @ApiOperation(value = "联系单删除")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除联系单成功");
  }
}
