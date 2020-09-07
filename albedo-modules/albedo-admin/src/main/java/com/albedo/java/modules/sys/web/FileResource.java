package com.albedo.java.modules.sys.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.util.FileUploadUtil;
import com.albedo.java.common.core.util.FileUtil;
import com.albedo.java.common.core.util.Result;
import com.google.common.collect.Maps;

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
   * 通用下载请求
   *
   * @param fileName
   *          文件名称
   * @param delete
   *          是否删除
   */
  @GetMapping("/download")
  public Result<String> fileDownload(String fileName, Boolean delete, HttpServletResponse response,
    HttpServletRequest request) {
    try {
      if (!FileUtil.isValidFilename(fileName)) {
        throw new Exception(String.format("文件名称(%s)非法，不允许下载。 ", fileName));
      }
      String realFileName = System.currentTimeMillis() + fileName.substring(fileName.indexOf("_") + 1);
      String filePath = ApplicationConfig.getUploadPath() + File.separator + fileName;

      response.setCharacterEncoding("utf-8");
      response.setContentType("multipart/form-data");
      response.setHeader("Content-Disposition",
        "attachment;fileName=" + FileUtil.setFileDownloadHeader(request, realFileName));
      try {
        FileUtil.writeBytes(filePath, response.getOutputStream());
      } catch (FileNotFoundException e) {
        return Result.buildFail("未查询到该文件");
      }
      if (delete) {
        FileUtil.deleteFile(filePath);
      }
      return Result.buildOk("下载成功");
    } catch (Exception e) {
      log.error("下载文件失败", e);
    }
    return Result.buildFail("下载文件失败");
  }

  /**
   * 通用上传请求
   */
  @PostMapping("/upload")
  @ResponseBody
  public Result<Map<Object, Object>> uploadFile(MultipartFile file, HttpServletRequest request) throws IOException {
    // 上传文件路径
    String filePath = ApplicationConfig.getUploadPath();
    // 上传并返回新文件名称
    String fileName = FileUploadUtil.upload(filePath, file);
    String url = getDomain(request) + fileName;
    Map<Object, Object> data = Maps.newHashMap();
    data.put("fileName", fileName);
    data.put("url", url);
    return Result.buildOkData(data);
  }

  private String getDomain(HttpServletRequest request) {
    StringBuffer url = request.getRequestURL();
    String contextPath = request.getServletContext().getContextPath();
    return url.delete(url.length() - request.getRequestURI().length(), url.length()).append(contextPath).toString();
  }
}
