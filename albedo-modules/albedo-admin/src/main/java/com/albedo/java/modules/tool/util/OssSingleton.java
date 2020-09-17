package com.albedo.java.modules.tool.util;

import static com.albedo.java.common.core.constant.BusinessConstants.ALIBABA_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.ALIBABA_SECRET;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.FileUtil;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.event.ProgressListener;
import com.aliyun.oss.internal.OSSHeaders;
import com.aliyun.oss.model.*;

import lombok.extern.slf4j.Slf4j;

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

  public OssSingleton() {

    // export ALIBABA_ID="LTAI4G9GELKL2AM8BxufjLUE"
    // export ALIBABA_SECRET="usIxuCax2SM5cQ6uDnNBZ1CARpbuhg"
    String endpoint = "http://oss-cn-hangzhou.aliyuncs.com";
    client = new OSSClientBuilder().build(endpoint, "LTAI4G9GELKL2AM8BxufjLUE", "usIxuCax2SM5cQ6uDnNBZ1CARpbuhg");
  }

  private OSS client;

  public void restart() {
    String accessKeyId = applicationProperties.getKey(ALIBABA_ID);
    String accessKeySecret = applicationProperties.getKey(ALIBABA_SECRET);
    String endpoint = "http://oss-cn-hangzhou.aliyuncs.com";
    client = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
  }

  public void uploadFile(File file, String objectName) {
    ObjectMetadata metadata = new ObjectMetadata();
    metadata.setHeader(OSSHeaders.OSS_STORAGE_CLASS, StorageClass.Standard.toString());
    metadata.setObjectAcl(CannedAccessControlList.PublicRead);
    uploadFile(file, objectName, metadata, "vlivest");
  }

  public void uploadFile(File file, String objectName, String bucketName) {
    PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, file);
    client.putObject(putObjectRequest);
  }

  public void uploadFile(File file, String objectName, ObjectMetadata metadata, String bucketName) {
    PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, file);
    putObjectRequest.setMetadata(metadata);
    client.putObject(putObjectRequest);
  }

  @Async
  public PutObjectResult uploadFileStream(InputStream inputStream, String bucketName, String key) {
    return client.putObject(bucketName, key, inputStream);
  }

  public List<Bucket> listBuckets() {
    try {
      return client.listBuckets();
    } catch (ClientException e) {
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

  public void removeFile(String bucketName, String objectName) {
    // 删除文件。如需删除文件夹，请将ObjectName设置为对应的文件夹名称。如果文件夹非空，则需要将文件夹下的所有object删除后才能删除该文件夹。
    client.deleteObject(bucketName, objectName);
  }

  public boolean doesObjectExist(String bucketName, String objectName) {
    return client.doesObjectExist(bucketName, objectName);
  }

  public File downloadFile(String bucketName, String objectName, String filePath) {
    return downloadFile(bucketName, objectName, filePath, null);
  }

  public File downloadFile(String bucketName, String objectName, ProgressListener listener) {
    String filePath = FileUtil.concatFilePath(bucketName, objectName);
    File file = new File(filePath);
    client.getObject(new GetObjectRequest(bucketName, objectName).withProgressListener(listener), file);
    return file;
  }

  public File downloadFile(String bucketName, String objectName, String filePath, ProgressListener listener) {
    File file = new File(filePath);
    client.getObject(new GetObjectRequest(bucketName, objectName).withProgressListener(listener), file);
    return file;
  }

  public String localPathToUrl(String bucketName, String filename) {
    return concatUrl(bucketName, "oss-cn-hangzhou.aliyuncs.com") + "/" + filename;
  }

  public String concatUrl(String... paths) {
    StringBuilder stringBuilder = new StringBuilder();
    for (String path : paths) {
      stringBuilder.append(path).append(".");
    }
    return stringBuilder.substring(0, stringBuilder.length() - 1);
  }

  private String replace(String filePath, String parent) {
    return filePath.replace(parent + File.separator, "");
  }

  public String getFileName(File file) {
    return replace(file.getAbsolutePath(), file.getParent());
  }

  public String localPathToUrl(String filePath) {
    File file = new File(filePath);
    String fileParent = file.getParent();
    String fileName = getFileName(file);
    String bucketName = replace(fileParent, file.getParentFile().getParent());
    return localPathToUrl(bucketName, fileName);
  }
}
