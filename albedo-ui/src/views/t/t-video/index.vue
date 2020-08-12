<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
                <el-input class="filter-item input-small" v-model="query.name" clearable size="small" placeholder="输入视频名字搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.originUrl" clearable size="small" placeholder="输入origin_url搜索" @keyup.enter.native="toQuery" />
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
        <el-form-item label="视频名字" prop="name" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.name" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="origin_url" prop="originUrl" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.originUrl" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="logo的地址" prop="logoUrl" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.logoUrl" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="输出地址" prop="outputUrl" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.outputUrl" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="视频长度，单位是秒" prop="duration" :rules="[{validator:validateDigits},]">
              <el-input v-model="form.duration" class="input-small"></el-input>
        
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
      <el-table-column align="center" label="视频名字" :show-overflow-tooltip="true" prop="name" />
      <el-table-column align="center" label="origin_url" :show-overflow-tooltip="true" prop="originUrl" />
      <el-table-column align="center" label="logo的地址" :show-overflow-tooltip="true" prop="logoUrl" />
      <el-table-column align="center" label="输出地址" :show-overflow-tooltip="true" prop="outputUrl" />
      <el-table-column align="center" label="视频长度，单位是秒" :show-overflow-tooltip="true" prop="duration" />
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
import crudTVideo from '@/views/t/t-video/t-video-service'
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
  originUrl: null,
  logoUrl: null,
  outputUrl: null,
  duration: null,
  description: null,
}
export default {
  name: 'TVideo',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: 't_video', crudMethod: { ...crudTVideo }})
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
        edit: 't_tVideo_edit',
        del: 't_tVideo_del'
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