package com.albedo.java.modules;

import org.junit.jupiter.api.Test;

import com.albedo.java.modules.tool.util.OSSSingleton;
import com.alibaba.fastjson.JSON;
import com.aliyun.oss.model.Bucket;

public class TestUtil {

  @Test
  void test() {
    printBuckets();
    OSSSingleton.shutdown();
    printBuckets();
    OSSSingleton.restart();
    printBuckets();
  }

  private void printBuckets() {
    for (Bucket bucket : OSSSingleton.getBuckets()) {
      System.out.println(JSON.toJSONString(bucket));
    }
  }
}
