package com.albedo.java.common;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;

public class UtilTest {

  public static void main(String[] args) {
    String ALIBABA_ID = "ALIBABA_ID";
    String ALIBABA_SECRET = "ALIBABA_SECRET";
    String TENCENT_ID = "TENCENT_ID";
    String TENCENT_SECRET = "TENCENT_SECRET";
    Map<String, String> params = new HashMap<>() {
      {
        put(ALIBABA_ID, ALIBABA_ID);
        put(ALIBABA_SECRET, ALIBABA_SECRET);
        put(TENCENT_ID, TENCENT_ID);
        put(TENCENT_SECRET, TENCENT_SECRET);
      }
    };
    params.forEach((key, value) -> {
      value = System.getenv(key);
      params.put(key, value);
    });

    System.out.println(JSON.toJSONString(params));
  }

}
