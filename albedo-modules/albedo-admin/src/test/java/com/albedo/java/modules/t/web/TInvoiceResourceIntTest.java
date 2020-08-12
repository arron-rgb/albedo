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
import com.albedo.java.modules.t.domain.TInvoice;
import com.albedo.java.modules.t.domain.dto.TInvoiceDto;
import com.albedo.java.modules.t.domain.dto.TInvoiceQueryCriteria;
import com.albedo.java.modules.t.repository.TInvoiceRepository;
import com.albedo.java.modules.t.service.TInvoiceService;
import com.albedo.java.modules.t.web.TInvoiceResource;
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
 * Test class for the TInvoiceResource REST controller.
 *
 * @see TInvoiceResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoAdminApplication.class)
@Slf4j
public class TInvoiceResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_USERID user_id  :  用户id */
	private static final String DEFAULT_USERID = "A";
	/** UPDATED_USERID user_id  :  用户id */
    private static final String UPDATED_USERID = "B";
	/** DEFAULT_TYPE type  :  0-个人，1-企业 */
	private static final String DEFAULT_TYPE = "A";
	/** UPDATED_TYPE type  :  0-个人，1-企业 */
    private static final String UPDATED_TYPE = "B";
	/** DEFAULT_NAME name  :  企业名称/个人名称 */
	private static final String DEFAULT_NAME = "A";
	/** UPDATED_NAME name  :  企业名称/个人名称 */
    private static final String UPDATED_NAME = "B";
	/** DEFAULT_TAXNUM tax_num  :  公司税号 */
	private static final String DEFAULT_TAXNUM = "A";
	/** UPDATED_TAXNUM tax_num  :  公司税号 */
    private static final String UPDATED_TAXNUM = "B";
	/** DEFAULT_COMPANYLOCATION company_location  :  注册地址 */
	private static final String DEFAULT_COMPANYLOCATION = "A";
	/** UPDATED_COMPANYLOCATION company_location  :  注册地址 */
    private static final String UPDATED_COMPANYLOCATION = "B";
	/** DEFAULT_COMPANYPHONE company_phone  :  公司电话 */
	private static final String DEFAULT_COMPANYPHONE = "A";
	/** UPDATED_COMPANYPHONE company_phone  :  公司电话 */
    private static final String UPDATED_COMPANYPHONE = "B";
	/** DEFAULT_ACCOUNTBANK account_bank  :  开户公司 */
	private static final String DEFAULT_ACCOUNTBANK = "A";
	/** UPDATED_ACCOUNTBANK account_bank  :  开户公司 */
    private static final String UPDATED_ACCOUNTBANK = "B";
	/** DEFAULT_ACCOUNTNUMBER account_number  :  开户账号 */
	private static final String DEFAULT_ACCOUNTNUMBER = "A";
	/** UPDATED_ACCOUNTNUMBER account_number  :  开户账号 */
    private static final String UPDATED_ACCOUNTNUMBER = "B";
	/** DEFAULT_DESCRIPTION description  :  备注 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/** UPDATED_DESCRIPTION description  :  备注 */
    private static final String UPDATED_DESCRIPTION = "B";

    @Autowired
	private TInvoiceService tInvoiceService;

	private MockMvc restTInvoiceMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private TInvoiceDto tInvoiceDto;

	private TInvoiceDto anotherTInvoiceDto = new TInvoiceDto();
	@BeforeEach
