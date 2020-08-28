package com.albedo.java.modules.biz.web;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.web.resource.BaseResource;

import lombok.AllArgsConstructor;

/**
 * @author arronshentu
 */
@RestController
@RequestMapping(value = "${application.admin-path}/test")
@AllArgsConstructor
public class TestResource extends BaseResource {

  @GetMapping()
  public Result get(HttpServletRequest request, HttpServletResponse response) {
    return Result.buildOk(response.getHeader("X-CSRF-TOKEN"));
  }

  @RequestMapping(value = "uploadVideo", method = RequestMethod.POST)
  @ResponseBody
  public Result<String> savaVideo(@RequestParam("file") MultipartFile file) throws IllegalStateException {
    String savePaths = "";
    String webPaths = "";

    if (file.isEmpty() || StringUtil.isBlank(file.getOriginalFilename())) {
      return Result.buildFail("");
    }
    // 获取文件后缀
    String fileExt =
      file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
    // 重构文件名称
    String pikId = UUID.randomUUID().toString().replaceAll("-", "");
    String newVideoName = pikId + "." + fileExt;
    // 保存视频
    File fileSave = new File(savePaths, newVideoName);
    try {
      file.transferTo(fileSave);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return Result.buildOk(webPaths + newVideoName);
  }

}
