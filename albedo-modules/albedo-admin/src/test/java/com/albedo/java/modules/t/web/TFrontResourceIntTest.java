/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.t.web;

import cn.hutool.core.date.DateField;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.DateUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.t.domain.TFront;
import com.albedo.java.modules.t.domain.dto.TFrontDto;
import com.albedo.java.modules.t.domain.dto.TFrontQueryCriteria;
import com.albedo.java.modules.t.repository.TFrontRepository;
import com.albedo.java.modules.t.service.TFrontService;
import com.albedo.java.modules.t.web.TFrontResource;
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
 * Test class for the TFrontResource REST controller.
 *
 * @see TFrontResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoAdminApplication.class)
@Slf4j
public class TFrontResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_NAME name  :  前端页面名字 */
	private static final String DEFAULT_NAME = "A";
	/** UPDATED_NAME name  :  前端页面名字 */
    private static final String UPDATED_NAME = "B";
	/** DEFAULT_PATH path  :  前端页面地址 */
	private static final String DEFAULT_PATH = "A";
	/** UPDATED_PATH path  :  前端页面地址 */
    private static final String UPDATED_PATH = "B";
	/** DEFAULT_ADWORD ad_word  :  广告语内容 */
	private static final String DEFAULT_ADWORD = "A";
	/** UPDATED_ADWORD ad_word  :  广告语内容 */
    private static final String UPDATED_ADWORD = "B";
	/** DEFAULT_DESCRIPTION description  :  备注 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/** UPDATED_DESCRIPTION description  :  备注 */
    private static final String UPDATED_DESCRIPTION = "B";

    @Autowired
	private TFrontService tFrontService;

	private MockMvc restTFrontMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private TFrontDto tFrontDto;

	private TFrontDto anotherTFrontDto = new TFrontDto();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/t/t-front/");
		MockitoAnnotations.initMocks(this);
		final TFrontResource tFrontResource = new TFrontResource(tFrontService);
		this.restTFrontMockMvc = MockMvcBuilders.standaloneSetup(tFrontResource)
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
    public static TFrontDto createEntity() {
        TFrontDto tFrontDto = ClassUtil.createObj(TFrontDto.class, Lists.newArrayList(
		 TFrontDto.F_NAME
		,TFrontDto.F_PATH
		,TFrontDto.F_ADWORD
		,TFrontDto.F_DESCRIPTION
        ), 
        	
         DEFAULT_NAME
	
        ,DEFAULT_PATH
	
        ,DEFAULT_ADWORD
	
        	
        	
        	
        	
        ,DEFAULT_DESCRIPTION
	
        	
        	);
        return tFrontDto;
    }

    @BeforeEach
    public void initTest() {
        tFrontDto = createEntity();
    }

    @Test
    @Transactional
    public void createTFront() throws Exception {
        int databaseSizeBeforeCreate = tFrontService.list().size();
        // Create the TFront
        restTFrontMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TFront.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tFrontDto)))
            .andExpect(status().isOk());
        ;
        // Validate the TFront in the database
        List<TFront> tFrontList = tFrontService.list(
            Wrappers.<TFront>query().lambda().orderByAsc(
				TFront::getCreatedDate
			)
        );
        assertThat(tFrontList).hasSize(databaseSizeBeforeCreate + 1);
        TFront testTFront = tFrontList.get(tFrontList.size() - 1);
		assertThat(testTFront.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testTFront.getPath()).isEqualTo(DEFAULT_PATH);
		assertThat(testTFront.getAdWord()).isEqualTo(DEFAULT_ADWORD);
		assertThat(testTFront.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }



    @Test
    @Transactional
    public void getAllTFronts() throws Exception {
        // Initialize the database
        tFrontService.saveOrUpdate(tFrontDto);

        // Get all the tFrontList
        restTFrontMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tFrontDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
                .andExpect(jsonPath("$.data.records.[*].path").value(hasItem(DEFAULT_PATH)))
                .andExpect(jsonPath("$.data.records.[*].adWord").value(hasItem(DEFAULT_ADWORD)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    @Test
    @Transactional
    public void getTFront() throws Exception {
        // Initialize the database
        tFrontService.saveOrUpdate(tFrontDto);

        // Get the tFront
        restTFrontMockMvc.perform(get(DEFAULT_API_URL+"{id}", tFrontDto.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.id").value(tFrontDto.getId()))
                .andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
                .andExpect(jsonPath("$.data.path").value(DEFAULT_PATH))
                .andExpect(jsonPath("$.data.adWord").value(DEFAULT_ADWORD))
                                .andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
            ;
    }
    @Test
    @Transactional
    public void getAllTFrontsByNameSearch() throws Exception {
        // Initialize the database
        tFrontService.saveOrUpdate(tFrontDto);

		TFrontQueryCriteria tFrontQueryCriteria = new TFrontQueryCriteria();
		tFrontQueryCriteria.setName(DEFAULT_NAME);
        // Get all the tFrontList where name equals to DEFAULT_NAME
        defaultTFrontShouldBeFound(tFrontQueryCriteria);

		tFrontQueryCriteria.setName(UPDATED_NAME);
        // Get all the tFrontList where name equals to UPDATED_NAME
        defaultTFrontShouldNotBeFound(tFrontQueryCriteria);
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultTFrontShouldBeFound(TFrontQueryCriteria tFrontQueryCriteria) throws Exception {
		restTFrontMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tFrontQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tFrontDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
                .andExpect(jsonPath("$.data.records.[*].path").value(hasItem(DEFAULT_PATH)))
                .andExpect(jsonPath("$.data.records.[*].adWord").value(hasItem(DEFAULT_ADWORD)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    /**
     * Executes the search, and checks that the default entity is not returned
     */
    private void defaultTFrontShouldNotBeFound(TFrontQueryCriteria tFrontQueryCriteria) throws Exception {
		restTFrontMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tFrontQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingTFront() throws Exception {
        // Get the tFront
        restTFrontMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateTFront() throws Exception {
        // Initialize the database
        tFrontService.saveOrUpdate(tFrontDto);

        int databaseSizeBeforeUpdate = tFrontService.list().size();

        // Update the tFront
        TFront updatedTFront = tFrontService.getById(tFrontDto.getId());
        // Disconnect from session so that the updates on updatedTFront are not directly saved in db
        ClassUtil.updateObj(updatedTFront, Lists.newArrayList(
		 TFront.F_NAME
		,TFront.F_PATH
		,TFront.F_ADWORD
		,TFront.F_DESCRIPTION
        ), 
	
		 UPDATED_NAME
	
		,UPDATED_PATH
	
		,UPDATED_ADWORD
	
	
	
	
	
		,UPDATED_DESCRIPTION
	
	
	);

        TFrontDto tFrontVo = tFrontService.copyBeanToDto(updatedTFront);
        restTFrontMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tFrontVo)))
            .andExpect(status().isOk());

        // Validate the TFront in the database
        List<TFront> tFrontList = tFrontService.list();
        assertThat(tFrontList).hasSize(databaseSizeBeforeUpdate);

        TFront testTFront = tFrontList.stream().filter(item->tFrontDto.getId().equals(item.getId())).findAny().get();
		assertThat(testTFront.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testTFront.getPath()).isEqualTo(UPDATED_PATH);
		assertThat(testTFront.getAdWord()).isEqualTo(UPDATED_ADWORD);
		assertThat(testTFront.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteTFront() throws Exception {
        // Initialize the database
        tFrontService.saveOrUpdate(tFrontDto);
        int databaseSizeBeforeDelete = tFrontService.list().size();

        // Get the tFront
        restTFrontMockMvc.perform(delete(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(tFrontDto.getId())))
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TFront> tFrontList = tFrontService.list();
        assertThat(tFrontList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TFront.class);
        TFront tFront1 = new TFront();
        tFront1.setId("id1");
        TFront tFront2 = new TFront();
        tFront2.setId(tFront1.getId());
        assertThat(tFront1).isEqualTo(tFront2);
        tFront2.setId("id2");
        assertThat(tFront1).isNotEqualTo(tFront2);
        tFront1.setId(null);
        assertThat(tFront1).isNotEqualTo(tFront2);
    }

}