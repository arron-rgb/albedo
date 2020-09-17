package com.albedo.java.modules.biz.web;

import static com.alipay.api.msg.MsgConstants.SUCCESS;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.annotation.AnonymousAccess;
import com.albedo.java.common.core.annotation.Token;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.service.OrderService;
import com.albedo.java.modules.biz.service.VideoService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.domain.AlipayConfig;
import com.albedo.java.modules.tool.service.AliPayService;
import com.albedo.java.modules.tool.util.AliPayUtils;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.aliyun.oss.model.Bucket;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import springfox.documentation.annotations.ApiIgnore;

/**
 * @author arronshentu
 */
@RestController
@RequestMapping(value = "${application.admin-path}/test")
@AllArgsConstructor
@Api("测试")
public class TestResource extends BaseResource {

  @Resource
  RedisTemplate<String, String> redisTemplate;

  @PostMapping
  @Token
  @ApiOperation("token过滤")
  public Result<String> test(@RequestParam(value = "orderId") String orderId) {
    return Result.buildOk("orderId: " + orderId + "\ntoken: ");
  }

  @GetMapping
  @ApiOperation("更新")
  public String update(String videoId) {
    videoService.addAudio(videoId);
    return "任务发布成功";
  }

  @GetMapping("/bucket")
  public Result<String> getUserBucket() {
    return Result.buildOk(userService.getBucketName(SecurityUtil.getUser().getId()));
  }

  @GetMapping("/bucket/list")
  public Result<List<Bucket>> listBuckets() {
    List<Bucket> buckets = ossSingleton.listBuckets();
    return Result.buildOkData(buckets);
  }

  @GetMapping("/status")
  public Result<String> query(String outTradeNo) {
    String status;
    status = aliPayService.queryOrderStatus(outTradeNo);
    return Result.buildOkData(status);
  }

  @Resource
  AliPayService aliPayService;
  @Resource
  OssSingleton ossSingleton;
  @Resource
  UserService userService;
  @Resource
  VideoService videoService;

  @ApiIgnore
  @GetMapping("/return")
  @AnonymousAccess
  @ApiOperation("回调接口")
  // http://localhost:8014/a/tool/aliPay/return?charset=utf-8&out_trade_no=202009142231323366&method=alipay.trade.page.pay.return&total_amount=100.00&sign=VqIhgVFs630wcshbhaperayF1dCXBLVoJkyIHLUojusbJLycooBBTdpfcgmH4%2F1hkknb57vX1UZN%2B0Mu1tlb3V4uCqr0pDxauRfqkvO7sc9a3Z927uE2Gyw7qg6lNJAvRcJFAnJwpJO6%2Fd6d5kgNoqb5wIKSv4ds3Z%2FY08Lxk1ukzlh9r3mDdsbflSQIQDqHhEeDBRt2ywe6uL343GzBMXGUKKSTm1mqmY2HiHt4TdLz11M35trjgHNB0oVOcSnrZBojkQcuzb85rvF%2F0IXsZnyOeFZOwK%2Bl6c9Pk%2Bzu86Mk5bZ8VrAp%2BKrRS%2FB%2BrjKjmC2alcT721G7L6h%2BaLSr6w%3D%3D&trade_no=2020091422001476590501531914&auth_app_id=2021000116688194&version=1.0&app_id=2021000116688194&sign_type=RSA2&seller_id=2088621955056287&timestamp=2020-09-14+22%3A32%3A32
  public Result<String> returnPage(HttpServletRequest request, HttpServletResponse response) {
    AlipayConfig alipay = alipayService.find();
    response.setContentType("text/html;charset=" + alipay.getCharset());
    // 内容验签，防止黑客篡改参数
    if (alipayUtils.rsaCheck(request, alipay)) {
      String update = orderService.update(request);
      if (StringUtils.equals(SUCCESS.toLowerCase(), update)) {
        return Result.buildOk("支付成功");
      }
    } else {
      // 根据业务需要返回数据
      return Result.buildFail("支付异常");
    }
    return null;
  }

  @Resource
  AliPayUtils alipayUtils;
  @Resource
  AliPayService alipayService;
  @Resource
  OrderService orderService;
}
