package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.CommonConstants.STR_YES;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.validation.Valid;
import javax.validation.constraints.Size;

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
import lombok.Data;

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
  @LogOperate(value = "批量生成优惠券")
  @ApiOperation(value = "批量生成优惠券")
  @PostMapping
  public Result<List<Coupon>> save(@Valid @RequestBody CouponDto couponDto) {
	  List<Coupon> coupons = new ArrayList<>(couponDto.getNum());
	  for (int integer = 0; integer < couponDto.getNum(); integer++) {
		  Coupon coupon = new Coupon();
		  coupon.setDiscount(couponDto.getDiscount());
		  coupon.setCode(getUUID());
		  coupon.setStatus(STR_YES);
		  coupons.add(coupon);
		  service.saveOrUpdate(coupon);
	  }
	  return Result.buildOkData(coupons, "保存优惠券成功");
  }


  @Data
  static class Body {
    @Size(max = 32)
    private String discount;

    private Integer num;
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
