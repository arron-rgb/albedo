package com.albedo.java.common.core.util;

import lombok.extern.slf4j.Slf4j;

/**
 * 获取地址类
 *
 * @author somewhere
 */
@Slf4j
public class AddressUtil {

  public static final String IP_URL = "http://ip.taobao.com/service/getIpInfo.php";

  public static String getRealAddressByIp(String ip) {
    return ip;
  }
}
