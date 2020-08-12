/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.sys.web;

import cn.hutool.core.date.DateField;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.DateUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.sys.domain.SysSms;
import com.albedo.java.modules.sys.domain.dto.SysSmsDto;
import com.albedo.java.modules.sys.domain.dto.SysSmsQueryCriteria;
import com.albedo.java.modules.sys.repository.SysSmsRepository;
import com.albedo.java.modules.sys.service.SysSmsService;
import com.albedo.java.modules.sys.web.SysSmsResource;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the SysSmsResource REST controller.
 *
 * @see SysSmsResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoAdminApplication.class)
@Slf4j
public class SysSmsResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_PHONENUMBER phone_number  :  phone_number */
	private static final Long DEFAULT_PHONENUMBER = 0l;
	/** UPDATED_PHONENUMBER phone_number  :  phone_number */
    private static final Long UPDATED_PHONENUMBER = 1l;
	/** DEFAULT_USERID user_id  :  开发票的userid */
	private static final String DEFAULT_USERID = "A";
	/** UPDATED_USERID user_id  :  开发票的userid */
    private static final String UPDATED_USERID = "B";
	/** DEFAULT_TYPE type  :  类型？ */
	private static final String DEFAULT_TYPE = "A";
	/** UPDATED_TYPE type  :  类型？ */
    private static final String UPDATED_TYPE = "B";
	/** DEFAULT_TEMPLATECODE template_code  :  模板代码？ */
	private static final String DEFAULT_TEMPLATECODE = "A";
	/** UPDATED_TEMPLATECODE template_code  :  模板代码？ */
    private static final String UPDATED_TEMPLATECODE = "B";
	/** DEFAULT_TEMPLATEPARAM template_param  :  template_param */
	private static final String DEFAULT_TEMPLATEPARAM = "A";
	/** UPDATED_TEMPLATEPARAM template_param  :  template_param */
    private static final String UPDATED_TEMPLATEPARAM = "B";
	/** DEFAULT_STATUS status  :  状态 */
	private static final String DEFAULT_STATUS = "A";
	/** UPDATED_STATUS status  :  状态 */
    private static final String UPDATED_STATUS = "B";
	/** DEFAULT_DESCRIPTION description  :  备注 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/** UPDATED_DESCRIPTION description  :  备注 */
    private static final String UPDATED_DESCRIPTION = "B";

    @Autowired
	private SysSmsService sysSmsService;

	private MockMvc restSysSmsMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private SysSmsDto sysSmsDto;

	private SysSmsDto anotherSysSmsDto = new SysSmsDto();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/sys-sms/");
		MockitoAnnotations.initMocks(this);
		final SysSmsResource sysSmsResource = new SysSmsResource(sysSmsService);
		this.restSysSmsMockMvc = MockMvcBuilders.standaloneSetup(sysSmsResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(TestUtil.createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static SysSmsDto createEntity() {
        SysSmsDto sysSmsDto = ClassUtil.createObj(SysSmsDto.class, Lists.newArrayList(
		 SysSmsDto.F_PHONENUMBER
		,SysSmsDto.F_USERID
		,SysSmsDto.F_TYPE
		,SysSmsDto.F_TEMPLATECODE
		,SysSmsDto.F_TEMPLATEPARAM
		,SysSmsDto.F_STATUS
		,SysSmsDto.F_DESCRIPTION
        ), 
        	
         DEFAULT_PHONENUMBER
	
        ,DEFAULT_USERID
	
        ,DEFAULT_TYPE
	
        ,DEFAULT_TEMPLATECODE
	
        ,DEFAULT_TEMPLATEPARAM
	
        ,DEFAULT_STATUS
	
        	
        	
        	
        	
        ,DEFAULT_DESCRIPTION
	
        	
        	);
        return sysSmsDto;
    }

    @BeforeEach
    public void initTest() {
        sysSmsDto = createEntity();
    }

    @Test
    @Transactional
    public void createSysSms() throws Exception {
        int databaseSizeBeforeCreate = sysSmsService.list().size();
        // Create the SysSms
        restSysSmsMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, SysSms.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(sysSmsDto)))
            .andExpect(status().isOk());
        ;
        // Validate the SysSms in the database
        List<SysSms> sysSmsList = sysSmsService.list(
            Wrappers.<SysSms>query().lambda().orderByAsc(
				SysSms::getCreatedDate
			)
        );
        assertThat(sysSmsList).hasSize(databaseSizeBeforeCreate + 1);
        SysSms testSysSms = sysSmsList.get(sysSmsList.size() - 1);
		assertThat(testSysSms.getPhoneNumber()).isEqualTo(DEFAULT_PHONENUMBER);
		assertThat(testSysSms.getUserId()).isEqualTo(DEFAULT_USERID);
		assertThat(testSysSms.getType()).isEqualTo(DEFAULT_TYPE);
		assertThat(testSysSms.getTemplateCode()).isEqualTo(DEFAULT_TEMPLATECODE);
		assertThat(testSysSms.getTemplateParam()).isEqualTo(DEFAULT_TEMPLATEPARAM);
		assertThat(testSysSms.getStatus()).isEqualTo(DEFAULT_STATUS);
		assertThat(testSysSms.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }

    @Test
    @Transactional
    public void checkUserIdIsRequired() throws Exception {
        int databaseSizeBeforeTest = sysSmsService.list().size();
        // set the field null
        sysSmsDto.setUserId(null);

        // Create the SysSms, which fails.

        restSysSmsMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(sysSmsDto)))
            .andExpect(status().isBadRequest());

        List<SysSms> sysSmsList = sysSmsService.list();
        assertThat(sysSmsList).hasSize(databaseSizeBeforeTest);
    }
    @Test
    @Transactional
    public void checkTemplateCodeIsRequired() throws Exception {
        int databaseSizeBeforeTest = sysSmsService.list().size();
        // set the field null
        sysSmsDto.setTemplateCode(null);

        // Create the SysSms, which fails.

        restSysSmsMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(sysSmsDto)))
            .andExpect(status().isBadRequest());

        List<SysSms> sysSmsList = sysSmsService.list();
        assertThat(sysSmsList).hasSize(databaseSizeBeforeTest);
    }


    @Test
    @Transactional
    public void getAllSysSmss() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);

        // Get all the sysSmsList
        restSysSmsMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(sysSmsDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].phoneNumber").value(hasItem(DEFAULT_PHONENUMBER.intValue())))
                    .andExpect(jsonPath("$.data.records.[*].type").value(hasItem(DEFAULT_TYPE)))
                    .andExpect(jsonPath("$.data.records.[*].templateParam").value(hasItem(DEFAULT_TEMPLATEPARAM)))
                .andExpect(jsonPath("$.data.records.[*].status").value(hasItem(DEFAULT_STATUS)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    @Test
    @Transactional
    public void getSysSms() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);

        // Get the sysSms
        restSysSmsMockMvc.perform(get(DEFAULT_API_URL+"{id}", sysSmsDto.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.id").value(sysSmsDto.getId()))
                .andExpect(jsonPath("$.data.phoneNumber").value(DEFAULT_PHONENUMBER))
                    .andExpect(jsonPath("$.data.type").value(DEFAULT_TYPE))
                    .andExpect(jsonPath("$.data.templateParam").value(DEFAULT_TEMPLATEPARAM))
                .andExpect(jsonPath("$.data.status").value(DEFAULT_STATUS))
                                .andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
            ;
    }
    @Test
    @Transactional
    public void getAllSysSmssByPhoneNumberSearch() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);

		SysSmsQueryCriteria sysSmsQueryCriteria = new SysSmsQueryCriteria();
		sysSmsQueryCriteria.setPhoneNumber(DEFAULT_PHONENUMBER);
        // Get all the sysSmsList where phoneNumber equals to DEFAULT_PHONENUMBER
        defaultSysSmsShouldBeFound(sysSmsQueryCriteria);

		sysSmsQueryCriteria.setPhoneNumber(UPDATED_PHONENUMBER);
        // Get all the sysSmsList where phoneNumber equals to UPDATED_PHONENUMBER
        defaultSysSmsShouldNotBeFound(sysSmsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllSysSmssByUserIdSearch() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);

		SysSmsQueryCriteria sysSmsQueryCriteria = new SysSmsQueryCriteria();
		sysSmsQueryCriteria.setUserId(DEFAULT_USERID);
        // Get all the sysSmsList where userId equals to DEFAULT_USERID
        defaultSysSmsShouldBeFound(sysSmsQueryCriteria);

		sysSmsQueryCriteria.setUserId(UPDATED_USERID);
        // Get all the sysSmsList where userId equals to UPDATED_USERID
        defaultSysSmsShouldNotBeFound(sysSmsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllSysSmssByTypeSearch() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);

		SysSmsQueryCriteria sysSmsQueryCriteria = new SysSmsQueryCriteria();
		sysSmsQueryCriteria.setType(DEFAULT_TYPE);
        // Get all the sysSmsList where type equals to DEFAULT_TYPE
        defaultSysSmsShouldBeFound(sysSmsQueryCriteria);

		sysSmsQueryCriteria.setType(UPDATED_TYPE);
        // Get all the sysSmsList where type equals to UPDATED_TYPE
        defaultSysSmsShouldNotBeFound(sysSmsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllSysSmssByTemplateCodeSearch() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);

		SysSmsQueryCriteria sysSmsQueryCriteria = new SysSmsQueryCriteria();
		sysSmsQueryCriteria.setTemplateCode(DEFAULT_TEMPLATECODE);
        // Get all the sysSmsList where templateCode equals to DEFAULT_TEMPLATECODE
        defaultSysSmsShouldBeFound(sysSmsQueryCriteria);

		sysSmsQueryCriteria.setTemplateCode(UPDATED_TEMPLATECODE);
        // Get all the sysSmsList where templateCode equals to UPDATED_TEMPLATECODE
        defaultSysSmsShouldNotBeFound(sysSmsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllSysSmssByTemplateParamSearch() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);

		SysSmsQueryCriteria sysSmsQueryCriteria = new SysSmsQueryCriteria();
		sysSmsQueryCriteria.setTemplateParam(DEFAULT_TEMPLATEPARAM);
        // Get all the sysSmsList where templateParam equals to DEFAULT_TEMPLATEPARAM
        defaultSysSmsShouldBeFound(sysSmsQueryCriteria);

		sysSmsQueryCriteria.setTemplateParam(UPDATED_TEMPLATEPARAM);
        // Get all the sysSmsList where templateParam equals to UPDATED_TEMPLATEPARAM
        defaultSysSmsShouldNotBeFound(sysSmsQueryCriteria);
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultSysSmsShouldBeFound(SysSmsQueryCriteria sysSmsQueryCriteria) throws Exception {
		restSysSmsMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(sysSmsQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(sysSmsDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].phoneNumber").value(hasItem(DEFAULT_PHONENUMBER.intValue())))
                    .andExpect(jsonPath("$.data.records.[*].type").value(hasItem(DEFAULT_TYPE)))
                    .andExpect(jsonPath("$.data.records.[*].templateParam").value(hasItem(DEFAULT_TEMPLATEPARAM)))
                .andExpect(jsonPath("$.data.records.[*].status").value(hasItem(DEFAULT_STATUS)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    /**
     * Executes the search, and checks that the default entity is not returned
     */
    private void defaultSysSmsShouldNotBeFound(SysSmsQueryCriteria sysSmsQueryCriteria) throws Exception {
		restSysSmsMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(sysSmsQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingSysSms() throws Exception {
        // Get the sysSms
        restSysSmsMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateSysSms() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);

        int databaseSizeBeforeUpdate = sysSmsService.list().size();

        // Update the sysSms
        SysSms updatedSysSms = sysSmsService.getById(sysSmsDto.getId());
        // Disconnect from session so that the updates on updatedSysSms are not directly saved in db
        ClassUtil.updateObj(updatedSysSms, Lists.newArrayList(
		 SysSms.F_PHONENUMBER
		,SysSms.F_USERID
		,SysSms.F_TYPE
		,SysSms.F_TEMPLATECODE
		,SysSms.F_TEMPLATEPARAM
		,SysSms.F_STATUS
		,SysSms.F_DESCRIPTION
        ), 
	
		 UPDATED_PHONENUMBER
	
		,UPDATED_USERID
	
		,UPDATED_TYPE
	
		,UPDATED_TEMPLATECODE
	
		,UPDATED_TEMPLATEPARAM
	
		,UPDATED_STATUS
	
	
	
	
	
		,UPDATED_DESCRIPTION
	
	
	);

        SysSmsDto sysSmsVo = sysSmsService.copyBeanToDto(updatedSysSms);
        restSysSmsMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(sysSmsVo)))
            .andExpect(status().isOk());

        // Validate the SysSms in the database
        List<SysSms> sysSmsList = sysSmsService.list();
        assertThat(sysSmsList).hasSize(databaseSizeBeforeUpdate);

        SysSms testSysSms = sysSmsList.stream().filter(item->sysSmsDto.getId().equals(item.getId())).findAny().get();
		assertThat(testSysSms.getPhoneNumber()).isEqualTo(UPDATED_PHONENUMBER);
		assertThat(testSysSms.getUserId()).isEqualTo(UPDATED_USERID);
		assertThat(testSysSms.getType()).isEqualTo(UPDATED_TYPE);
		assertThat(testSysSms.getTemplateCode()).isEqualTo(UPDATED_TEMPLATECODE);
		assertThat(testSysSms.getTemplateParam()).isEqualTo(UPDATED_TEMPLATEPARAM);
		assertThat(testSysSms.getStatus()).isEqualTo(UPDATED_STATUS);
		assertThat(testSysSms.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteSysSms() throws Exception {
        // Initialize the database
        sysSmsService.saveOrUpdate(sysSmsDto);
        int databaseSizeBeforeDelete = sysSmsService.list().size();

        // Get the sysSms
        restSysSmsMockMvc.perform(delete(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(sysSmsDto.getId())))
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<SysSms> sysSmsList = sysSmsService.list();
        assertThat(sysSmsList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(SysSms.class);
        SysSms sysSms1 = new SysSms();
        sysSms1.setId("id1");
        SysSms sysSms2 = new SysSms();
        sysSms2.setId(sysSms1.getId());
        assertThat(sysSms1).isEqualTo(sysSms2);
        sysSms2.setId("id2");
        assertThat(sysSms1).isNotEqualTo(sysSms2);
        sysSms1.setId(null);
        assertThat(sysSms1).isNotEqualTo(sysSms2);
    }

}