//	public void setup() {
//		DEFAULT_API_URL = applicationProperties.getAdminPath("/t/t-invoice/");
//		MockitoAnnotations.initMocks(this);
//		final TInvoiceResource tInvoiceResource = new TInvoiceResource(tInvoiceService);
//		this.restTInvoiceMockMvc = MockMvcBuilders.standaloneSetup(tInvoiceResource)
//			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
//			.setControllerAdvice(globalExceptionHandler)
//			.setConversionService(TestUtil.createFormattingConversionService())
//			.setMessageConverters(jacksonMessageConverter)
//			.build();
//	}

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static TInvoiceDto createEntity() {
        TInvoiceDto tInvoiceDto = ClassUtil.createObj(TInvoiceDto.class, Lists.newArrayList(
		 TInvoiceDto.F_USERID
		,TInvoiceDto.F_TYPE
		,TInvoiceDto.F_NAME
		,TInvoiceDto.F_TAXNUM
		,TInvoiceDto.F_COMPANYLOCATION
		,TInvoiceDto.F_COMPANYPHONE
		,TInvoiceDto.F_ACCOUNTBANK
		,TInvoiceDto.F_ACCOUNTNUMBER
		,TInvoiceDto.F_DESCRIPTION
        ),

         DEFAULT_USERID

        ,DEFAULT_TYPE

        ,DEFAULT_NAME

        ,DEFAULT_TAXNUM

        ,DEFAULT_COMPANYLOCATION

        ,DEFAULT_COMPANYPHONE

        ,DEFAULT_ACCOUNTBANK

        ,DEFAULT_ACCOUNTNUMBER





        ,DEFAULT_DESCRIPTION


        	);
        return tInvoiceDto;
    }

    @BeforeEach
    public void initTest() {
        tInvoiceDto = createEntity();
    }

    @Test
    @Transactional
    public void createTInvoice() throws Exception {
        int databaseSizeBeforeCreate = tInvoiceService.list().size();
        // Create the TInvoice
        restTInvoiceMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TInvoice.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tInvoiceDto)))
            .andExpect(status().isOk());
        ;
        // Validate the TInvoice in the database
        List<TInvoice> tInvoiceList = tInvoiceService.list(
            Wrappers.<TInvoice>query().lambda().orderByAsc(
				TInvoice::getCreatedDate
			)
        );
        assertThat(tInvoiceList).hasSize(databaseSizeBeforeCreate + 1);
        TInvoice testTInvoice = tInvoiceList.get(tInvoiceList.size() - 1);
		assertThat(testTInvoice.getUserId()).isEqualTo(DEFAULT_USERID);
		assertThat(testTInvoice.getType()).isEqualTo(DEFAULT_TYPE);
		assertThat(testTInvoice.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testTInvoice.getTaxNum()).isEqualTo(DEFAULT_TAXNUM);
		assertThat(testTInvoice.getCompanyLocation()).isEqualTo(DEFAULT_COMPANYLOCATION);
		assertThat(testTInvoice.getCompanyPhone()).isEqualTo(DEFAULT_COMPANYPHONE);
		assertThat(testTInvoice.getAccountBank()).isEqualTo(DEFAULT_ACCOUNTBANK);
		assertThat(testTInvoice.getAccountNumber()).isEqualTo(DEFAULT_ACCOUNTNUMBER);
		assertThat(testTInvoice.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }

    @Test
    @Transactional
    public void checkTypeIsRequired() throws Exception {
        int databaseSizeBeforeTest = tInvoiceService.list().size();
        // set the field null
        tInvoiceDto.setType(null);

        // Create the TInvoice, which fails.

        restTInvoiceMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tInvoiceDto)))
            .andExpect(status().isBadRequest());

        List<TInvoice> tInvoiceList = tInvoiceService.list();
        assertThat(tInvoiceList).hasSize(databaseSizeBeforeTest);
    }
    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = tInvoiceService.list().size();
        // set the field null
        tInvoiceDto.setName(null);

        // Create the TInvoice, which fails.

        restTInvoiceMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tInvoiceDto)))
            .andExpect(status().isBadRequest());

        List<TInvoice> tInvoiceList = tInvoiceService.list();
        assertThat(tInvoiceList).hasSize(databaseSizeBeforeTest);
    }


    @Test
    @Transactional
    public void getAllTInvoices() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

        // Get all the tInvoiceList
        restTInvoiceMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tInvoiceDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].userId").value(hasItem(DEFAULT_USERID)))
                        .andExpect(jsonPath("$.data.records.[*].taxNum").value(hasItem(DEFAULT_TAXNUM)))
                .andExpect(jsonPath("$.data.records.[*].companyLocation").value(hasItem(DEFAULT_COMPANYLOCATION)))
                .andExpect(jsonPath("$.data.records.[*].companyPhone").value(hasItem(DEFAULT_COMPANYPHONE)))
                .andExpect(jsonPath("$.data.records.[*].accountBank").value(hasItem(DEFAULT_ACCOUNTBANK)))
                .andExpect(jsonPath("$.data.records.[*].accountNumber").value(hasItem(DEFAULT_ACCOUNTNUMBER)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    @Test
    @Transactional
    public void getTInvoice() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

        // Get the tInvoice
        restTInvoiceMockMvc.perform(get(DEFAULT_API_URL+"{id}", tInvoiceDto.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.id").value(tInvoiceDto.getId()))
                .andExpect(jsonPath("$.data.userId").value(DEFAULT_USERID))
                        .andExpect(jsonPath("$.data.taxNum").value(DEFAULT_TAXNUM))
                .andExpect(jsonPath("$.data.companyLocation").value(DEFAULT_COMPANYLOCATION))
                .andExpect(jsonPath("$.data.companyPhone").value(DEFAULT_COMPANYPHONE))
                .andExpect(jsonPath("$.data.accountBank").value(DEFAULT_ACCOUNTBANK))
                .andExpect(jsonPath("$.data.accountNumber").value(DEFAULT_ACCOUNTNUMBER))
                                .andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
            ;
    }
    @Test
    @Transactional
    public void getAllTInvoicesByUserIdSearch() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

		TInvoiceQueryCriteria tInvoiceQueryCriteria = new TInvoiceQueryCriteria();
		tInvoiceQueryCriteria.setUserId(DEFAULT_USERID);
        // Get all the tInvoiceList where userId equals to DEFAULT_USERID
        defaultTInvoiceShouldBeFound(tInvoiceQueryCriteria);

		tInvoiceQueryCriteria.setUserId(UPDATED_USERID);
        // Get all the tInvoiceList where userId equals to UPDATED_USERID
        defaultTInvoiceShouldNotBeFound(tInvoiceQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTInvoicesByTypeSearch() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

		TInvoiceQueryCriteria tInvoiceQueryCriteria = new TInvoiceQueryCriteria();
		tInvoiceQueryCriteria.setType(DEFAULT_TYPE);
        // Get all the tInvoiceList where type equals to DEFAULT_TYPE
        defaultTInvoiceShouldBeFound(tInvoiceQueryCriteria);

		tInvoiceQueryCriteria.setType(UPDATED_TYPE);
        // Get all the tInvoiceList where type equals to UPDATED_TYPE
        defaultTInvoiceShouldNotBeFound(tInvoiceQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTInvoicesByNameSearch() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

		TInvoiceQueryCriteria tInvoiceQueryCriteria = new TInvoiceQueryCriteria();
		tInvoiceQueryCriteria.setName(DEFAULT_NAME);
        // Get all the tInvoiceList where name equals to DEFAULT_NAME
        defaultTInvoiceShouldBeFound(tInvoiceQueryCriteria);

		tInvoiceQueryCriteria.setName(UPDATED_NAME);
        // Get all the tInvoiceList where name equals to UPDATED_NAME
        defaultTInvoiceShouldNotBeFound(tInvoiceQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTInvoicesByTaxNumSearch() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

		TInvoiceQueryCriteria tInvoiceQueryCriteria = new TInvoiceQueryCriteria();
		tInvoiceQueryCriteria.setTaxNum(DEFAULT_TAXNUM);
        // Get all the tInvoiceList where taxNum equals to DEFAULT_TAXNUM
        defaultTInvoiceShouldBeFound(tInvoiceQueryCriteria);

		tInvoiceQueryCriteria.setTaxNum(UPDATED_TAXNUM);
        // Get all the tInvoiceList where taxNum equals to UPDATED_TAXNUM
        defaultTInvoiceShouldNotBeFound(tInvoiceQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTInvoicesByCompanyLocationSearch() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

		TInvoiceQueryCriteria tInvoiceQueryCriteria = new TInvoiceQueryCriteria();
		tInvoiceQueryCriteria.setCompanyLocation(DEFAULT_COMPANYLOCATION);
        // Get all the tInvoiceList where companyLocation equals to DEFAULT_COMPANYLOCATION
        defaultTInvoiceShouldBeFound(tInvoiceQueryCriteria);

		tInvoiceQueryCriteria.setCompanyLocation(UPDATED_COMPANYLOCATION);
        // Get all the tInvoiceList where companyLocation equals to UPDATED_COMPANYLOCATION
        defaultTInvoiceShouldNotBeFound(tInvoiceQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTInvoicesByCompanyPhoneSearch() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

		TInvoiceQueryCriteria tInvoiceQueryCriteria = new TInvoiceQueryCriteria();
		tInvoiceQueryCriteria.setCompanyPhone(DEFAULT_COMPANYPHONE);
        // Get all the tInvoiceList where companyPhone equals to DEFAULT_COMPANYPHONE
        defaultTInvoiceShouldBeFound(tInvoiceQueryCriteria);

		tInvoiceQueryCriteria.setCompanyPhone(UPDATED_COMPANYPHONE);
        // Get all the tInvoiceList where companyPhone equals to UPDATED_COMPANYPHONE
        defaultTInvoiceShouldNotBeFound(tInvoiceQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTInvoicesByAccountBankSearch() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

		TInvoiceQueryCriteria tInvoiceQueryCriteria = new TInvoiceQueryCriteria();
		tInvoiceQueryCriteria.setAccountBank(DEFAULT_ACCOUNTBANK);
        // Get all the tInvoiceList where accountBank equals to DEFAULT_ACCOUNTBANK
        defaultTInvoiceShouldBeFound(tInvoiceQueryCriteria);

		tInvoiceQueryCriteria.setAccountBank(UPDATED_ACCOUNTBANK);
        // Get all the tInvoiceList where accountBank equals to UPDATED_ACCOUNTBANK
        defaultTInvoiceShouldNotBeFound(tInvoiceQueryCriteria);
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultTInvoiceShouldBeFound(TInvoiceQueryCriteria tInvoiceQueryCriteria) throws Exception {
		restTInvoiceMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tInvoiceQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tInvoiceDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].userId").value(hasItem(DEFAULT_USERID)))
                        .andExpect(jsonPath("$.data.records.[*].taxNum").value(hasItem(DEFAULT_TAXNUM)))
                .andExpect(jsonPath("$.data.records.[*].companyLocation").value(hasItem(DEFAULT_COMPANYLOCATION)))
                .andExpect(jsonPath("$.data.records.[*].companyPhone").value(hasItem(DEFAULT_COMPANYPHONE)))
                .andExpect(jsonPath("$.data.records.[*].accountBank").value(hasItem(DEFAULT_ACCOUNTBANK)))
                .andExpect(jsonPath("$.data.records.[*].accountNumber").value(hasItem(DEFAULT_ACCOUNTNUMBER)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    /**
     * Executes the search, and checks that the default entity is not returned
     */
    private void defaultTInvoiceShouldNotBeFound(TInvoiceQueryCriteria tInvoiceQueryCriteria) throws Exception {
		restTInvoiceMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tInvoiceQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingTInvoice() throws Exception {
        // Get the tInvoice
        restTInvoiceMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateTInvoice() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);

        int databaseSizeBeforeUpdate = tInvoiceService.list().size();

        // Update the tInvoice
        TInvoice updatedTInvoice = tInvoiceService.getById(tInvoiceDto.getId());
        // Disconnect from session so that the updates on updatedTInvoice are not directly saved in db
        ClassUtil.updateObj(updatedTInvoice, Lists.newArrayList(
		 TInvoice.F_USERID
		,TInvoice.F_TYPE
		,TInvoice.F_NAME
		,TInvoice.F_TAXNUM
		,TInvoice.F_COMPANYLOCATION
		,TInvoice.F_COMPANYPHONE
		,TInvoice.F_ACCOUNTBANK
		,TInvoice.F_ACCOUNTNUMBER
		,TInvoice.F_DESCRIPTION
        ),

		 UPDATED_USERID

		,UPDATED_TYPE

		,UPDATED_NAME

		,UPDATED_TAXNUM

		,UPDATED_COMPANYLOCATION

		,UPDATED_COMPANYPHONE

		,UPDATED_ACCOUNTBANK

		,UPDATED_ACCOUNTNUMBER





		,UPDATED_DESCRIPTION


	);

        TInvoiceDto tInvoiceVo = tInvoiceService.copyBeanToDto(updatedTInvoice);
        restTInvoiceMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tInvoiceVo)))
            .andExpect(status().isOk());

        // Validate the TInvoice in the database
        List<TInvoice> tInvoiceList = tInvoiceService.list();
        assertThat(tInvoiceList).hasSize(databaseSizeBeforeUpdate);

        TInvoice testTInvoice = tInvoiceList.stream().filter(item->tInvoiceDto.getId().equals(item.getId())).findAny().get();
		assertThat(testTInvoice.getUserId()).isEqualTo(UPDATED_USERID);
		assertThat(testTInvoice.getType()).isEqualTo(UPDATED_TYPE);
		assertThat(testTInvoice.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testTInvoice.getTaxNum()).isEqualTo(UPDATED_TAXNUM);
		assertThat(testTInvoice.getCompanyLocation()).isEqualTo(UPDATED_COMPANYLOCATION);
		assertThat(testTInvoice.getCompanyPhone()).isEqualTo(UPDATED_COMPANYPHONE);
		assertThat(testTInvoice.getAccountBank()).isEqualTo(UPDATED_ACCOUNTBANK);
		assertThat(testTInvoice.getAccountNumber()).isEqualTo(UPDATED_ACCOUNTNUMBER);
		assertThat(testTInvoice.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteTInvoice() throws Exception {
        // Initialize the database
        tInvoiceService.saveOrUpdate(tInvoiceDto);
        int databaseSizeBeforeDelete = tInvoiceService.list().size();

        // Get the tInvoice
        restTInvoiceMockMvc.perform(delete(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(tInvoiceDto.getId())))
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TInvoice> tInvoiceList = tInvoiceService.list();
        assertThat(tInvoiceList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TInvoice.class);
        TInvoice tInvoice1 = new TInvoice();
        tInvoice1.setId("id1");
        TInvoice tInvoice2 = new TInvoice();
        tInvoice2.setId(tInvoice1.getId());
        assertThat(tInvoice1).isEqualTo(tInvoice2);
        tInvoice2.setId("id2");
        assertThat(tInvoice1).isNotEqualTo(tInvoice2);
        tInvoice1.setId(null);
        assertThat(tInvoice1).isNotEqualTo(tInvoice2);
    }

}
