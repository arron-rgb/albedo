package com.albedo.java.common.core.util;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Objects;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.exception.RuntimeMsgException;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.lang.Assert;
import lombok.NonNull;

/**
 * 文件上传工具类
 *
 * @author somewhere
 */
public class FileUploadUtil {
  /**
   * 默认大小 1024 MB
   */
  public static final long DEFAULT_MAX_SIZE = 1024 * 1024 * 1024;

  /**
   * 默认的文件名最大长度 100
   */
  public static final int DEFAULT_FILE_NAME_LENGTH = 100;

  /**
   * 默认上传的地址
   */
  private static String defaultBaseDir = ApplicationConfig.getStaticFileDirectory();

  private static int counter = 0;

  public static String getDefaultBaseDir() {
    return defaultBaseDir;
  }

  /**
   * 根据文件路径上传
   *
   * @param baseDir
   *          相对应用的基目录
   * @param file
   *          上传的文件
   * @return 文件名称
   * @throws IOException
   */
  public static String upload(String baseDir, MultipartFile file) throws IOException {
    try {
      return upload(baseDir, file, MimeTypeUtil.DEFAULT_ALLOWED_EXTENSION);
    } catch (Exception e) {
      throw new IOException(e.getMessage(), e);
    }
  }

  /**
   * 文件上传
   *
   * @param baseDir
   *          相对应用的基目录
   * @param file
   *          上传的文件
   * @param allowedExtension
   *          上传文件类型
   * @return 返回上传成功的文件名
   * @throws IOException
   *           比如读写文件出错时
   */
  public static String upload(String baseDir, MultipartFile file, String[] allowedExtension) throws IOException {
    Assert.notNull(file, "文件为空");
    String originalFilename = file.getOriginalFilename();
    Assert.isTrue(StringUtils.isNotEmpty(originalFilename), "文件名不合法");
    int fileNameLength = originalFilename.length();
    if (fileNameLength > FileUploadUtil.DEFAULT_FILE_NAME_LENGTH) {
      throw new RuntimeMsgException("最大文件名长度：" + FileUploadUtil.DEFAULT_FILE_NAME_LENGTH);
    }
    assertAllowed(file, allowedExtension);
    String fileName = extractFilename(file);
    File desc = getAbsoluteFile(baseDir, fileName);
    file.transferTo(desc);
    return desc.getAbsolutePath();
  }

  /**
   * 编码文件名
   */
  public static String extractFilename(MultipartFile file) {
    String fileName = file.getOriginalFilename();
    String extension = getExtension(file);
    fileName = encodingFilename(fileName) + StringUtil.DOT + extension;
    return fileName;
  }

  public static File getAbsoluteFile(String fileName) throws IOException {
    return getAbsoluteFile(getDefaultBaseDir(), fileName);
  }

  public static File getAbsoluteFile(String uploadDir, String fileName) throws IOException {
    File desc = new File(uploadDir + File.separator + fileName).getCanonicalFile();
    if (!desc.getParentFile().exists()) {
      boolean mkdirs = desc.getParentFile().mkdirs();
    }
    return desc;
  }

  /**
   * 编码文件名
   */
  private static String encodingFilename(String fileName) {
    fileName = fileName.replace("_", " ");
    fileName = fileName.substring(0, fileName.lastIndexOf("."))+"_"+System.nanoTime();
    return fileName;
  }

  /**
   * 文件大小校验
   *
   * @param file
   *          上传的文件
   * @return
   */
  public static void assertAllowed(MultipartFile file, String[] allowedExtension) {
    long size = file.getSize();
    if (size > DEFAULT_MAX_SIZE) {
      throw new RuntimeMsgException("最大上传文件大小：" + (DEFAULT_MAX_SIZE / 1024 / 1024));
    }

    String fileName = file.getOriginalFilename();
    String extension = getExtension(file);
    if (allowedExtension != null && !isAllowedExtension(extension, allowedExtension)) {
      throw new RuntimeMsgException(
        String.format("InvalidExtensionException : allowedExtension-%s extension-%s fileName-%s",
          Arrays.toString(allowedExtension), extension, fileName));
    }

  }

  /**
   * 判断MIME类型是否是允许的MIME类型
   *
   * @param extension
   * @param allowedExtension
   * @return
   */
  public static boolean isAllowedExtension(String extension, String[] allowedExtension) {
    for (String str : allowedExtension) {
      if (str.equalsIgnoreCase(extension)) {
        return true;
      }
    }
    return false;
  }

  /**
   * 获取文件名的后缀
   *
   * @param file
   *          表单文件
   * @return 后缀名
   */
  public static String getExtension(@NonNull MultipartFile file) {
    String extension = FileUtil.extName(file.getOriginalFilename());
    if (StringUtil.isEmpty(extension)) {
      Assert.notNull(Objects.requireNonNull(file.getContentType()), "未知文件类型");
      extension = MimeTypeUtil.getExtension(file.getContentType());
    }
    return extension;
  }

  public static String getBucketPath(String bucketName, String objectName) {
    return getDefaultBaseDir() + File.separator + bucketName + File.separator + objectName;
  }

}
