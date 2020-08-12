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
import com.albedo.java.modules.t.domain.TOrder;
import com.albedo.java.modules.t.domain.dto.TOrderDto;
import com.albedo.java.modules.t.domain.dto.TOrderQueryCriteria;
import com.albedo.java.modules.t.repository.TOrderRepository;
import com.albedo.java.modules.t.service.TOrderService;
import com.albedo.java.modules.t.web.TOrderResource;
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
 * Test class for the TOrderResource REST controller.
 *
 * @see TOrderResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoAdminApplication.class)
@Slf4j
public class TOrderResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_USERID user_id  :  用户id */
	private static final String DEFAULT_USERID = "A";
	/** UPDATED_USERID user_id  :  用户id */
    private static final String UPDATED_USERID = "B";
	/** DEFAULT_STATUS status  :  订单状态（具体细节后面再说） */
	private static final String DEFAULT_STATUS = "A";
	/** UPDATED_STATUS status  :  订单状态（具体细节后面再说） */
    private static final String UPDATED_STATUS = "B";
	/** DEFAULT_TYPE type  :  订单类型（加速卡，单次，多次） */
	private static final String DEFAULT_TYPE = "A";
	/** UPDATED_TYPE type  :  订单类型（加速卡，单次，多次） */
    private static final String UPDATED_TYPE = "B";
	/** DEFAULT_VIDEOID video_id  :  视频id，等视频上传后更新 */
	private static final String DEFAULT_VIDEOID = "A";
	/** UPDATED_VIDEOID video_id  :  视频id，等视频上传后更新 */
    private static final String UPDATED_VIDEOID = "B";
	/** DEFAULT_TRADENO trade_no  :  支付宝订单交易号 */
	private static final String DEFAULT_TRADENO = "A";
	/** UPDATED_TRADENO trade_no  :  支付宝订单交易号 */
    private static final String UPDATED_TRADENO = "B";
	/** DEFAULT_PRICE price  :  支付金额 */
	private static final double DEFAULT_PRICE = 0;
	/** UPDATED_PRICE price  :  支付金额 */
    private static final double UPDATED_PRICE = 1;
	/** DEFAULT_USERNAME user_name  :  用户名字 */
	private static final String DEFAULT_USERNAME = "A";
	/** UPDATED_USERNAME user_name  :  用户名字 */
    private static final String UPDATED_USERNAME = "B";
	/** DEFAULT_USERPHONE user_phone  :  用户电话 */
	private static final String DEFAULT_USERPHONE = "A";
	/** UPDATED_USERPHONE user_phone  :  用户电话 */
    private static final String UPDATED_USERPHONE = "B";
	/** DEFAULT_DESCRIPTION description  :  备注 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/** UPDATED_DESCRIPTION description  :  备注 */
    private static final String UPDATED_DESCRIPTION = "B";

    @Autowired
	private TOrderService tOrderService;

	private MockMvc restTOrderMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private TOrderDto tOrderDto;

	private TOrderDto anotherTOrderDto = new TOrderDto();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/t/t-order/");
		MockitoAnnotations.initMocks(this);
		final TOrderResource tOrderResource = new TOrderResource(tOrderService);
		this.restTOrderMockMvc = MockMvcBuilders.standaloneSetup(tOrderResource)
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
    public static TOrderDto createEntity() {
        TOrderDto tOrderDto = ClassUtil.createObj(TOrderDto.class, Lists.newArrayList(
		 TOrderDto.F_USERID
		,TOrderDto.F_STATUS
		,TOrderDto.F_TYPE
		,TOrderDto.F_VIDEOID
		,TOrderDto.F_TRADENO
		,TOrderDto.F_PRICE
		,TOrderDto.F_USERNAME
		,TOrderDto.F_USERPHONE
		,TOrderDto.F_DESCRIPTION
        ), 
        	
         DEFAULT_USERID
	
        ,DEFAULT_STATUS
	
        ,DEFAULT_TYPE
	
        ,DEFAULT_VIDEOID
	
        ,DEFAULT_TRADENO
	
        ,DEFAULT_PRICE
	
        ,DEFAULT_USERNAME
	
        ,DEFAULT_USERPHONE
	
        	
        	
        	
        	
        ,DEFAULT_DESCRIPTION
	
        	
        	);
        return tOrderDto;
    }

    @BeforeEach
    public void initTest() {
        tOrderDto = createEntity();
    }

    @Test
    @Transactional
    public void createTOrder() throws Exception {
        int databaseSizeBeforeCreate = tOrderService.list().size();
        // Create the TOrder
        restTOrderMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TOrder.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tOrderDto)))
            .andExpect(status().isOk());
        ;
        // Validate the TOrder in the database
        List<TOrder> tOrderList = tOrderService.list(
            Wrappers.<TOrder>query().lambda().orderByAsc(
				TOrder::getCreatedDate
			)
        );
        assertThat(tOrderList).hasSize(databaseSizeBeforeCreate + 1);
        TOrder testTOrder = tOrderList.get(tOrderList.size() - 1);
		assertThat(testTOrder.getUserId()).isEqualTo(DEFAULT_USERID);
		assertThat(testTOrder.getStatus()).isEqualTo(DEFAULT_STATUS);
		assertThat(testTOrder.getType()).isEqualTo(DEFAULT_TYPE);
		assertThat(testTOrder.getVideoId()).isEqualTo(DEFAULT_VIDEOID);
		assertThat(testTOrder.getTradeNo()).isEqualTo(DEFAULT_TRADENO);
		assertThat(testTOrder.getPrice()).isEqualTo(DEFAULT_PRICE);
		assertThat(testTOrder.getUserName()).isEqualTo(DEFAULT_USERNAME);
		assertThat(testTOrder.getUserPhone()).isEqualTo(DEFAULT_USERPHONE);
		assertThat(testTOrder.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }

    @Test
    @Transactional
    public void checkUserIdIsRequired() throws Exception {
        int databaseSizeBeforeTest = tOrderService.list().size();
        // set the field null
        tOrderDto.setUserId(null);

        // Create the TOrder, which fails.

        restTOrderMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tOrderDto)))
            .andExpect(status().isBadRequest());

        List<TOrder> tOrderList = tOrderService.list();
        assertThat(tOrderList).hasSize(databaseSizeBeforeTest);
    }


    @Test
    @Transactional
    public void getAllTOrders() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

        // Get all the tOrderList
        restTOrderMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tOrderDto.getId())))
                    .andExpect(jsonPath("$.data.records.[*].status").value(hasItem(DEFAULT_STATUS)))
                .andExpect(jsonPath("$.data.records.[*].type").value(hasItem(DEFAULT_TYPE)))
                .andExpect(jsonPath("$.data.records.[*].videoId").value(hasItem(DEFAULT_VIDEOID)))
                .andExpect(jsonPath("$.data.records.[*].tradeNo").value(hasItem(DEFAULT_TRADENO)))
                .andExpect(jsonPath("$.data.records.[*].price").value(hasItem(DEFAULT_PRICE)))
                .andExpect(jsonPath("$.data.records.[*].userName").value(hasItem(DEFAULT_USERNAME)))
                .andExpect(jsonPath("$.data.records.[*].userPhone").value(hasItem(DEFAULT_USERPHONE)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    @Test
    @Transactional
    public void getTOrder() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

        // Get the tOrder
        restTOrderMockMvc.perform(get(DEFAULT_API_URL+"{id}", tOrderDto.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.id").value(tOrderDto.getId()))
                    .andExpect(jsonPath("$.data.status").value(DEFAULT_STATUS))
                .andExpect(jsonPath("$.data.type").value(DEFAULT_TYPE))
                .andExpect(jsonPath("$.data.videoId").value(DEFAULT_VIDEOID))
                .andExpect(jsonPath("$.data.tradeNo").value(DEFAULT_TRADENO))
                .andExpect(jsonPath("$.data.price").value(DEFAULT_PRICE))
                .andExpect(jsonPath("$.data.userName").value(DEFAULT_USERNAME))
                .andExpect(jsonPath("$.data.userPhone").value(DEFAULT_USERPHONE))
                                .andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
            ;
    }
    @Test
    @Transactional
    public void getAllTOrdersByUserIdSearch() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

		TOrderQueryCriteria tOrderQueryCriteria = new TOrderQueryCriteria();
		tOrderQueryCriteria.setUserId(DEFAULT_USERID);
        // Get all the tOrderList where userId equals to DEFAULT_USERID
        defaultTOrderShouldBeFound(tOrderQueryCriteria);

		tOrderQueryCriteria.setUserId(UPDATED_USERID);
        // Get all the tOrderList where userId equals to UPDATED_USERID
        defaultTOrderShouldNotBeFound(tOrderQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTOrdersByStatusSearch() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

		TOrderQueryCriteria tOrderQueryCriteria = new TOrderQueryCriteria();
		tOrderQueryCriteria.setStatus(DEFAULT_STATUS);
        // Get all the tOrderList where status equals to DEFAULT_STATUS
        defaultTOrderShouldBeFound(tOrderQueryCriteria);

		tOrderQueryCriteria.setStatus(UPDATED_STATUS);
        // Get all the tOrderList where status equals to UPDATED_STATUS
        defaultTOrderShouldNotBeFound(tOrderQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTOrdersByTypeSearch() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

		TOrderQueryCriteria tOrderQueryCriteria = new TOrderQueryCriteria();
		tOrderQueryCriteria.setType(DEFAULT_TYPE);
        // Get all the tOrderList where type equals to DEFAULT_TYPE
        defaultTOrderShouldBeFound(tOrderQueryCriteria);

		tOrderQueryCriteria.setType(UPDATED_TYPE);
        // Get all the tOrderList where type equals to UPDATED_TYPE
        defaultTOrderShouldNotBeFound(tOrderQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTOrdersByVideoIdSearch() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

		TOrderQueryCriteria tOrderQueryCriteria = new TOrderQueryCriteria();
		tOrderQueryCriteria.setVideoId(DEFAULT_VIDEOID);
        // Get all the tOrderList where videoId equals to DEFAULT_VIDEOID
        defaultTOrderShouldBeFound(tOrderQueryCriteria);

		tOrderQueryCriteria.setVideoId(UPDATED_VIDEOID);
        // Get all the tOrderList where videoId equals to UPDATED_VIDEOID
        defaultTOrderShouldNotBeFound(tOrderQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTOrdersByTradeNoSearch() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

		TOrderQueryCriteria tOrderQueryCriteria = new TOrderQueryCriteria();
		tOrderQueryCriteria.setTradeNo(DEFAULT_TRADENO);
        // Get all the tOrderList where tradeNo equals to DEFAULT_TRADENO
        defaultTOrderShouldBeFound(tOrderQueryCriteria);

		tOrderQueryCriteria.setTradeNo(UPDATED_TRADENO);
        // Get all the tOrderList where tradeNo equals to UPDATED_TRADENO
        defaultTOrderShouldNotBeFound(tOrderQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTOrdersByPriceSearch() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

		TOrderQueryCriteria tOrderQueryCriteria = new TOrderQueryCriteria();
		tOrderQueryCriteria.setPrice(DEFAULT_PRICE);
        // Get all the tOrderList where price equals to DEFAULT_PRICE
        defaultTOrderShouldBeFound(tOrderQueryCriteria);

		tOrderQueryCriteria.setPrice(UPDATED_PRICE);
        // Get all the tOrderList where price equals to UPDATED_PRICE
        defaultTOrderShouldNotBeFound(tOrderQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTOrdersByUserNameSearch() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

		TOrderQueryCriteria tOrderQueryCriteria = new TOrderQueryCriteria();
		tOrderQueryCriteria.setUserName(DEFAULT_USERNAME);
        // Get all the tOrderList where userName equals to DEFAULT_USERNAME
        defaultTOrderShouldBeFound(tOrderQueryCriteria);

		tOrderQueryCriteria.setUserName(UPDATED_USERNAME);
        // Get all the tOrderList where userName equals to UPDATED_USERNAME
        defaultTOrderShouldNotBeFound(tOrderQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTOrdersByUserPhoneSearch() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

		TOrderQueryCriteria tOrderQueryCriteria = new TOrderQueryCriteria();
		tOrderQueryCriteria.setUserPhone(DEFAULT_USERPHONE);
        // Get all the tOrderList where userPhone equals to DEFAULT_USERPHONE
        defaultTOrderShouldBeFound(tOrderQueryCriteria);

		tOrderQueryCriteria.setUserPhone(UPDATED_USERPHONE);
        // Get all the tOrderList where userPhone equals to UPDATED_USERPHONE
        defaultTOrderShouldNotBeFound(tOrderQueryCriteria);
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultTOrderShouldBeFound(TOrderQueryCriteria tOrderQueryCriteria) throws Exception {
		restTOrderMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tOrderQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tOrderDto.getId())))
                    .andExpect(jsonPath("$.data.records.[*].status").value(hasItem(DEFAULT_STATUS)))
                .andExpect(jsonPath("$.data.records.[*].type").value(hasItem(DEFAULT_TYPE)))
                .andExpect(jsonPath("$.data.records.[*].videoId").value(hasItem(DEFAULT_VIDEOID)))
                .andExpect(jsonPath("$.data.records.[*].tradeNo").value(hasItem(DEFAULT_TRADENO)))
                .andExpect(jsonPath("$.data.records.[*].price").value(hasItem(DEFAULT_PRICE)))
                .andExpect(jsonPath("$.data.records.[*].userName").value(hasItem(DEFAULT_USERNAME)))
                .andExpect(jsonPath("$.data.records.[*].userPhone").value(hasItem(DEFAULT_USERPHONE)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    /**
     * Executes the search, and checks that the default entity is not returned
     */
    private void defaultTOrderShouldNotBeFound(TOrderQueryCriteria tOrderQueryCriteria) throws Exception {
		restTOrderMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tOrderQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingTOrder() throws Exception {
        // Get the tOrder
        restTOrderMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateTOrder() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);

        int databaseSizeBeforeUpdate = tOrderService.list().size();

        // Update the tOrder
        TOrder updatedTOrder = tOrderService.getById(tOrderDto.getId());
        // Disconnect from session so that the updates on updatedTOrder are not directly saved in db
        ClassUtil.updateObj(updatedTOrder, Lists.newArrayList(
		 TOrder.F_USERID
		,TOrder.F_STATUS
		,TOrder.F_TYPE
		,TOrder.F_VIDEOID
		,TOrder.F_TRADENO
		,TOrder.F_PRICE
		,TOrder.F_USERNAME
		,TOrder.F_USERPHONE
		,TOrder.F_DESCRIPTION
        ), 
	
		 UPDATED_USERID
	
		,UPDATED_STATUS
	
		,UPDATED_TYPE
	
		,UPDATED_VIDEOID
	
		,UPDATED_TRADENO
	
		,UPDATED_PRICE
	
		,UPDATED_USERNAME
	
		,UPDATED_USERPHONE
	
	
	
	
	
		,UPDATED_DESCRIPTION
	
	
	);

        TOrderDto tOrderVo = tOrderService.copyBeanToDto(updatedTOrder);
        restTOrderMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tOrderVo)))
            .andExpect(status().isOk());

        // Validate the TOrder in the database
        List<TOrder> tOrderList = tOrderService.list();
        assertThat(tOrderList).hasSize(databaseSizeBeforeUpdate);

        TOrder testTOrder = tOrderList.stream().filter(item->tOrderDto.getId().equals(item.getId())).findAny().get();
		assertThat(testTOrder.getUserId()).isEqualTo(UPDATED_USERID);
		assertThat(testTOrder.getStatus()).isEqualTo(UPDATED_STATUS);
		assertThat(testTOrder.getType()).isEqualTo(UPDATED_TYPE);
		assertThat(testTOrder.getVideoId()).isEqualTo(UPDATED_VIDEOID);
		assertThat(testTOrder.getTradeNo()).isEqualTo(UPDATED_TRADENO);
		assertThat(testTOrder.getPrice()).isEqualTo(UPDATED_PRICE);
		assertThat(testTOrder.getUserName()).isEqualTo(UPDATED_USERNAME);
		assertThat(testTOrder.getUserPhone()).isEqualTo(UPDATED_USERPHONE);
		assertThat(testTOrder.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteTOrder() throws Exception {
        // Initialize the database
        tOrderService.saveOrUpdate(tOrderDto);
        int databaseSizeBeforeDelete = tOrderService.list().size();

        // Get the tOrder
        restTOrderMockMvc.perform(delete(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(tOrderDto.getId())))
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TOrder> tOrderList = tOrderService.list();
        assertThat(tOrderList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TOrder.class);
        TOrder tOrder1 = new TOrder();
        tOrder1.setId("id1");
        TOrder tOrder2 = new TOrder();
        tOrder2.setId(tOrder1.getId());
        assertThat(tOrder1).isEqualTo(tOrder2);
        tOrder2.setId("id2");
        assertThat(tOrder1).isNotEqualTo(tOrder2);
        tOrder1.setId(null);
        assertThat(tOrder1).isNotEqualTo(tOrder2);
    }

}