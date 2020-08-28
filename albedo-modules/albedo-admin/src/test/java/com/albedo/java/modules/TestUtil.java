package com.albedo.java.modules;

import org.junit.jupiter.api.Test;

import com.albedo.java.modules.tool.util.OssSingleton;
import com.alibaba.fastjson.JSON;
import com.aliyun.oss.model.Bucket;

public class TestUtil {

  @Test
  void test() {
    printBuckets();
    OssSingleton.shutdown();
    printBuckets();
    // OssSingleton.restart();
    printBuckets();
  }

  private void printBuckets() {
    for (Bucket bucket : OssSingleton.getBuckets()) {
      System.out.println(JSON.toJSONString(bucket));
    }
  }
}
