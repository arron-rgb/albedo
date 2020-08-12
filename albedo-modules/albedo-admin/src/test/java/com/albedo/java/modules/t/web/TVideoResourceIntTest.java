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
import com.albedo.java.modules.t.domain.TVideo;
import com.albedo.java.modules.t.domain.dto.TVideoDto;
import com.albedo.java.modules.t.domain.dto.TVideoQueryCriteria;
import com.albedo.java.modules.t.repository.TVideoRepository;
import com.albedo.java.modules.t.service.TVideoService;
import com.albedo.java.modules.t.web.TVideoResource;
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
 * Test class for the TVideoResource REST controller.
 *
 * @see TVideoResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoAdminApplication.class)
@Slf4j
public class TVideoResourceIntTest {

    private String DEFAULT_API_URL;
	/** DEFAULT_USERID user_id  :  用户id */
	private static final String DEFAULT_USERID = "A";
	/** UPDATED_USERID user_id  :  用户id */
    private static final String UPDATED_USERID = "B";
	/** DEFAULT_NAME name  :  视频名字 */
	private static final String DEFAULT_NAME = "A";
	/** UPDATED_NAME name  :  视频名字 */
    private static final String UPDATED_NAME = "B";
	/** DEFAULT_ORIGINURL origin_url  :  origin_url */
	private static final String DEFAULT_ORIGINURL = "A";
	/** UPDATED_ORIGINURL origin_url  :  origin_url */
    private static final String UPDATED_ORIGINURL = "B";
	/** DEFAULT_LOGOURL logo_url  :  logo的地址 */
	private static final String DEFAULT_LOGOURL = "A";
	/** UPDATED_LOGOURL logo_url  :  logo的地址 */
    private static final String UPDATED_LOGOURL = "B";
	/** DEFAULT_OUTPUTURL output_url  :  输出地址 */
	private static final String DEFAULT_OUTPUTURL = "A";
	/** UPDATED_OUTPUTURL output_url  :  输出地址 */
    private static final String UPDATED_OUTPUTURL = "B";
	/** DEFAULT_DURATION duration  :  视频长度，单位是秒 */
	private static final Long DEFAULT_DURATION = 0l;
	/** UPDATED_DURATION duration  :  视频长度，单位是秒 */
    private static final Long UPDATED_DURATION = 1l;
	/** DEFAULT_DESCRIPTION description  :  备注 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/** UPDATED_DESCRIPTION description  :  备注 */
    private static final String UPDATED_DESCRIPTION = "B";

    @Autowired
	private TVideoService tVideoService;

	private MockMvc restTVideoMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private TVideoDto tVideoDto;

	private TVideoDto anotherTVideoDto = new TVideoDto();
	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/t/t-video/");
		MockitoAnnotations.initMocks(this);
		final TVideoResource tVideoResource = new TVideoResource(tVideoService);
		this.restTVideoMockMvc = MockMvcBuilders.standaloneSetup(tVideoResource)
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
    public static TVideoDto createEntity() {
        TVideoDto tVideoDto = ClassUtil.createObj(TVideoDto.class, Lists.newArrayList(
		 TVideoDto.F_USERID
		,TVideoDto.F_NAME
		,TVideoDto.F_ORIGINURL
		,TVideoDto.F_LOGOURL
		,TVideoDto.F_OUTPUTURL
		,TVideoDto.F_DURATION
		,TVideoDto.F_DESCRIPTION
        ), 
        	
         DEFAULT_USERID
	
        ,DEFAULT_NAME
	
        ,DEFAULT_ORIGINURL
	
        ,DEFAULT_LOGOURL
	
        ,DEFAULT_OUTPUTURL
	
        ,DEFAULT_DURATION
	
        	
        	
        	
        	
        ,DEFAULT_DESCRIPTION
	
        	
        	);
        return tVideoDto;
    }

    @BeforeEach
    public void initTest() {
        tVideoDto = createEntity();
    }

