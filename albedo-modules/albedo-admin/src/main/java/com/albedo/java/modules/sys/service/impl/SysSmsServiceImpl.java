/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.sys.domain.SysSms;
import com.albedo.java.modules.sys.domain.dto.SysSmsDto;
import com.albedo.java.modules.sys.repository.SysSmsRepository;
import com.albedo.java.modules.sys.service.SysSmsService;

/**
 * 管理短信ServiceImpl sys_sms
 *
 * @author admin
 * @version 2020-08-12 15:46:27
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class SysSmsServiceImpl extends DataServiceImpl<SysSmsRepository, SysSms, SysSmsDto, String>
  implements SysSmsService {

  @Override
  public void saveOrUpdate(SysSmsDto sysSmsDto) {
    super.saveOrUpdate(sysSmsDto);
  }

  public void test() {

  }
}
