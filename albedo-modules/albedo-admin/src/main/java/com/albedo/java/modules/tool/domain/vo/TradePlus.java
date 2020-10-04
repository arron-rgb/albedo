package com.albedo.java.modules.tool.domain.vo;

import javax.validation.constraints.NotBlank;

import com.albedo.java.modules.tool.util.AliPayUtils;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 支付宝PC接口参数
 *
 * @author arronshentu
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TradePlus {

  /**
   * （必填）商户订单号，应该由后台生成
   * 64 个字符以内的大小，可包含字母、数字、下划线。需保证该参数在商户端不重复
   */
  @NotBlank
  private String outTradeNo;

  /**
   * 支付宝仅支持该值
   */
  @NotBlank
  private String productCode = "FAST_INSTANT_TRADE_PAY";

  /**
   * 订单总金额，单位为元，精确到小数点后两位，取值范围为 [0.01,100000000]。金额不能为0。
   */
  @NotBlank
  private String totalAmount;

  /**
   * 订单标题
   */
  @NotBlank
  private String subject;

  /**
   * 绝对超时时间，格式为 yyyy-MM-dd HH:mm:ss
   */
  private String timeExpire;

  private ExtendParams extendParams;

  @Data
  @Builder
  @NoArgsConstructor
  @AllArgsConstructor
  public static class ExtendParams {
    /**
     * 系统商编号，该参数作为系统商返佣数据提取的依据，请填写系统商签约协议的PID。似乎是必须
     */
    private String sysServiceProviderId;
  }

  public static TradePlus build(String amount, String subject) {
    return builder().subject(subject).totalAmount(amount).outTradeNo(AliPayUtils.getOrderCode()).build();
  }
}
