/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.BusinessConstants.TRADE_SUCCESS;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.domain.dto.PurchaseRecordQueryCriteria;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.tool.service.AliPayService;
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

  @GetMapping
  @LogOperate(value = "购买记录查看")
  @ApiOperation(value = "查询可开票的购买记录")
  public Result<PageModel<PurchaseRecord>> getPage(PageModel<PurchaseRecord> pm,
    PurchaseRecordQueryCriteria purchaseRecordQueryCriteria, String available) {
    QueryWrapper<PurchaseRecord> wrapper = QueryWrapperUtil.getWrapper(pm, purchaseRecordQueryCriteria);
    wrapper.eq("user_id", SecurityUtil.getUser().getId());
    wrapper.eq("status", TRADE_SUCCESS);
    // todo 新增字段 是否已开票
    wrapper.ne("", "");
    if (StringUtils.equals(available, "1")) {
      // 过滤已开的订单
      List<String> orderIds = new ArrayList<>();
      wrapper.notIn("order_id", orderIds);
    }
    return Result.buildOkData(service.page(pm, wrapper));
  }

  @GetMapping("generate")
  @LogOperate(value = "购买记录查看")
  @ApiOperation(value = "生成开票请求")
  public Result generate(List<String> recordIds) {
    // 1. 查看支付状态
    // 2. 把订单金额加起来
    // 3. 生成开票请求
    // 4. 将purcharsRecord设置为已开票的状态
    recordIds = recordIds.stream().distinct().collect(Collectors.toList());
    Set<PurchaseRecord> records = recordIds.stream().map((recordId) -> {
      PurchaseRecord re = service.getById(recordId);
      if (Objects.isNull(re)) {
        return null;
      }
      if (StringUtils.equals(aliPayService.queryOrderStatus(re.getOutTradeNo()), TRADE_SUCCESS)) {
        return re;
      }
      return null;
    }).collect(Collectors.toSet());
    records.forEach(record -> {
      // todo 设置为已开票
      service.updateById(record);
    });
    // 开票所需信息 1. 抬头 2. 用户 3. 开票金额 4. 数据库存储消耗的order
    return Result.buildOkData(null);
  }

  @Resource
  AliPayService aliPayService;

}
