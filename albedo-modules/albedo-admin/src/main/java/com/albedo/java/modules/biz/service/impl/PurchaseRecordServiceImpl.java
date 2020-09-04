/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.biz.domain.PurchaseRecord;
import com.albedo.java.modules.biz.domain.dto.PurchaseRecordDto;
import com.albedo.java.modules.biz.repository.PurchaseRecordRepository;
import com.albedo.java.modules.biz.service.PurchaseRecordService;

/**
 * 购买记录ServiceImpl PurchaseRecord
 *
 * @author admin
 * @version 2020-08-29 23:58:02
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class PurchaseRecordServiceImpl
  extends DataServiceImpl<PurchaseRecordRepository, PurchaseRecord, PurchaseRecordDto, String>
  implements PurchaseRecordService {

}
