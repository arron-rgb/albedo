<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
                <el-input class="filter-item input-small" v-model="query.userId" clearable size="small" placeholder="输入用户id搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.status" clearable size="small" placeholder="输入订单状态（具体细节后面再说）搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.type" clearable size="small" placeholder="输入订单类型（加速卡，单次，多次）搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.videoId" clearable size="small" placeholder="输入视频id，等视频上传后更新搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.tradeNo" clearable size="small" placeholder="输入支付宝订单交易号搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.price" clearable size="small" placeholder="输入支付金额搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.userName" clearable size="small" placeholder="输入用户名字搜索" @keyup.enter.native="toQuery" />
          <el-input class="filter-item input-small" v-model="query.userPhone" clearable size="small" placeholder="输入用户电话搜索" @keyup.enter.native="toQuery" />
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
        <el-form-item label="订单状态（具体细节后面再说）" prop="status" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.status" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="订单类型（加速卡，单次，多次）" prop="type" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.type" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="视频id，等视频上传后更新" prop="videoId" :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
              <el-input v-model="form.videoId" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="支付宝订单交易号" prop="tradeNo" :rules="[{min: 0,max: 50,message: '长度在 0 到 50 个字符', trigger: 'blur'},]">
              <el-input v-model="form.tradeNo" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="支付金额" prop="price" :rules="[{ validator:validateNumber},]">
              <el-input v-model="form.price" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="用户名字" prop="userName" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.userName" class="input-small"></el-input>
        
        </el-form-item>
        <el-form-item label="用户电话" prop="userPhone" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
              <el-input v-model="form.userPhone" class="input-small"></el-input>
        
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
      <el-table-column align="center" label="订单状态（具体细节后面再说）" :show-overflow-tooltip="true" prop="status" />
      <el-table-column align="center" label="订单类型（加速卡，单次，多次）" :show-overflow-tooltip="true" prop="type" />
      <el-table-column align="center" label="视频id，等视频上传后更新" :show-overflow-tooltip="true" prop="videoId" />
      <el-table-column align="center" label="支付宝订单交易号" :show-overflow-tooltip="true" prop="tradeNo" />
      <el-table-column align="center" label="支付金额" :show-overflow-tooltip="true" prop="price" />
      <el-table-column align="center" label="用户名字" :show-overflow-tooltip="true" prop="userName" />
      <el-table-column align="center" label="用户电话" :show-overflow-tooltip="true" prop="userPhone" />
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
import crudTOrder from '@/views/t/t-order/t-order-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import { mapGetters } from 'vuex'

const defaultForm = {
  userId: null,
  status: null,
  type: null,
  videoId: null,
  tradeNo: null,
  price: null,
  userName: null,
  userPhone: null,
  description: null,
}
export default {
  name: 'TOrder',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: 't_order', crudMethod: { ...crudTOrder }})
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
        edit: 't_tOrder_edit',
        del: 't_tOrder_del'
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