package com.albedo.java.modules.sys.web;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.modules.AlbedoAdminApplication;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.service.UserService;
import com.alibaba.fastjson.JSON;

import lombok.extern.slf4j.Slf4j;

/**
 * Test class for the UserResource REST web.
 *
 * @see com.albedo.java.modules.sys.web.UserResource
 */
@SpringBootTest(classes = {AlbedoAdminApplication.class})
@Slf4j
public class UserResourceIntTest {

  @Autowired
  UserService userService;

  @Test
  @Transactional(rollbackFor = Exception.class)
  public void createUser() throws Exception {
    List<User> databaseSizeBeforeCreate = userService.list();

    // Validate the User in the database
    List<User> userList = userService.list();
    for (User user : userList) {
      System.out.println(JSON.toJSONString(user));
    }
  }

}
