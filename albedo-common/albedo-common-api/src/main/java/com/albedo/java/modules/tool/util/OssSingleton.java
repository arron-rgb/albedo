package com.albedo.java.modules.tool.util;

import static com.albedo.java.common.core.constant.BusinessConstants.ALIBABA_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.ALIBABA_SECRET;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.internal.OSSHeaders;
import com.aliyun.oss.model.*;

import lombok.extern.slf4j.Slf4j;

import javax.annotation.Resource;

/**
 * @author arronshentu
 */
@Component
@Slf4j
public class OssSingleton {

  ApplicationProperties applicationProperties;

  public OssSingleton(ApplicationProperties applicationProperties) {
    this.applicationProperties = applicationProperties;
    String accessKeyId = applicationProperties.getKey(ALIBABA_ID);
    String accessKeySecret = applicationProperties.getKey(ALIBABA_SECRET);

    String endpoint = "http://oss-cn-hangzhou.aliyuncs.com";
    client = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
  }

  private final OSS client;

  public void uploadFile(File file, String objectName) {
    ObjectMetadata metadata = new ObjectMetadata();
    metadata.setHeader(OSSHeaders.OSS_STORAGE_CLASS, StorageClass.Standard.toString());
    metadata.setObjectAcl(CannedAccessControlList.Private);
    uploadFile(file, objectName, metadata, "vlivest");
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

  public PutObjectResult uploadFileStream(InputStream inputStream, String bucketName, String key) {
    return client.putObject(bucketName, key, inputStream);
  }

  public List<Bucket> listBuckets() {
    try {
      return client.listBuckets();
    } catch (ClientException e) {
      log.info("出错");
      log.error("{}", e.getMessage());
      return new ArrayList<>();
    }
  }

  public List<OSSObjectSummary> listFiles(String bucketName, String keyPrefix) {
    // 列举文件。 如果不设置KeyPrefix，则列举存储空间下所有的文件。KeyPrefix，则列举包含指定前缀的文件。
    ObjectListing objectListing = client.listObjects(bucketName, keyPrefix);
    return objectListing.getObjectSummaries();
  }

  public long getBucketStorage(String bucketName) {
    return listFiles(bucketName, "").stream().mapToLong(OSSObjectSummary::getSize).sum();
  }

  public long getBucketStorage(String bucketName, String keyPrefix) {
    return listFiles(bucketName, keyPrefix).stream().mapToLong(OSSObjectSummary::getSize).sum();
  }

  public void remove(String bucketName, String objectName) {
    client.deleteObject(bucketName, objectName);
  }

  public boolean doesBucketExist(String bucketName) {
    return client.doesBucketExist(bucketName);
  }

  public void shutdown() {
    client.shutdown();
  }

  /**
   * 存储空间的命名规范如下：
   *
   * 只能包括小写字母、数字和短划线（-）。
   * 必须以小写字母或者数字开头和结尾。
   * 长度必须在3~63字节之间。
   *
   * @param bucketName
   *          bucket命名
   */
  public void create(String bucketName, int storageSize) {
    CreateBucketRequest createBucketRequest = new CreateBucketRequest(bucketName);
    createBucketRequest.setStorageClass(StorageClass.Standard);
    client.setBucketStorageCapacity(bucketName, new UserQos(storageSize));
    client.createBucket(createBucketRequest);
  }
}
