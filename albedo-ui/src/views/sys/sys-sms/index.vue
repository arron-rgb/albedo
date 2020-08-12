<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
                <el-input class="filter-item input-small" v-model="query.phoneNumber" clearable size="small" placeholder="输入phone_number搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.userId" clearable size="small" placeholder="输入开发票的userid搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.type" clearable size="small" placeholder="输入类型？搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.templateCode" clearable size="small" placeholder="输入模板代码？搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.templateParam" clearable size="small" placeholder="输入template_param搜索" @keyup.enter.native="toQuery" />
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
        <el-form-item label="phone_number" prop="phoneNumber" :rules="[{validator:validateDigits},]">
              <el-input v-model="form.phoneNumber" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="开发票的userid" prop="userId" :rules="[{required: true,message: '请输入开发票的userid', trigger: 'blur'},{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
              <el-input v-model="form.userId" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="类型？" prop="type" :rules="[{min: 0,max: 1,message: '长度在 0 到 1 个字符', trigger: 'blur'},]">
              <el-input v-model="form.type" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="模板代码？" prop="templateCode" :rules="[{required: true,message: '请输入模板代码？', trigger: 'blur'},{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.templateCode" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="template_param" prop="templateParam" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.templateParam" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="状态" prop="status" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.status" class="input-small"></el-input>
        
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
      <el-table-column align="center" label="phone_number" :show-overflow-tooltip="true" prop="phoneNumber" />
      <el-table-column align="center" label="开发票的userid" :show-overflow-tooltip="true" prop="userId" />
      <el-table-column align="center" label="类型？" :show-overflow-tooltip="true" prop="type" />
      <el-table-column align="center" label="模板代码？" :show-overflow-tooltip="true" prop="templateCode" />
      <el-table-column align="center" label="template_param" :show-overflow-tooltip="true" prop="templateParam" />
      <el-table-column align="center" label="状态" :show-overflow-tooltip="true" prop="status" />
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
import crudSysSms from '@/views/sys/sys-sms/sys-sms-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import { mapGetters } from 'vuex'

const defaultForm = {
  phoneNumber: null,
  userId: null,
  type: null,
  templateCode: null,
  templateParam: null,
  status: null,
  description: null,
}
export default {
  name: 'SysSms',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: 'sys_sms', crudMethod: { ...crudSysSms }})
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
        edit: 'sys_sysSms_edit',
        del: 'sys_sysSms_del'
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