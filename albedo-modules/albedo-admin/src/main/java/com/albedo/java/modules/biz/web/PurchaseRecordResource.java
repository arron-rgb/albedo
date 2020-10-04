/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.web;

import static com.albedo.java.common.core.constant.BusinessConstants.TRADE_FINISHED;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.InvoiceRequest;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.domain.dto.Param;
import com.albedo.java.modules.biz.service.InvoiceRequestService;
import com.albedo.java.modules.biz.service.PurchaseRecordService;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.service.AliPayService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

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

  @GetMapping("list")
  @ApiOperation("拉取已开票的消费记录")
  public Result<List<PurchaseRecord>> list() {
    List<PurchaseRecord> list = service.list(Wrappers.<PurchaseRecord>query().eq("status", TRADE_FINISHED)
      .eq("available", "0").eq("user_id", SecurityUtil.getUser().getId()));
    for (PurchaseRecord record : list) {
      UserVo user = userService.findUserVoById(record.getUserId());
      if (user != null) {
        String username = user.getUsername();
        if (StringUtils.isNotBlank(username)) {
          record.setUserId(username);
        }
      }
    }
    return Result.buildOkData(list);
  }

  @GetMapping
  @LogOperate(value = "购买记录查看")
  @ApiOperation(value = "查询可开票的购买记录")
  public Result<List<PurchaseRecord>> getPage() {
    List<PurchaseRecord> records = service.list(Wrappers.<PurchaseRecord>query()
      .eq("user_id", SecurityUtil.getUser().getId()).eq("status", TRADE_FINISHED).eq("available", "1"));
    records.forEach(record -> {
      UserVo user = userService.findUserVoById(record.getUserId());
      if (user != null) {
        String username = user.getUsername();
        if (StringUtils.isNotBlank(username)) {
          record.setUserId(username);
        }
      }
    });
    return Result.buildOkData(records);
  }

  @Resource
  UserService userService;

  @PostMapping("generate")
  @LogOperate(value = "购买记录查看")
  @ApiOperation(value = "生成开票请求")
  public Result<String> generate(@RequestBody Param param) {
    // 1. 查看支付状态
    // invoiceId 3687bb330c6980ed12bd2b870b376e14
    // recordIds [0fb21ef8fb2864924c63e2f0a667aba6]
    // 2. 把订单金额加起来
    // 3. 生成开票请求
    // 4. 将purcharsRecord设置为已开票的状态
    String invoiceId = param.getInvoiceId();
    List<String> recordIds = param.getRecordIds();

    recordIds = recordIds.stream().distinct().collect(Collectors.toList());
    List<PurchaseRecord> records = recordIds.stream().map(service::getById)
      .filter(record -> StringUtils.equals(record.getStatus(), TRADE_FINISHED)).collect(Collectors.toList());
    BigDecimal result =
      records.stream().map(record -> record.getTotalAmount() == null ? BigDecimal.ZERO : record.getTotalAmount())
        .reduce(BigDecimal.ZERO, BigDecimal::add);
    InvoiceRequest request = new InvoiceRequest();
    request.setTotalAmount(result);
    request.setInvoiceId(invoiceId);
    request.setRecordIds(concatId(recordIds));
    requestService.saveOrUpdate(request);
    records.forEach(record -> {
      record.setAvailable("0");
      service.updateById(record);
    });
    // 开票所需信息 1. 抬头 2. 用户 3. 开票金额 4. 数据库存储消耗的order
    return Result.buildOkData("已发起请求");
  }

  @Resource
  InvoiceRequestService requestService;

  @Resource
  AliPayService aliPayService;

  private String concatId(List<String> ids) {
    StringBuilder builder = new StringBuilder();
    for (String id : ids) {
      builder.append(id).append(",");
    }
    return builder.substring(0, builder.length() - 1);
  }
}