    @Test
    @Transactional
    public void createTVideo() throws Exception {
        int databaseSizeBeforeCreate = tVideoService.list().size();
        // Create the TVideo
        restTVideoMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, TVideo.F_SQL_CREATEDDATE)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tVideoDto)))
            .andExpect(status().isOk());
        ;
        // Validate the TVideo in the database
        List<TVideo> tVideoList = tVideoService.list(
            Wrappers.<TVideo>query().lambda().orderByAsc(
				TVideo::getCreatedDate
			)
        );
        assertThat(tVideoList).hasSize(databaseSizeBeforeCreate + 1);
        TVideo testTVideo = tVideoList.get(tVideoList.size() - 1);
		assertThat(testTVideo.getUserId()).isEqualTo(DEFAULT_USERID);
		assertThat(testTVideo.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testTVideo.getOriginUrl()).isEqualTo(DEFAULT_ORIGINURL);
		assertThat(testTVideo.getLogoUrl()).isEqualTo(DEFAULT_LOGOURL);
		assertThat(testTVideo.getOutputUrl()).isEqualTo(DEFAULT_OUTPUTURL);
		assertThat(testTVideo.getDuration()).isEqualTo(DEFAULT_DURATION);
		assertThat(testTVideo.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
    }



    @Test
    @Transactional
    public void getAllTVideos() throws Exception {
        // Initialize the database
        tVideoService.saveOrUpdate(tVideoDto);

        // Get all the tVideoList
        restTVideoMockMvc.perform(get(DEFAULT_API_URL))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tVideoDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].userId").value(hasItem(DEFAULT_USERID)))
                .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
                .andExpect(jsonPath("$.data.records.[*].originUrl").value(hasItem(DEFAULT_ORIGINURL)))
                .andExpect(jsonPath("$.data.records.[*].logoUrl").value(hasItem(DEFAULT_LOGOURL)))
                .andExpect(jsonPath("$.data.records.[*].outputUrl").value(hasItem(DEFAULT_OUTPUTURL)))
                .andExpect(jsonPath("$.data.records.[*].duration").value(hasItem(DEFAULT_DURATION.intValue())))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    @Test
    @Transactional
    public void getTVideo() throws Exception {
        // Initialize the database
        tVideoService.saveOrUpdate(tVideoDto);

        // Get the tVideo
        restTVideoMockMvc.perform(get(DEFAULT_API_URL+"{id}", tVideoDto.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.id").value(tVideoDto.getId()))
                .andExpect(jsonPath("$.data.userId").value(DEFAULT_USERID))
                .andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
                .andExpect(jsonPath("$.data.originUrl").value(DEFAULT_ORIGINURL))
                .andExpect(jsonPath("$.data.logoUrl").value(DEFAULT_LOGOURL))
                .andExpect(jsonPath("$.data.outputUrl").value(DEFAULT_OUTPUTURL))
                .andExpect(jsonPath("$.data.duration").value(DEFAULT_DURATION))
                                .andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
            ;
    }
    @Test
    @Transactional
    public void getAllTVideosByNameSearch() throws Exception {
        // Initialize the database
        tVideoService.saveOrUpdate(tVideoDto);

		TVideoQueryCriteria tVideoQueryCriteria = new TVideoQueryCriteria();
		tVideoQueryCriteria.setName(DEFAULT_NAME);
        // Get all the tVideoList where name equals to DEFAULT_NAME
        defaultTVideoShouldBeFound(tVideoQueryCriteria);

		tVideoQueryCriteria.setName(UPDATED_NAME);
        // Get all the tVideoList where name equals to UPDATED_NAME
        defaultTVideoShouldNotBeFound(tVideoQueryCriteria);
    }
    @Test
    @Transactional
    public void getAllTVideosByOriginUrlSearch() throws Exception {
        // Initialize the database
        tVideoService.saveOrUpdate(tVideoDto);

		TVideoQueryCriteria tVideoQueryCriteria = new TVideoQueryCriteria();
		tVideoQueryCriteria.setOriginUrl(DEFAULT_ORIGINURL);
        // Get all the tVideoList where originUrl equals to DEFAULT_ORIGINURL
        defaultTVideoShouldBeFound(tVideoQueryCriteria);

		tVideoQueryCriteria.setOriginUrl(UPDATED_ORIGINURL);
        // Get all the tVideoList where originUrl equals to UPDATED_ORIGINURL
        defaultTVideoShouldNotBeFound(tVideoQueryCriteria);
    }

    /**
     * Executes the search, and checks that the default entity is returned
     */
    private void defaultTVideoShouldBeFound(TVideoQueryCriteria tVideoQueryCriteria) throws Exception {
		restTVideoMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tVideoQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records.[*].id").value(hasItem(tVideoDto.getId())))
                .andExpect(jsonPath("$.data.records.[*].userId").value(hasItem(DEFAULT_USERID)))
                .andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
                .andExpect(jsonPath("$.data.records.[*].originUrl").value(hasItem(DEFAULT_ORIGINURL)))
                .andExpect(jsonPath("$.data.records.[*].logoUrl").value(hasItem(DEFAULT_LOGOURL)))
                .andExpect(jsonPath("$.data.records.[*].outputUrl").value(hasItem(DEFAULT_OUTPUTURL)))
                .andExpect(jsonPath("$.data.records.[*].duration").value(hasItem(DEFAULT_DURATION.intValue())))
                                .andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
            ;
    }

    /**
     * Executes the search, and checks that the default entity is not returned
     */
    private void defaultTVideoShouldNotBeFound(TVideoQueryCriteria tVideoQueryCriteria) throws Exception {
		restTVideoMockMvc.perform(get(DEFAULT_API_URL+"?"+TestUtil.convertObjectToUrlParams(tVideoQueryCriteria)))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.data.records").isArray())
            .andExpect(jsonPath("$.data.records").isEmpty());
    }


    @Test
    @Transactional
    public void getNonExistingTVideo() throws Exception {
        // Get the tVideo
        restTVideoMockMvc.perform(get(DEFAULT_API_URL+"{id}", Long.MAX_VALUE))
            .andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
    }

    @Test
    @Transactional
    public void updateTVideo() throws Exception {
        // Initialize the database
        tVideoService.saveOrUpdate(tVideoDto);

        int databaseSizeBeforeUpdate = tVideoService.list().size();

        // Update the tVideo
        TVideo updatedTVideo = tVideoService.getById(tVideoDto.getId());
        // Disconnect from session so that the updates on updatedTVideo are not directly saved in db
        ClassUtil.updateObj(updatedTVideo, Lists.newArrayList(
		 TVideo.F_USERID
		,TVideo.F_NAME
		,TVideo.F_ORIGINURL
		,TVideo.F_LOGOURL
		,TVideo.F_OUTPUTURL
		,TVideo.F_DURATION
		,TVideo.F_DESCRIPTION
        ), 
	
		 UPDATED_USERID
	
		,UPDATED_NAME
	
		,UPDATED_ORIGINURL
	
		,UPDATED_LOGOURL
	
		,UPDATED_OUTPUTURL
	
		,UPDATED_DURATION
	
	
	
	
	
		,UPDATED_DESCRIPTION
	
	
	);

        TVideoDto tVideoVo = tVideoService.copyBeanToDto(updatedTVideo);
        restTVideoMockMvc.perform(post(DEFAULT_API_URL)
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(tVideoVo)))
            .andExpect(status().isOk());

        // Validate the TVideo in the database
        List<TVideo> tVideoList = tVideoService.list();
        assertThat(tVideoList).hasSize(databaseSizeBeforeUpdate);

        TVideo testTVideo = tVideoList.stream().filter(item->tVideoDto.getId().equals(item.getId())).findAny().get();
		assertThat(testTVideo.getUserId()).isEqualTo(UPDATED_USERID);
		assertThat(testTVideo.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testTVideo.getOriginUrl()).isEqualTo(UPDATED_ORIGINURL);
		assertThat(testTVideo.getLogoUrl()).isEqualTo(UPDATED_LOGOURL);
		assertThat(testTVideo.getOutputUrl()).isEqualTo(UPDATED_OUTPUTURL);
		assertThat(testTVideo.getDuration()).isEqualTo(UPDATED_DURATION);
		assertThat(testTVideo.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
    }


    @Test
    @Transactional
    public void deleteTVideo() throws Exception {
        // Initialize the database
        tVideoService.saveOrUpdate(tVideoDto);
        int databaseSizeBeforeDelete = tVideoService.list().size();

        // Get the tVideo
        restTVideoMockMvc.perform(delete(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(tVideoDto.getId())))
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TVideo> tVideoList = tVideoService.list();
        assertThat(tVideoList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TVideo.class);
        TVideo tVideo1 = new TVideo();
        tVideo1.setId("id1");
        TVideo tVideo2 = new TVideo();
        tVideo2.setId(tVideo1.getId());
        assertThat(tVideo1).isEqualTo(tVideo2);
        tVideo2.setId("id2");
        assertThat(tVideo1).isNotEqualTo(tVideo2);
        tVideo1.setId(null);
        assertThat(tVideo1).isNotEqualTo(tVideo2);
    }

}