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
import com.albedo.java.modules.t.domain.TGoods;
import com.albedo.java.modules.t.domain.dto.TGoodsDto;
import com.albedo.java.modules.t.domain.dto.TGoodsQueryCriteria;
import com.albedo.java.modules.t.repository.TGoodsRepository;
import com.albedo.java.modules.t.service.TGoodsService;
import com.albedo.java.modules.t.web.TGoodsResource;
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
 * Test class for the TGoodsResource REST controller.
 *
 * @see TGoodsResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoAdminApplication.class)
@Slf4j
public class TGoodsResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_USERID user_id  :  用户id */
	private static final String DEFAULT_USERID = "A";
	/** UPDATED_USERID user_id  :  用户id */
    private static final String UPDATED_USERID = "B";
	/** DEFAULT_NAME name  :  商品名字 */
	private static final String DEFAULT_NAME = "A";
	/** UPDATED_NAME name  :  商品名字 */
    private static final String UPDATED_NAME = "B";
	/** DEFAULT_VIDEOID video_id  :  视频id */
	private static final String DEFAULT_VIDEOID = "A";
	/** UPDATED_VIDEOID video_id  :  视频id */
    private static final String UPDATED_VIDEOID = "B";
	/** DEFAULT_VOICEURL voice_url  :  这一小段文本的音频地址 */
	private static final String DEFAULT_VOICEURL = "A";
	/** UPDATED_VOICEURL voice_url  :  这一小段文本的音频地址 */
    private static final String UPDATED_VOICEURL = "B";
	/** DEFAULT_VOICETIME voice_time  :  音频时间，单位是秒 */
	private static final Long DEFAULT_VOICETIME = 0l;
	/** UPDATED_VOICETIME voice_time  :  音频时间，单位是秒 */
    private static final Long UPDATED_VOICETIME = 1l;
	/** DEFAULT_ADWORDS ad_words  :  文本介绍 */
	private static final String DEFAULT_ADWORDS = "A";
	/** UPDATED_ADWORDS ad_words  :  文本介绍 */
    private static final String UPDATED_ADWORDS = "B";
	/** DEFAULT_TEMPLATEWORDS template_words  :  这是啥意思？ */
	private static final String DEFAULT_TEMPLATEWORDS = "A";
	/** UPDATED_TEMPLATEWORDS template_words  :  这是啥意思？ */
    private static final String UPDATED_TEMPLATEWORDS = "B";
	/** DEFAULT_PHOTOURLS photo_urls  :  多个图片，用英文逗号分开。怕太长用longtext */
	private static final String DEFAULT_PHOTOURLS = "A";
	/** UPDATED_PHOTOURLS photo_urls  :  多个图片，用英文逗号分开。怕太长用longtext */
    private static final String UPDATED_PHOTOURLS = "B";
	/** DEFAULT_DESCRIPTION description  :  备注 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/** UPDATED_DESCRIPTION description  :  备注 */
    private static final String UPDATED_DESCRIPTION = "B";

    @Autowired
	private TGoodsService tGoodsService;

	private MockMvc restTGoodsMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private TGoodsDto tGoodsDto;

	private TGoodsDto anotherTGoodsDto = new TGoodsDto();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/t/t-goods/");
		MockitoAnnotations.initMocks(this);
		final TGoodsResource tGoodsResource = new TGoodsResource(tGoodsService);
		this.restTGoodsMockMvc = MockMvcBuilders.standaloneSetup(tGoodsResource)
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
    public static TGoodsDto createEntity() {
        TGoodsDto tGoodsDto = ClassUtil.createObj(TGoodsDto.class, Lists.newArrayList(
		 TGoodsDto.F_USERID
		,TGoodsDto.F_NAME
		,TGoodsDto.F_VIDEOID
		,TGoodsDto.F_VOICEURL
		,TGoodsDto.F_VOICETIME
		,TGoodsDto.F_ADWORDS
		,TGoodsDto.F_TEMPLATEWORDS
		,TGoodsDto.F_PHOTOURLS
		,TGoodsDto.F_DESCRIPTION
        ), 
        	
         DEFAULT_USERID
	
        ,DEFAULT_NAME
	
        ,DEFAULT_VIDEOID
	
        ,DEFAULT_VOICEURL
	
        ,DEFAULT_VOICETIME
	
        ,DEFAULT_ADWORDS
	
        ,DEFAULT_TEMPLATEWORDS
	
        ,DEFAULT_PHOTOURLS
	
        	
        	
        	
        	
        ,DEFAULT_DESCRIPTION
	
        	
        	);
        return tGoodsDto;
    }

    @BeforeEach
    public void initTest() {
        tGoodsDto = createEntity();
    }

    @Test
    @Transactional
    public void createTGoods() throws Exception {
        int databaseSizeBeforeCreate = tGoodsService.list().size();
        // Create the TGoods
        restTGoodsMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TGoods.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tGoodsDto)))
            .andExpect(status().isOk());
        ;
        // Validate the TGoods in the database
        List<TGoods> tGoodsList = tGoodsService.list(
            Wrappers.<TGoods>query().lambda().orderByAsc(
				TGoods::getCreatedDate
			)
        );
        assertThat(tGoodsList).hasSize(databaseSizeBeforeCreate + 1);
        TGoods testTGoods = tGoodsList.get(tGoodsList.size() - 1);
		assertThat(testTGoods.getUserId()).isEqualTo(DEFAULT_USERID);
		assertThat(testTGoods.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testTGoods.getVideoId()).isEqualTo(DEFAULT_VIDEOID);
		assertThat(testTGoods.getVoiceUrl()).isEqualTo(DEFAULT_VOICEURL);
		assertThat(testTGoods.getVoiceTime()).isEqualTo(DEFAULT_VOICETIME);
		assertThat(testTGoods.getAdWords()).isEqualTo(DEFAULT_ADWORDS);
		assertThat(testTGoods.getTemplateWords()).isEqualTo(DEFAULT_TEMPLATEWORDS);
		assertThat(testTGoods.getPhotoUrls()).isEqualTo(DEFAULT_PHOTOURLS);
		assertThat(testTGoods.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }

    @Test
    @Transactional
    public void checkVoiceTimeIsRequired() throws Exception {
        int databaseSizeBeforeTest = tGoodsService.list().size();
        // set the field null
        tGoodsDto.setVoiceTime(null);

        // Create the TGoods, which fails.

        restTGoodsMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tGoodsDto)))
            .andExpect(status().isBadRequest());

        List<TGoods> tGoodsList = tGoodsService.list();
        assertThat(tGoodsList).hasSize(databaseSizeBeforeTest);
    }


    @Test
    @Transactional
    public void getAllTGoodss() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

        // Get all the tGoodsList
        restTGoodsMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tGoodsDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].userId").value(hasItem(DEFAULT_USERID)))
                .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
                .andExpect(jsonPath("$.data.records.[*].videoId").value(hasItem(DEFAULT_VIDEOID)))
                .andExpect(jsonPath("$.data.records.[*].voiceUrl").value(hasItem(DEFAULT_VOICEURL)))
                    .andExpect(jsonPath("$.data.records.[*].adWords").value(hasItem(DEFAULT_ADWORDS)))
                .andExpect(jsonPath("$.data.records.[*].templateWords").value(hasItem(DEFAULT_TEMPLATEWORDS)))
                .andExpect(jsonPath("$.data.records.[*].photoUrls").value(hasItem(DEFAULT_PHOTOURLS)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    @Test
    @Transactional
    public void getTGoods() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

        // Get the tGoods
        restTGoodsMockMvc.perform(get(DEFAULT_API_URL+"{id}", tGoodsDto.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.id").value(tGoodsDto.getId()))
                .andExpect(jsonPath("$.data.userId").value(DEFAULT_USERID))
                .andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
                .andExpect(jsonPath("$.data.videoId").value(DEFAULT_VIDEOID))
                .andExpect(jsonPath("$.data.voiceUrl").value(DEFAULT_VOICEURL))
                    .andExpect(jsonPath("$.data.adWords").value(DEFAULT_ADWORDS))
                .andExpect(jsonPath("$.data.templateWords").value(DEFAULT_TEMPLATEWORDS))
                .andExpect(jsonPath("$.data.photoUrls").value(DEFAULT_PHOTOURLS))
                                .andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
            ;
    }
    @Test
    @Transactional
    public void getAllTGoodssByUserIdSearch() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

		TGoodsQueryCriteria tGoodsQueryCriteria = new TGoodsQueryCriteria();
		tGoodsQueryCriteria.setUserId(DEFAULT_USERID);
        // Get all the tGoodsList where userId equals to DEFAULT_USERID
        defaultTGoodsShouldBeFound(tGoodsQueryCriteria);

		tGoodsQueryCriteria.setUserId(UPDATED_USERID);
        // Get all the tGoodsList where userId equals to UPDATED_USERID
        defaultTGoodsShouldNotBeFound(tGoodsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTGoodssByNameSearch() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

		TGoodsQueryCriteria tGoodsQueryCriteria = new TGoodsQueryCriteria();
		tGoodsQueryCriteria.setName(DEFAULT_NAME);
        // Get all the tGoodsList where name equals to DEFAULT_NAME
        defaultTGoodsShouldBeFound(tGoodsQueryCriteria);

		tGoodsQueryCriteria.setName(UPDATED_NAME);
        // Get all the tGoodsList where name equals to UPDATED_NAME
        defaultTGoodsShouldNotBeFound(tGoodsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTGoodssByVideoIdSearch() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

		TGoodsQueryCriteria tGoodsQueryCriteria = new TGoodsQueryCriteria();
		tGoodsQueryCriteria.setVideoId(DEFAULT_VIDEOID);
        // Get all the tGoodsList where videoId equals to DEFAULT_VIDEOID
        defaultTGoodsShouldBeFound(tGoodsQueryCriteria);

		tGoodsQueryCriteria.setVideoId(UPDATED_VIDEOID);
        // Get all the tGoodsList where videoId equals to UPDATED_VIDEOID
        defaultTGoodsShouldNotBeFound(tGoodsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTGoodssByVoiceUrlSearch() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

		TGoodsQueryCriteria tGoodsQueryCriteria = new TGoodsQueryCriteria();
		tGoodsQueryCriteria.setVoiceUrl(DEFAULT_VOICEURL);
        // Get all the tGoodsList where voiceUrl equals to DEFAULT_VOICEURL
        defaultTGoodsShouldBeFound(tGoodsQueryCriteria);

		tGoodsQueryCriteria.setVoiceUrl(UPDATED_VOICEURL);
        // Get all the tGoodsList where voiceUrl equals to UPDATED_VOICEURL
        defaultTGoodsShouldNotBeFound(tGoodsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTGoodssByVoiceTimeSearch() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

		TGoodsQueryCriteria tGoodsQueryCriteria = new TGoodsQueryCriteria();
		tGoodsQueryCriteria.setVoiceTime(DEFAULT_VOICETIME);
        // Get all the tGoodsList where voiceTime equals to DEFAULT_VOICETIME
        defaultTGoodsShouldBeFound(tGoodsQueryCriteria);

		tGoodsQueryCriteria.setVoiceTime(UPDATED_VOICETIME);
        // Get all the tGoodsList where voiceTime equals to UPDATED_VOICETIME
        defaultTGoodsShouldNotBeFound(tGoodsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTGoodssByAdWordsSearch() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

		TGoodsQueryCriteria tGoodsQueryCriteria = new TGoodsQueryCriteria();
		tGoodsQueryCriteria.setAdWords(DEFAULT_ADWORDS);
        // Get all the tGoodsList where adWords equals to DEFAULT_ADWORDS
        defaultTGoodsShouldBeFound(tGoodsQueryCriteria);

		tGoodsQueryCriteria.setAdWords(UPDATED_ADWORDS);
        // Get all the tGoodsList where adWords equals to UPDATED_ADWORDS
        defaultTGoodsShouldNotBeFound(tGoodsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTGoodssByTemplateWordsSearch() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

		TGoodsQueryCriteria tGoodsQueryCriteria = new TGoodsQueryCriteria();
		tGoodsQueryCriteria.setTemplateWords(DEFAULT_TEMPLATEWORDS);
        // Get all the tGoodsList where templateWords equals to DEFAULT_TEMPLATEWORDS
        defaultTGoodsShouldBeFound(tGoodsQueryCriteria);

		tGoodsQueryCriteria.setTemplateWords(UPDATED_TEMPLATEWORDS);
        // Get all the tGoodsList where templateWords equals to UPDATED_TEMPLATEWORDS
        defaultTGoodsShouldNotBeFound(tGoodsQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTGoodssByPhotoUrlsSearch() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

		TGoodsQueryCriteria tGoodsQueryCriteria = new TGoodsQueryCriteria();
		tGoodsQueryCriteria.setPhotoUrls(DEFAULT_PHOTOURLS);
        // Get all the tGoodsList where photoUrls equals to DEFAULT_PHOTOURLS
        defaultTGoodsShouldBeFound(tGoodsQueryCriteria);

		tGoodsQueryCriteria.setPhotoUrls(UPDATED_PHOTOURLS);
        // Get all the tGoodsList where photoUrls equals to UPDATED_PHOTOURLS
        defaultTGoodsShouldNotBeFound(tGoodsQueryCriteria);
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultTGoodsShouldBeFound(TGoodsQueryCriteria tGoodsQueryCriteria) throws Exception {
		restTGoodsMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tGoodsQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tGoodsDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].userId").value(hasItem(DEFAULT_USERID)))
                .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
                .andExpect(jsonPath("$.data.records.[*].videoId").value(hasItem(DEFAULT_VIDEOID)))
                .andExpect(jsonPath("$.data.records.[*].voiceUrl").value(hasItem(DEFAULT_VOICEURL)))
                    .andExpect(jsonPath("$.data.records.[*].adWords").value(hasItem(DEFAULT_ADWORDS)))
                .andExpect(jsonPath("$.data.records.[*].templateWords").value(hasItem(DEFAULT_TEMPLATEWORDS)))
                .andExpect(jsonPath("$.data.records.[*].photoUrls").value(hasItem(DEFAULT_PHOTOURLS)))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    /**
     * Executes the search, and checks that the default entity is not returned
     */
    private void defaultTGoodsShouldNotBeFound(TGoodsQueryCriteria tGoodsQueryCriteria) throws Exception {
		restTGoodsMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tGoodsQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingTGoods() throws Exception {
        // Get the tGoods
        restTGoodsMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateTGoods() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);

        int databaseSizeBeforeUpdate = tGoodsService.list().size();

        // Update the tGoods
        TGoods updatedTGoods = tGoodsService.getById(tGoodsDto.getId());
        // Disconnect from session so that the updates on updatedTGoods are not directly saved in db
        ClassUtil.updateObj(updatedTGoods, Lists.newArrayList(
		 TGoods.F_USERID
		,TGoods.F_NAME
		,TGoods.F_VIDEOID
		,TGoods.F_VOICEURL
		,TGoods.F_VOICETIME
		,TGoods.F_ADWORDS
		,TGoods.F_TEMPLATEWORDS
		,TGoods.F_PHOTOURLS
		,TGoods.F_DESCRIPTION
        ), 
	
		 UPDATED_USERID
	
		,UPDATED_NAME
	
		,UPDATED_VIDEOID
	
		,UPDATED_VOICEURL
	
		,UPDATED_VOICETIME
	
		,UPDATED_ADWORDS
	
		,UPDATED_TEMPLATEWORDS
	
		,UPDATED_PHOTOURLS
	
	
	
	
	
		,UPDATED_DESCRIPTION
	
	
	);

        TGoodsDto tGoodsVo = tGoodsService.copyBeanToDto(updatedTGoods);
        restTGoodsMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tGoodsVo)))
            .andExpect(status().isOk());

        // Validate the TGoods in the database
        List<TGoods> tGoodsList = tGoodsService.list();
        assertThat(tGoodsList).hasSize(databaseSizeBeforeUpdate);

        TGoods testTGoods = tGoodsList.stream().filter(item->tGoodsDto.getId().equals(item.getId())).findAny().get();
		assertThat(testTGoods.getUserId()).isEqualTo(UPDATED_USERID);
		assertThat(testTGoods.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testTGoods.getVideoId()).isEqualTo(UPDATED_VIDEOID);
		assertThat(testTGoods.getVoiceUrl()).isEqualTo(UPDATED_VOICEURL);
		assertThat(testTGoods.getVoiceTime()).isEqualTo(UPDATED_VOICETIME);
		assertThat(testTGoods.getAdWords()).isEqualTo(UPDATED_ADWORDS);
		assertThat(testTGoods.getTemplateWords()).isEqualTo(UPDATED_TEMPLATEWORDS);
		assertThat(testTGoods.getPhotoUrls()).isEqualTo(UPDATED_PHOTOURLS);
		assertThat(testTGoods.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteTGoods() throws Exception {
        // Initialize the database
        tGoodsService.saveOrUpdate(tGoodsDto);
        int databaseSizeBeforeDelete = tGoodsService.list().size();

        // Get the tGoods
        restTGoodsMockMvc.perform(delete(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(tGoodsDto.getId())))
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TGoods> tGoodsList = tGoodsService.list();
        assertThat(tGoodsList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TGoods.class);
        TGoods tGoods1 = new TGoods();
        tGoods1.setId("id1");
        TGoods tGoods2 = new TGoods();
        tGoods2.setId(tGoods1.getId());
        assertThat(tGoods1).isEqualTo(tGoods2);
        tGoods2.setId("id2");
        assertThat(tGoods1).isNotEqualTo(tGoods2);
        tGoods1.setId(null);
        assertThat(tGoods1).isNotEqualTo(tGoods2);
    }

}