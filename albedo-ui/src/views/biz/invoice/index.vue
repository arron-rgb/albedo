<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input class="filter-item input-small" v-model="query.name" clearable size="small"
                  placeholder="输入企业名称/个人名称搜索" @keyup.enter.native="toQuery"/>
        <rrOperation/>
      </div>
      <crudOperation :permission="permission"/>
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
        <el-form-item label="企业名称/个人名称" prop="name"
                      :rules="[{required: true,message: '请输入企业名称/个人名称', trigger: 'blur'},{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
          <el-input v-model="form.name" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="公司税号" prop="taxNum" :rules="[]">
          <el-input v-model="form.taxNum" class="input-small"></el-input>
        </el-form-item>
        <el-form-item label="抬头类型" prop="type">
          <!--          // todo 改为下拉框 0为个人 1为企业-->
          <el-input v-model="form.type" class="input-small"></el-input>
        </el-form-item>

        <el-form-item label="注册地址" prop="companyLocation"
                      :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
          <el-input v-model="form.companyLocation" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="公司电话" prop="companyPhone"
                      :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
          <el-input v-model="form.companyPhone" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="开户公司" prop="accountBank"
                      :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
          <el-input v-model="form.accountBank" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="开户账号" prop="accountNumber"
                      :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
          <el-input v-model="form.accountNumber" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="备注" prop="description"
                      :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
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
      <el-table-column type="selection" width="55"/>
      <el-table-column align="center" label="企业名称/个人名称" :show-overflow-tooltip="true" prop="name"/>
      <el-table-column align="center" label="公司税号" :show-overflow-tooltip="true" prop="taxNum"/>
      <el-table-column align="center" label="注册地址" :show-overflow-tooltip="true" prop="companyLocation"/>
      <el-table-column align="center" label="公司电话" :show-overflow-tooltip="true" prop="companyPhone"/>
      <el-table-column align="center" label="开户公司" :show-overflow-tooltip="true" prop="accountBank"/>
      <el-table-column align="center" label="开户账号" :show-overflow-tooltip="true" prop="accountNumber"/>
      <el-table-column v-permission="[permission.edit,permission.del]" label="操作" width="120px" fixed="right">
        <template slot-scope="scope">
          <udOperation :data="scope.row" :permission="permission"/>
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination/>
  </div>
</template>

<script>
import crudInvoice from '@/views/biz/invoice/invoice-service'
import CRUD, {crud, form, header, presenter} from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import {mapGetters} from 'vuex'

const defaultForm = {
  name: null,
  taxNum: null,
  type: null,
  companyLocation: null,
  companyPhone: null,
  accountBank: null,
  accountNumber: null,
  description: null,
}
export default {
  name: 'Invoice',
  components: {crudOperation, rrOperation, udOperation, pagination},
  cruds() {
    return CRUD({title: '发票抬头', crudMethod: {...crudInvoice}})
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
        edit: 'biz_invoice_edit',
        del: 'biz_invoice_del'
      }
    }
  },
  computed: {
    ...mapGetters(["permissions", "dicts"])
  },
  created() {
    this.delFlagOptions = this.dicts["sys_flag"]
  },
  methods: {}
};
</script>
