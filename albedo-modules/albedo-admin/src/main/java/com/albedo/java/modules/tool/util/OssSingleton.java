package com.albedo.java.modules.tool.util;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.FileUploadUtil;
import com.albedo.java.common.core.util.FileUtil;
import com.albedo.java.modules.biz.service.task.VideoTaskExecutor;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.event.ProgressListener;
import com.aliyun.oss.model.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import static com.albedo.java.common.core.constant.BusinessConstants.ALIBABA_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.ALIBABA_SECRET;

/**
 * todo 应该存到同个bucket下按前缀来划分
 *
 * @author arronshentu
 */
@Component
@Slf4j
public class OssSingleton {

  ApplicationProperties applicationProperties;

  public OssSingleton(ApplicationProperties applicationProperties, @Value("${oss.endpoint}") String endpoint) {
    this.applicationProperties = applicationProperties;
    String accessKeyId = applicationProperties.getKey(ALIBABA_ID);
    String accessKeySecret = applicationProperties.getKey(ALIBABA_SECRET);
    client = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
  }

  public OssSingleton() {
    String endpoint = "https://oss-cn-shenzhen.aliyuncs.com";
    // internalClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
    client = new OSSClientBuilder().build(endpoint, "LTAI4G9GELKL2AM8BxufjLUE", "usIxuCax2SM5cQ6uDnNBZ1CARpbuhg");
  }

  // private OSS internalClient;
  private final OSS client;

  public void uploadFile(File file, String objectName, String bucketName) {
    PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, file);
    ObjectMetadata metadata = new ObjectMetadata();
    metadata.setContentDisposition("attachment");
    putObjectRequest.setMetadata(metadata);
    client.putObject(putObjectRequest);
  }

  public void uploadFileNonAsync(File file, String objectName, String bucketName) {
    log.info("开始上传文件{}", objectName);
    PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, file);
    ObjectMetadata metadata = new ObjectMetadata();
    metadata.setContentDisposition("attachment");
    putObjectRequest.setMetadata(metadata);
    client.putObject(putObjectRequest);
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

  /**
   * 存储单位 GB
   *
   * @param bucketName
   * @return
   */
  public double getBucketStorage(String bucketName) {
    return listFiles(bucketName, "").stream().mapToDouble(OSSObjectSummary::getSize).sum() / 1024 / 1024;
  }

  public void remove(String bucketName, String objectName) {
    client.deleteObject(bucketName, objectName);
  }

  @Async
  public void remove(String url) {
    if (!StringUtils.contains(url, ".oss-cn-shenzhen.aliyuncs.com/")) {
      log.error("删除{}失败", url);
      return;
    }
    String[] split = url.split(".oss-cn-shenzhen.aliyuncs.com/");
    String bucket = split[0];
    String object = split[1];
    try {
      remove(bucket, object);
    } catch (Exception e) {
      log.error("删除{}-{}失败", bucket, object);
    }
  }

  public boolean doesBucketExist(String bucketName) {
    return client.doesBucketExist(bucketName);
  }

  /**
   * 存储空间的命名规范如下：
   * <p>
   * 只能包括小写字母、数字和短划线（-）。
   * 必须以小写字母或者数字开头和结尾。
   * 长度必须在3~63字节之间。
   *
   * @param bucketName bucket命名
   */
  public void create(String bucketName, int storageSize) {
    CreateBucketRequest createBucketRequest = new CreateBucketRequest(bucketName);
    createBucketRequest.setCannedACL(CannedAccessControlList.PublicRead);
    createBucketRequest.setStorageClass(StorageClass.Standard);
    client.createBucket(createBucketRequest);
    client.setBucketStorageCapacity(bucketName, new UserQos(storageSize));
  }

  public File downloadFile(String bucketName, String objectName, String filePath) {
    log.info("下载{}-{}至{}", bucketName, objectName, filePath);
    return downloadFile(bucketName, objectName, filePath, new VideoTaskExecutor.GetObjectProgressListener());
  }

  public File downloadFile(String bucketName, String objectName, ProgressListener listener) {
    String filePath = FileUploadUtil.getBucketPath(bucketName, objectName);
    File file = new File(filePath);
    client.getObject(new GetObjectRequest(bucketName, objectName).withProgressListener(listener), file);
    return file;
  }

  public File downloadFile(String bucketName, String objectName, String filePath, ProgressListener listener) {
    FileUtil.del(filePath);
    log.info("下载{}-{}至{}", bucketName, objectName, filePath);
    File file = FileUtil.touch(filePath);
    client.getObject(new GetObjectRequest(bucketName, objectName).withProgressListener(listener), file);
    return file;
  }

  private String replace(String filePath, String parent) {
    return filePath.replace(parent + File.separator, "");
  }

  public String getFileName(File file) {
    return replace(file.getAbsolutePath(), file.getParent());
  }

  @Async
  public void removeOldestFile(String bucketName) {
    // todo 用到的都有问题
    ObjectListing objectListing = client.listObjects(bucketName);
    List<OSSObjectSummary> objectSummaries = objectListing.getObjectSummaries();
    objectSummaries.sort(Comparator.comparing(OSSObjectSummary::getLastModified));
    remove(bucketName, objectSummaries.get(0).getKey());
  }

  public String getUrl(String filePath) {
    String parent = cn.hutool.core.io.FileUtil.getParent(filePath, 2);
    String originUrl = filePath.replace(parent + "/", "");
    originUrl = originUrl.replace("/", ".oss-cn-shenzhen.aliyuncs.com/");
    return originUrl;
  }

  public String getPath(String url) {
    if (url.contains("static")) {
      url = url.replaceAll("static.vlivest.com/", "");
      return "vlivest-2" + File.separator + url;
    }
    // 9169280e-3159-4218-be7a-bf0dc298785c.oss-cn-shenzhen.aliyuncs.com/ce1c7a71f6a8b72cf21f7cdabc655114.mp4
    String[] split = url.split(".oss-cn-shenzhen.aliyuncs.com/");
    String bucket = split[0];
    String object = split[1];
    return bucket + File.separator + object;
  }

  public static void main(String[] args) throws URISyntaxException {
    OssSingleton ossSingleton = new OssSingleton();
    String filePath =
      "C:\\albedo\\file\\upload\\15e02440c879452abfe0e089652cd972\\2a6affdd94b7a3e001ed04ee2e53bd30.mp4";
    // String url = ossSingleton.getUrl(filePath);
    Path file = Paths.get(new URI(filePath));
    String s = file.getParent().getParent().getFileName().toString();
    // String parent = file.getParentFile().getParent();

    System.out.println(s);
  }

}
