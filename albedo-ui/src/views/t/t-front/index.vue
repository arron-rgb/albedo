<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
                <el-input class="filter-item input-small" v-model="query.name" clearable size="small" placeholder="输入前端页面名字搜索" @keyup.enter.native="toQuery" />
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
        <el-form-item label="前端页面名字" prop="name" :rules="[{min: 0,max: 64,message: '长度在 0 到 64 个字符', trigger: 'blur'},]">
              <el-input v-model="form.name" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="前端页面地址" prop="path" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.path" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="广告语内容" prop="adWord" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.adWord" class="input-small"></el-input>
        
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
      <el-table-column align="center" label="前端页面名字" :show-overflow-tooltip="true" prop="name" />
      <el-table-column align="center" label="前端页面地址" :show-overflow-tooltip="true" prop="path" />
      <el-table-column align="center" label="广告语内容" :show-overflow-tooltip="true" prop="adWord" />
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
import crudTFront from '@/views/t/t-front/t-front-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import { mapGetters } from 'vuex'

const defaultForm = {
  name: null,
  path: null,
  adWord: null,
  description: null,
}
export default {
  name: 'TFront',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: 't_front', crudMethod: { ...crudTFront }})
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
        edit: 't_tFront_edit',
        del: 't_tFront_del'
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