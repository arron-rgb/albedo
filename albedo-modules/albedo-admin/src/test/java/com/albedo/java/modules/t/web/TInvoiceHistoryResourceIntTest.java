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
import com.albedo.java.modules.t.domain.TInvoiceHistory;
import com.albedo.java.modules.t.domain.dto.TInvoiceHistoryDto;
import com.albedo.java.modules.t.domain.dto.TInvoiceHistoryQueryCriteria;
import com.albedo.java.modules.t.repository.TInvoiceHistoryRepository;
import com.albedo.java.modules.t.service.TInvoiceHistoryService;
import com.albedo.java.modules.t.web.TInvoiceHistoryResource;
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
 * Test class for the TInvoiceHistoryResource REST controller.
 *
 * @see TInvoiceHistoryResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoAdminApplication.class)
@Slf4j
public class TInvoiceHistoryResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_USERID user_id  :  用户id */
	private static final String DEFAULT_USERID = "A";
	/** UPDATED_USERID user_id  :  用户id */
    private static final String UPDATED_USERID = "B";
	/** DEFAULT_INVOICEID invoice_id  :  发票id(数量统计用后台加一下就好) */
	private static final String DEFAULT_INVOICEID = "A";
	/** UPDATED_INVOICEID invoice_id  :  发票id(数量统计用后台加一下就好) */
    private static final String UPDATED_INVOICEID = "B";
	/** DEFAULT_DESCRIPTION description  :  备注 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/** UPDATED_DESCRIPTION description  :  备注 */
    private static final String UPDATED_DESCRIPTION = "B";

    @Autowired
	private TInvoiceHistoryService tInvoiceHistoryService;

	private MockMvc restTInvoiceHistoryMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private TInvoiceHistoryDto tInvoiceHistoryDto;

	private TInvoiceHistoryDto anotherTInvoiceHistoryDto = new TInvoiceHistoryDto();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/t/t-invoice-history/");
		MockitoAnnotations.initMocks(this);
		final TInvoiceHistoryResource tInvoiceHistoryResource = new TInvoiceHistoryResource(tInvoiceHistoryService);
		this.restTInvoiceHistoryMockMvc = MockMvcBuilders.standaloneSetup(tInvoiceHistoryResource)
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
    public static TInvoiceHistoryDto createEntity() {
        TInvoiceHistoryDto tInvoiceHistoryDto = ClassUtil.createObj(TInvoiceHistoryDto.class, Lists.newArrayList(
		 TInvoiceHistoryDto.F_USERID
		,TInvoiceHistoryDto.F_INVOICEID
		,TInvoiceHistoryDto.F_DESCRIPTION
        ), 
        	
         DEFAULT_USERID
	
        ,DEFAULT_INVOICEID
	
        	
        	
        	
        	
        ,DEFAULT_DESCRIPTION
	
        	
        	);
        return tInvoiceHistoryDto;
    }

    @BeforeEach
    public void initTest() {
        tInvoiceHistoryDto = createEntity();
    }

    @Test
    @Transactional
    public void createTInvoiceHistory() throws Exception {
        int databaseSizeBeforeCreate = tInvoiceHistoryService.list().size();
        // Create the TInvoiceHistory
        restTInvoiceHistoryMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TInvoiceHistory.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tInvoiceHistoryDto)))
            .andExpect(status().isOk());
        ;
        // Validate the TInvoiceHistory in the database
        List<TInvoiceHistory> tInvoiceHistoryList = tInvoiceHistoryService.list(
            Wrappers.<TInvoiceHistory>query().lambda().orderByAsc(
				TInvoiceHistory::getCreatedDate
			)
        );
        assertThat(tInvoiceHistoryList).hasSize(databaseSizeBeforeCreate + 1);
        TInvoiceHistory testTInvoiceHistory = tInvoiceHistoryList.get(tInvoiceHistoryList.size() - 1);
		assertThat(testTInvoiceHistory.getUserId()).isEqualTo(DEFAULT_USERID);
		assertThat(testTInvoiceHistory.getInvoiceId()).isEqualTo(DEFAULT_INVOICEID);
		assertThat(testTInvoiceHistory.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }

    @Test
    @Transactional
    public void checkUserIdIsRequired() throws Exception {
        int databaseSizeBeforeTest = tInvoiceHistoryService.list().size();
        // set the field null
        tInvoiceHistoryDto.setUserId(null);

        // Create the TInvoiceHistory, which fails.

        restTInvoiceHistoryMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tInvoiceHistoryDto)))
            .andExpect(status().isBadRequest());

        List<TInvoiceHistory> tInvoiceHistoryList = tInvoiceHistoryService.list();
        assertThat(tInvoiceHistoryList).hasSize(databaseSizeBeforeTest);
    }


    @Test
    @Transactional
    public void getAllTInvoiceHistorys() throws Exception {
        // Initialize the database
        tInvoiceHistoryService.saveOrUpdate(tInvoiceHistoryDto);

        // Get all the tInvoiceHistoryList
        restTInvoiceHistoryMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tInvoiceHistoryDto.getId())))
                    .andExpect(jsonPath("$.data.records.[*].invoiceId").value(hasItem(DEFAULT_INVOICEID)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    @Test
    @Transactional
    public void getTInvoiceHistory() throws Exception {
        // Initialize the database
        tInvoiceHistoryService.saveOrUpdate(tInvoiceHistoryDto);

        // Get the tInvoiceHistory
        restTInvoiceHistoryMockMvc.perform(get(DEFAULT_API_URL+"{id}", tInvoiceHistoryDto.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.id").value(tInvoiceHistoryDto.getId()))
                    .andExpect(jsonPath("$.data.invoiceId").value(DEFAULT_INVOICEID))
                                .andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
            ;
    }
    @Test
    @Transactional
    public void getAllTInvoiceHistorysByUserIdSearch() throws Exception {
        // Initialize the database
        tInvoiceHistoryService.saveOrUpdate(tInvoiceHistoryDto);

		TInvoiceHistoryQueryCriteria tInvoiceHistoryQueryCriteria = new TInvoiceHistoryQueryCriteria();
		tInvoiceHistoryQueryCriteria.setUserId(DEFAULT_USERID);
        // Get all the tInvoiceHistoryList where userId equals to DEFAULT_USERID
        defaultTInvoiceHistoryShouldBeFound(tInvoiceHistoryQueryCriteria);

		tInvoiceHistoryQueryCriteria.setUserId(UPDATED_USERID);
        // Get all the tInvoiceHistoryList where userId equals to UPDATED_USERID
        defaultTInvoiceHistoryShouldNotBeFound(tInvoiceHistoryQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTInvoiceHistorysByInvoiceIdSearch() throws Exception {
        // Initialize the database
        tInvoiceHistoryService.saveOrUpdate(tInvoiceHistoryDto);

		TInvoiceHistoryQueryCriteria tInvoiceHistoryQueryCriteria = new TInvoiceHistoryQueryCriteria();
		tInvoiceHistoryQueryCriteria.setInvoiceId(DEFAULT_INVOICEID);
        // Get all the tInvoiceHistoryList where invoiceId equals to DEFAULT_INVOICEID
        defaultTInvoiceHistoryShouldBeFound(tInvoiceHistoryQueryCriteria);

		tInvoiceHistoryQueryCriteria.setInvoiceId(UPDATED_INVOICEID);
        // Get all the tInvoiceHistoryList where invoiceId equals to UPDATED_INVOICEID
        defaultTInvoiceHistoryShouldNotBeFound(tInvoiceHistoryQueryCriteria);
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultTInvoiceHistoryShouldBeFound(TInvoiceHistoryQueryCriteria tInvoiceHistoryQueryCriteria) throws Exception {
		restTInvoiceHistoryMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tInvoiceHistoryQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tInvoiceHistoryDto.getId())))
                    .andExpect(jsonPath("$.data.records.[*].invoiceId").value(hasItem(DEFAULT_INVOICEID)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    /**
     * Executes the search, and checks that the default entity is not returned
     */
    private void defaultTInvoiceHistoryShouldNotBeFound(TInvoiceHistoryQueryCriteria tInvoiceHistoryQueryCriteria) throws Exception {
		restTInvoiceHistoryMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tInvoiceHistoryQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingTInvoiceHistory() throws Exception {
        // Get the tInvoiceHistory
        restTInvoiceHistoryMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateTInvoiceHistory() throws Exception {
        // Initialize the database
        tInvoiceHistoryService.saveOrUpdate(tInvoiceHistoryDto);

        int databaseSizeBeforeUpdate = tInvoiceHistoryService.list().size();

        // Update the tInvoiceHistory
        TInvoiceHistory updatedTInvoiceHistory = tInvoiceHistoryService.getById(tInvoiceHistoryDto.getId());
        // Disconnect from session so that the updates on updatedTInvoiceHistory are not directly saved in db
        ClassUtil.updateObj(updatedTInvoiceHistory, Lists.newArrayList(
		 TInvoiceHistory.F_USERID
		,TInvoiceHistory.F_INVOICEID
		,TInvoiceHistory.F_DESCRIPTION
        ), 
	
		 UPDATED_USERID
	
		,UPDATED_INVOICEID
	
	
	
	
	
		,UPDATED_DESCRIPTION
	
	
	);

        TInvoiceHistoryDto tInvoiceHistoryVo = tInvoiceHistoryService.copyBeanToDto(updatedTInvoiceHistory);
        restTInvoiceHistoryMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tInvoiceHistoryVo)))
            .andExpect(status().isOk());

        // Validate the TInvoiceHistory in the database
        List<TInvoiceHistory> tInvoiceHistoryList = tInvoiceHistoryService.list();
        assertThat(tInvoiceHistoryList).hasSize(databaseSizeBeforeUpdate);

        TInvoiceHistory testTInvoiceHistory = tInvoiceHistoryList.stream().filter(item->tInvoiceHistoryDto.getId().equals(item.getId())).findAny().get();
		assertThat(testTInvoiceHistory.getUserId()).isEqualTo(UPDATED_USERID);
		assertThat(testTInvoiceHistory.getInvoiceId()).isEqualTo(UPDATED_INVOICEID);
		assertThat(testTInvoiceHistory.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteTInvoiceHistory() throws Exception {
        // Initialize the database
        tInvoiceHistoryService.saveOrUpdate(tInvoiceHistoryDto);
        int databaseSizeBeforeDelete = tInvoiceHistoryService.list().size();

        // Get the tInvoiceHistory
        restTInvoiceHistoryMockMvc.perform(delete(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(tInvoiceHistoryDto.getId())))
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TInvoiceHistory> tInvoiceHistoryList = tInvoiceHistoryService.list();
        assertThat(tInvoiceHistoryList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TInvoiceHistory.class);
        TInvoiceHistory tInvoiceHistory1 = new TInvoiceHistory();
        tInvoiceHistory1.setId("id1");
        TInvoiceHistory tInvoiceHistory2 = new TInvoiceHistory();
        tInvoiceHistory2.setId(tInvoiceHistory1.getId());
        assertThat(tInvoiceHistory1).isEqualTo(tInvoiceHistory2);
        tInvoiceHistory2.setId("id2");
        assertThat(tInvoiceHistory1).isNotEqualTo(tInvoiceHistory2);
        tInvoiceHistory1.setId(null);
        assertThat(tInvoiceHistory1).isNotEqualTo(tInvoiceHistory2);
    }

}