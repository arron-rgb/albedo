package com.albedo.java.modules.tool.domain;

import org.apache.commons.lang3.StringUtils;

/**
 * @author arronshentu
 */

public enum SmsEnum {

  // LOGIN_TEMPLATE_CODE("SMS_175435174", "vlivest", "code"),
  FORGET_PASSWORD_TEMPLATE_CODE("SMS_200188565", "虚拟工坊", "code"),
  REGISTER_TEMPLATE_CODE("SMS_200183062", "虚拟工坊", "code"), SUCCESS_NOTIFICATION("SMS_205065311", "虚拟工坊", "");

  /**
   * 短信模板编码
   */
  private String templateCode;
  /**
   * 签名
   */
  private String signName;
  /**
   * 短信模板必需的数据名称，多个key以逗号分隔，此处配置作为校验
   */
  private String keys;

  SmsEnum(String templateCode, String signName, String keys) {
    this.templateCode = templateCode;
    this.signName = signName;
    this.keys = keys;
  }

  public String getTemplateCode() {
    return templateCode;
  }

  public void setTemplateCode(String templateCode) {
    this.templateCode = templateCode;
  }

  public String getSignName() {
    return signName;
  }

  public void setSignName(String signName) {
    this.signName = signName;
  }

  public String getKeys() {
    return keys;
  }

  public void setKeys(String keys) {
    this.keys = keys;
  }

  public static SmsEnum toEnum(String templateCode) {
    if (StringUtils.isEmpty(templateCode)) {
      return null;
    }
    for (SmsEnum item : SmsEnum.values()) {
      if (item.getTemplateCode().equals(templateCode)) {
        return item;
      }
    }
    return null;
  }
}
