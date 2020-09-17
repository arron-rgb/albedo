package com.albedo.java.common.core.util;

import com.albedo.java.common.core.config.ApplicationConfig;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cn.hutool.core.net.NetUtil;
import cn.hutool.http.HttpUtil;
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
    String address = "XX XX";

    // 内网不查询
    if (NetUtil.isInnerIP(ip)) {
      return "内网IP";
    }
    String rspStr;
    if (ApplicationConfig.isAddressEnabled()) {
      try {
        rspStr = HttpUtil.post(IP_URL, "ip=" + ip);
        if (StringUtil.isEmpty(rspStr)) {
          return address;
        }
        JSONObject obj = JSON.parseObject(rspStr, JSONObject.class);
        JSONObject data = obj.getJSONObject("data");
        String region = data.getString("region");
        String city = data.getString("city");
        address = region + " " + city;
      } catch (Exception e) {
        log.error("获取地理位置异常 {}", ip);
        return "";
      }
    }
    return address;
  }
}
