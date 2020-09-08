<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
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
        <el-form-item label="用户id" prop="userId" :rules="[{required: true,message: '请输入用户id', trigger: 'blur'},{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
              <el-input v-model="form.userId" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="订单状态，见OrderStatus" prop="state" :rules="[{validator:validateDigits},]">
              <el-input v-model="form.state" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="订单类型" prop="type" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.type" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="负责员工" prop="staffId" :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
              <el-input v-model="form.staffId" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="视频链接" prop="videoId" :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
              <el-input v-model="form.videoId" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="表单内容" prop="content" :rules="[]">
              <el-input type="textarea" v-model="form.content"></el-input>
        
        </el-form-item>
        <el-form-item label="备注" prop="description" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.description" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="订单金额" prop="totalAmount" :rules="[{ validator:validateNumber},]">
              <el-input v-model="form.totalAmount" class="input-small"></el-input>
        
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
      <el-table-column align="center" label="订单状态，见OrderStatus" :show-overflow-tooltip="true" prop="state" />
      <el-table-column align="center" label="订单类型" :show-overflow-tooltip="true" prop="type" />
      <el-table-column align="center" label="负责员工" :show-overflow-tooltip="true" prop="staffId" />
      <el-table-column align="center" label="视频链接" :show-overflow-tooltip="true" prop="videoId" />
      <el-table-column align="center" label="表单内容" :show-overflow-tooltip="true" prop="content" />
      <el-table-column align="center" label="订单金额" :show-overflow-tooltip="true" prop="totalAmount" />
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
import crudOrder from '@/views/biz/order/order-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import { mapGetters } from 'vuex'

const defaultForm = {
  userId: null,
  state: null,
  type: null,
  staffId: null,
  videoId: null,
  content: null,
  description: null,
  totalAmount: null,
}
export default {
  name: 'Order',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: '订单管理', crudMethod: { ...crudOrder }})
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
        edit: 'biz_order_edit',
        del: 'biz_order_del'
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