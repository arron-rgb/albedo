package com.albedo.java.modules.tool.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.internal.OSSHeaders;
import com.aliyun.oss.model.*;

import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

/**
 * @author arronshentu
 */
@UtilityClass
@Slf4j
public class OssSingleton {
  /**
   * 阿里云主账号AccessKey拥有所有API的访问权限，风险很高。
   * 强烈建议您创建并使用RAM账号进行API访问或日常运维，
   * 请登录 https://ram.console.aliyun.com 创建RAM账号。
   */
  private final String ACCESS_KEY_ID = "LTAI4G9GELKL2AM8BxufjLUE";
  private final String ACCESS_KEY_SECRET = "usIxuCax2SM5cQ6uDnNBZ1CARpbuhg";
  private final String ENDPOINT = "http://oss-cn-hangzhou.aliyuncs.com";
  private final String BUCKET_NAME = "vlivest";
  private final OSS client = new OSSClientBuilder().build(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);

  public void uploadFile(File file, String objectName) {
    // 如果需要上传时设置存储类型与访问权限，请参考以下示例代码。
    ObjectMetadata metadata = new ObjectMetadata();
    metadata.setHeader(OSSHeaders.OSS_STORAGE_CLASS, StorageClass.Standard.toString());
    metadata.setObjectAcl(CannedAccessControlList.Private);
    uploadFile(file, objectName, metadata, BUCKET_NAME);
    // 上传文件。
  }

  public void uploadFile(File file, String objectName, String bucketName) {
    PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, file);
    client.putObject(putObjectRequest);
    client.shutdown();
  }

  public void uploadFile(File file, String objectName, ObjectMetadata metadata, String bucketName) {
    PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, file);
    putObjectRequest.setMetadata(metadata);
    client.putObject(putObjectRequest);
    client.shutdown();
  }

  public void uploadFileStream(String filePath, String bucketName, String key) throws FileNotFoundException {
    InputStream inputStream = new FileInputStream(filePath);
    client.putObject(bucketName, key, inputStream);
  }

  public List<Bucket> getBuckets() {
    try {
      return client.listBuckets();
    } catch (ClientException e) {
      log.info("出错");
      log.error("{}", e.getMessage());
      return new ArrayList<>();
    }
  }

  public List<OSSObjectSummary> getFiles(String bucketName, String keyPrefix) {
    // 列举文件。 如果不设置KeyPrefix，则列举存储空间下所有的文件。KeyPrefix，则列举包含指定前缀的文件。
    ObjectListing objectListing = client.listObjects(bucketName, keyPrefix);
    return objectListing.getObjectSummaries();
  }

  public void remove(String bucketName, String objectName) {
    client.deleteObject(bucketName, objectName);
  }

  public long getFileSize(String bucketName, String keyPrefix) {
    return getFiles(bucketName, keyPrefix).stream().mapToLong(OSSObjectSummary::getSize).sum();
  }

  public void shutdown() {
    client.shutdown();
  }

  // public void restart() {
  // client = new OSSClientBuilder().build(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);
  // }

  public void create(String bucketName) {
    CreateBucketRequest createBucketRequest = new CreateBucketRequest(bucketName);
    createBucketRequest.setStorageClass(StorageClass.Standard);
    client.createBucket(createBucketRequest);
  }
}