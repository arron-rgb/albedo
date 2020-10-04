package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.CommonConstants.STR_YES;

import java.util.Set;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Coupon;
import com.albedo.java.modules.biz.domain.dto.CouponDto;
import com.albedo.java.modules.biz.domain.dto.CouponQueryCriteria;
import com.albedo.java.modules.biz.service.CouponService;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Snowflake;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * 优惠券Controller 优惠券
 *
 * @author admin
 * @version 2020-10-04 08:44:10
 */
@RestController
@RequestMapping(value = "${application.admin-path}/biz/coupon")
@AllArgsConstructor
public class CouponResource extends BaseResource {

  private final CouponService service;

  /**
   * @param code
   * @return
   */
  @ApiOperation(value = "查询单个优惠券")
  @GetMapping("query")
  @PreAuthorize("@pms.hasPermission('biz_coupon_view')")
  public Result<Coupon> query(String code) {
    log.debug("REST request to get Entity : {}", code);
    Coupon coupon = service.getOne(Wrappers.<Coupon>query().eq("code", code).eq("status", STR_YES), false);
    return Result.buildOkData(coupon);
  }

  /**
   * @param id
   * @return
   */
  @ApiOperation(value = "获取单个优惠券")
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('biz_coupon_view')")
  public Result<CouponDto> get(@PathVariable String id) {
    return Result.buildOkData(service.getOneDto(id));
  }

  /**
   * GET / : get all coupon.
   *
   * @param pm
   *          the pagination information
   * @return the Result with status 200 (OK) and with body all coupon
   */
  @PreAuthorize("@pms.hasPermission('biz_coupon_view')")
  @GetMapping
  @ApiOperation(value = "查询优惠券")
  @LogOperate(value = "优惠券查看")
  public Result<PageModel<Coupon>> getPage(PageModel<Coupon> pm, CouponQueryCriteria couponQueryCriteria) {
    QueryWrapper<Coupon> wrapper = QueryWrapperUtil.getWrapper(pm, couponQueryCriteria);
    PageModel<Coupon> page = service.page(pm, wrapper);
    page.getRecords().forEach(record -> {
      String userId = record.getUserId();
      UserVo byId = userService.findUserVoById(userId);
      if (byId != null) {
        record.setUserId(byId.getUsername());
      }
    });
    return Result.buildOkData(page);
  }

  /**
   * POST / : Save a couponDto.
   *
   * @param couponDto
   *          the HTTP coupon
   */
  @PreAuthorize("@pms.hasPermission('biz_coupon_edit')")
  @LogOperate(value = "优惠券编辑")
  @ApiOperation(value = "编辑优惠券")
  @PostMapping
  public Result<String> save(@Valid @RequestBody CouponDto couponDto) {
    log.debug("REST request to save CouponDto : {}", couponDto);
    couponDto.setCode(getUUID());
    couponDto.setStatus(STR_YES);
    service.saveOrUpdate(couponDto);
    return Result.buildOk("保存优惠券成功");
  }

  /**
   * DELETE //:ids : delete the "ids" Coupon.
   *
   * @param ids
   *          the id of the coupon to delete
   * @return the Result with status 200 (OK)
   */
  @PreAuthorize("@pms.hasPermission('biz_coupon_del')")
  @LogOperate(value = "优惠券删除")
  @ApiOperation(value = "删除优惠券")
  @DeleteMapping
  public Result<String> delete(@RequestBody Set<String> ids) {
    service.removeByIds(ids);
    return Result.buildOk("删除优惠券成功");
  }

  private String getUUID() {
    long id = SNOWFLAKE.nextId();
    return String.valueOf(id).substring(3);
  }

  private final static Snowflake SNOWFLAKE = cn.hutool.core.util.IdUtil.getSnowflake(1, 1);

  @Resource
  UserService userService;
}
