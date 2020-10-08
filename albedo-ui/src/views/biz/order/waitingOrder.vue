<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
<!--        <el-input class="filter-item input-small" v-model="query.staffId" clearable size="small" placeholder="输入员工id搜索"-->
<!--                  @keyup.enter.native="toQuery"/>-->
        <el-date-picker
          v-model="query.lastModifiedDate"
          :default-time="['00:00:00','23:59:59']"
          class="date-item"
          end-placeholder="结束日期"
          range-separator=":"
          size="small"
          start-placeholder="开始日期"
          type="daterange"
          value-format="yyyy-MM-dd HH:mm:ss"
        />
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
      :row-class-name="tableRowClassName"
      :default-sort = "{prop: 'lastModifiedDate', order: 'descending'}"
      @sort-change="crud.sortChange"
      @selection-change="crud.selectionChangeHandler"
    >
      <!--      <el-table-column type="selection" width="55" />-->
      <el-table-column
        align="center" label="更新时间"
        :show-overflow-tooltip="true"
        prop="lastModifiedDate"
        sortable
      />
      <el-table-column align="center" label="用户id" :show-overflow-tooltip="true" prop="userId" />
      <el-table-column align="center" label="订单状态" :show-overflow-tooltip="true">
        <template slot-scope="scope">
          <span v-if="scope.row.state === 0">未付款</span>
          <span style="color: #ff5000"  v-if="scope.row.state === 1">未接单</span>
          <span style="color: orange"  v-if="scope.row.state === 2">已接单</span>
          <span style="color: deepskyblue" v-if="scope.row.state === 3">待完善</span>
          <span style="color: pink" v-if="scope.row.state === 4">配音中</span>
          <span style="color: lightgreen" v-if="scope.row.state === 5">已完成</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="订单类型" :show-overflow-tooltip="true">
        <template slot-scope="scope">
          <span v-if="scope.row.type === '0'">视频订单</span>
          <span v-if="scope.row.type === '1'">视频订单（加速）</span>
          <span v-if="scope.row.type === '2'">配音订单</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="负责员工" :show-overflow-tooltip="true" prop="staffId" />
      <!--      <el-table-column align="center" label="视频链接" :show-overflow-tooltip="true" prop="videoId" />-->
      <!--      <el-table-column align="center" label="表单内容" :show-overflow-tooltip="true" prop="content" />-->
      <el-table-column align="center" label="订单金额" :show-overflow-tooltip="true" prop="totalAmount" />
      <el-table-column v-permission="[permission.edit,permission.del]" label="操作" width="120px" fixed="right">
        <template slot-scope="scope">
          <!--          <udOperation :data="scope.row" :permission="permission" />-->
          <el-button @click="orderDetail(scope.row)">查看详情</el-button>
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
import storeApi from "@/utils/store";

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
    return CRUD({ title: '订单管理', crudMethod: { ...crudOrder }, query: { state: 1}})
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
    // this.query.staffId = 1;
    // this.crud.toQuery;
    this.delFlagOptions = this.dicts["sys_flag"]
  },
  methods: {
    tableRowClassName({row, rowIndex}) {
      if (row.type === '1') {//加速订单
        return 'warning-row';
      } else if (row.type === '2') {//语音订单
        return 'success-row';
      }
      return '';
    },
    orderDetail(order){
      storeApi.set({
        name: 'orderData',
        content: order,
        type: 'session'
      });
      this.goTo('/order/detail')
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
  }
};
</script>
<style>
.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}
</style>
