package com.albedo.java.common.core.util;

import java.io.File;
import java.text.DecimalFormat;

import cn.hutool.core.util.IdUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 文件操作工具类 实现文件的创建、删除、复制、压缩、解压以及目录的创建、删除、复制、压缩解压等功能
 *
 * @author Lijie
 * @version 2013-06-21
 */
@Slf4j
public class FileUtil extends cn.hutool.core.io.FileUtil {

  /**
   * 定义GB的计算常量
   */
  private static final int GB = 1024 * 1024 * 1024;
  /**
   * 定义MB的计算常量
   */
  private static final int MB = 1024 * 1024;
  /**
   * 定义KB的计算常量
   */
  private static final int KB = 1024;
  /**
   * 格式化小数
   */
  private static final DecimalFormat DF = new DecimalFormat("0.00");

  /**
   * 文件大小转换
   */
  public static String getSize(long size) {
    String resultSize;
    if (size / GB >= 1) {
      // 如果当前Byte的值大于等于1GB
      resultSize = DF.format(size / (float)GB) + "GB   ";
    } else if (size / MB >= 1) {
      // 如果当前Byte的值大于等于1MB
      resultSize = DF.format(size / (float)MB) + "MB   ";
    } else if (size / KB >= 1) {
      // 如果当前Byte的值大于等于1KB
      resultSize = DF.format(size / (float)KB) + "KB   ";
    } else {
      resultSize = size + "B   ";
    }
    return resultSize;
  }

  public static final String PATH = System.getenv("PWD");
  public static final String SEPARATOR = File.separator;

  public static String concatFilePath(String... paths) {
    StringBuilder result = new StringBuilder(PATH);
    for (String path : paths) {
      result.append(SEPARATOR).append(path);
    }
    return result.toString();
  }

  public static String concatSimpleFilePath(String... paths) {
    StringBuilder result = new StringBuilder();
    for (String path : paths) {
      result.append(path).append(SEPARATOR);
    }
    return result.substring(0, result.length() - 1);
  }

  /**
   * 生成文件名
   *
   * @param extName
   * @return
   */
  public static String generateFilePath(String extName) {
    String fileName = concatSimpleFilePath("/Users/arronshentu/Downloads", IdUtil.fastSimpleUUID() + "." + extName);
    log.info("generateFilePath: {}", fileName);
    // 传入绝对路径
    File touch = FileUtil.touch(fileName);
    return touch.getAbsolutePath();
  }

}
