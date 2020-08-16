<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
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
        <el-form-item :rules="[{ required: true, trigger: 'blur', message: '请选择角色'}]" label="角色" prop="items">
          <el-select
            v-model="form.items"
            multiple
            placeholder="请选择"
            style="width: 100%"
          >
            <el-option
              v-for="item in items"
              :key="item.name"
              :disabled="level !== 1 && item.level <= level"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="user_id" prop="userId"
                      :rules="[{min: 0,max: 200,message: '长度在 0 到 200 个字符', trigger: 'blur'},]">
          <el-input v-model="form.userId" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="是否站立，0站1坐" prop="anchorNum"
                      :rules="[{min: 0,max: 500,message: '长度在 0 到 500 个字符', trigger: 'blur'},]">
          <el-input v-model="form.anchorNum" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="活力青春" prop="seat" :rules="[{min: 0,max: 20,message: '长度在 0 到 20 个字符', trigger: 'blur'},]">
          <el-input v-model="form.seat" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="直播间风格" prop="anchorType"
                      :rules="[{min: 0,max: 50,message: '长度在 0 到 50 个字符', trigger: 'blur'},]">
          <el-input v-model="form.anchorType" class="input-small"></el-input>

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
      <el-table-column align="center" label="标签文本" :show-overflow-tooltip="true" prop="labels"/>
      <el-table-column align="center" label="user_id" :show-overflow-tooltip="true" prop="userId"/>
      <el-table-column align="center" label="是否站立，0站1坐" :show-overflow-tooltip="true" prop="anchorNum"/>
      <el-table-column align="center" label="活力青春" :show-overflow-tooltip="true" prop="seat"/>
      <el-table-column align="center" label="直播间风格" :show-overflow-tooltip="true" prop="anchorType"/>
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
import crudOrderForm from '@/views/biz/order-form/order-form-service'
import CRUD, {crud, form, header, presenter} from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import {mapGetters} from 'vuex'

const defaultForm = {
  labels: null,
  userId: null,
  anchorNum: null,
  seat: null,
  anchorType: null,
  items: null
}
export default {
  name: 'OrderForm',
  components: {crudOperation, rrOperation, udOperation, pagination},
  cruds() {
    return CRUD({title: 'OrderForm', crudMethod: {...crudOrderForm}})
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
        edit: 'biz_orderForm_edit',
        del: 'biz_orderForm_del'
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
