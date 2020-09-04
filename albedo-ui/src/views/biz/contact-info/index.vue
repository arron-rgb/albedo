<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input class="filter-item input-small" v-model="query.companyName" clearable size="small"
                  placeholder="输入企业名称搜索" @keyup.enter.native="toQuery"/>
        <el-input class="filter-item input-small" v-model="query.name" clearable size="small" placeholder="输入姓名搜索"
                  @keyup.enter.native="toQuery"/>
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
        <el-form-item label="企业名称" prop="companyName"
                      :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
          <el-input v-model="form.companyName" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="姓名" prop="name" :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
          <el-input v-model="form.name" class="input-small"></el-input>
        </el-form-item>
        <el-form-item label="手机号" prop="phone" :rules="[{min: 0,max: 20,message: '长度在 0 到 20 个字符', trigger: 'blur'},]">
          <el-input v-model="form.phone" class="input-small"></el-input>
        </el-form-item>
        <el-form-item label="处理状态" prop="status"
                      :rules="[{min: 0,max: 100,message: '长度在 0 到 100 个字符', trigger: 'blur'},]">
          <el-select v-model="form.status" placeholder="请选择">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
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
      <el-table-column align="center" label="企业名称" :show-overflow-tooltip="true" prop="companyName"/>
      <el-table-column align="center" label="姓名" :show-overflow-tooltip="true" prop="name"/>
      <el-table-column align="center" label="手机号" :show-overflow-tooltip="true" prop="phone"/>
      <el-table-column align="center" label="处理状态" :show-overflow-tooltip="true" prop="status">
        <template slot-scope="scope">
          <span>{{ scope.row.status === '0' ? '未处理' : '已处理' }}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="备注" :show-overflow-tooltip="true" prop="description"/>
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
import crudContactInfo from '@/views/biz/contact-info/contact-info-service'
import CRUD, {crud, form, header, presenter} from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import {mapGetters} from 'vuex'

const defaultForm = {
  companyName: null,
  name: null,
  phone: null,
  status: null,
  description: null,
}
export default {
  name: 'ContactInfo',
  components: {crudOperation, rrOperation, udOperation, pagination},
  cruds() {
    return CRUD({title: '联系单', crudMethod: {...crudContactInfo}})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  // todo 新增一个按钮通过update接口更新联系单状态改为已联系 或 不加
  data() {
    return {
      options: [{
        value: '0',
        label: '未处理'
      }, {
        value: '1',
        label: '已处理'
      }],
      delFlagOptions: undefined,
      validateNumber: (rule, value, callback) => {
        validate.isNumber(rule, value, callback)
      },
      validateDigits: (rule, value, callback) => {
        validate.isDigits(rule, value, callback)
      },
      permission: {
        edit: 'biz_contactInfo_edit',
        del: 'biz_contactInfo_del'
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
