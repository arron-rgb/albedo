package com.albedo.java.modules.sys.web;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.util.FileUploadUtil;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.tool.util.OssSingleton;
import com.google.common.collect.Maps;

import cn.hutool.core.io.FileUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 通用请求处理
 *
 * @author somewhere
 */
@Controller
@Slf4j
@RequestMapping("${application.admin-path}/file")
public class FileResource {

  /**
   * 通用上传请求
   */
  @PostMapping("/upload")
  @ResponseBody
  public Result<Map<Object, Object>> uploadFile(MultipartFile file, HttpServletRequest request) throws IOException {
    // 上传文件路径
    String filePath = ApplicationConfig.getUploadPath();
    // 上传并返回新文件绝对路径
    String tempPath = FileUploadUtil.upload(filePath, file);
    ossSingleton.uploadFile(FileUtil.file(tempPath), FileUtil.getName(tempPath), "vlivest");
    FileUtil.del(tempPath);
    Map<Object, Object> data = Maps.newHashMap();
    String url = "static.vlivest.com/" + FileUtil.getName(tempPath);
    data.put("fileName", tempPath);
    data.put("url", url);
    return Result.buildOkData(data);
  }

  @Resource
  OssSingleton ossSingleton;

}
