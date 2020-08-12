<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
                <el-input class="filter-item input-small" v-model="query.userId" clearable size="small" placeholder="输入用户id搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.name" clearable size="small" placeholder="输入商品名字搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.videoId" clearable size="small" placeholder="输入视频id搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.voiceUrl" clearable size="small" placeholder="输入这一小段文本的音频地址搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.voiceTime" clearable size="small" placeholder="输入音频时间，单位是秒搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.adWords" clearable size="small" placeholder="输入文本介绍搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.templateWords" clearable size="small" placeholder="输入这是啥意思？搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.photoUrls" clearable size="small" placeholder="输入多个图片，用英文逗号分开。怕太长用longtext搜索" @keyup.enter.native="toQuery" />
        <rrOperation />
      </div>
      <crudOperation :permission="permission" />
    </div>
	<!--Form表单-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="800px"
    >
      <el-form ref="form" :inline="true" :model="form" label-width="120px" size="small">
        <el-form-item label="用户id" prop="userId" :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
              <el-input v-model="form.userId" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="商品名字" prop="name" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.name" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="视频id" prop="videoId" :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
              <el-input v-model="form.videoId" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="这一小段文本的音频地址" prop="voiceUrl" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.voiceUrl" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="音频时间，单位是秒" prop="voiceTime" :rules="[{required: true,message: '请输入音频时间，单位是秒', trigger: 'blur'},{validator:validateDigits},]">
              <el-input v-model="form.voiceTime" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="文本介绍" prop="adWords" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.adWords" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="这是啥意思？" prop="templateWords" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.templateWords" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="多个图片，用英文逗号分开。怕太长用longtext" prop="photoUrls" :rules="[]">
              <el-input v-model="form.photoUrls" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="备注" prop="description" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.description" class="input-small"></el-input>
        
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="text" @click="crud.cancelCU">取消</el-button>
        <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
      </div>
    </el-dialog>
    <!--表格渲染-->
    <el-table
      ref="table"
      v-loading="crud.loading"
      :data="crud.data"
      style="width: 100%;"
      @sort-change="crud.sortChange"
      @selection-change="crud.selectionChangeHandler"
    >
      <el-table-column type="selection" width="55" />
      <el-table-column align="center" label="用户id" :show-overflow-tooltip="true" prop="userId" />
      <el-table-column align="center" label="商品名字" :show-overflow-tooltip="true" prop="name" />
      <el-table-column align="center" label="视频id" :show-overflow-tooltip="true" prop="videoId" />
      <el-table-column align="center" label="这一小段文本的音频地址" :show-overflow-tooltip="true" prop="voiceUrl" />
      <el-table-column align="center" label="音频时间，单位是秒" :show-overflow-tooltip="true" prop="voiceTime" />
      <el-table-column align="center" label="文本介绍" :show-overflow-tooltip="true" prop="adWords" />
      <el-table-column align="center" label="这是啥意思？" :show-overflow-tooltip="true" prop="templateWords" />
      <el-table-column align="center" label="多个图片，用英文逗号分开。怕太长用longtext" :show-overflow-tooltip="true" prop="photoUrls" />
      <el-table-column v-permission="[permission.edit,permission.del]" label="操作" width="120px" fixed="right">
        <template slot-scope="scope">
          <udOperation :data="scope.row" :permission="permission" />
        </template>
      </el-table-column>
    </el-table>
	<!--分页组件-->
    <pagination />
  </div>
</template>

<script>
import crudTGoods from '@/views/t/t-goods/t-goods-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import { mapGetters } from 'vuex'

const defaultForm = {
  userId: null,
  name: null,
  videoId: null,
  voiceUrl: null,
  voiceTime: null,
  adWords: null,
  templateWords: null,
  photoUrls: null,
  description: null,
}
export default {
  name: 'TGoods',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: 't_goods', crudMethod: { ...crudTGoods }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    return {
      delFlagOptions: undefined,
	  validateNumber: (rule, value, callback) => {
	    validate.isNumber(rule, value, callback)
	  },
	  validateDigits: (rule, value, callback) => {
	    validate.isDigits(rule, value, callback)
	  },
      permission: {
        edit: 't_tGoods_edit',
        del: 't_tGoods_del'
      }
     }
  },
  computed: {
    ...mapGetters(["permissions","dicts"])
  },
  created() {
    this.delFlagOptions = this.dicts["sys_flag"]
  },
  methods: {

  }
};
</script>