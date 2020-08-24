package com.albedo.java.modules.tool.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.internal.OSSHeaders;
import com.aliyun.oss.model.*;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@Slf4j
public class OSSSingleton {
  /**
   * 阿里云主账号AccessKey拥有所有API的访问权限，风险很高。
   * 强烈建议您创建并使用RAM账号进行API访问或日常运维，
   * 请登录 https://ram.console.aliyun.com 创建RAM账号。
   */
  private static final String ACCESS_KEY_ID = "LTAI4G9GELKL2AM8BxufjLUE";
  private static final String ACCESS_KEY_SECRET = "usIxuCax2SM5cQ6uDnNBZ1CARpbuhg";
  private static final String ENDPOINT = "http://oss-cn-hangzhou.aliyuncs.com";
  private static final String BUCKET_NAME = "vlivest";
  @Getter
  private static OSS CLIENT = new OSSClientBuilder().build(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);

  void uploadFile(File file, String objectName) {
    // 如果需要上传时设置存储类型与访问权限，请参考以下示例代码。
    ObjectMetadata metadata = new ObjectMetadata();
    metadata.setHeader(OSSHeaders.OSS_STORAGE_CLASS, StorageClass.Standard.toString());
    metadata.setObjectAcl(CannedAccessControlList.Private);
    uploadFile(file, objectName, metadata);
    // 上传文件。
  }

  void uploadFile(File file, String objectName, ObjectMetadata metadata) {
    PutObjectRequest putObjectRequest = new PutObjectRequest(BUCKET_NAME, objectName, file);
    putObjectRequest.setMetadata(metadata);
    CLIENT.putObject(putObjectRequest);
    CLIENT.shutdown();
  }

  public static List<Bucket> getBuckets() {
    try {
      return CLIENT.listBuckets();
    } catch (ClientException e) {
      log.info("出错");
      log.error("{}", e.getMessage());
      return new ArrayList<>();
    }
  }

  public static void shutdown() {
    CLIENT.shutdown();
  }

  public static void restart() {
    CLIENT = new OSSClientBuilder().build(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);
  }

}
