<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <!--      <div v-if="crud.props.searchToggle">-->
      <!--        <rrOperation />-->
      <!--      </div>-->
      <!--      <crudOperation :permission="permission" />-->
    </div>

    <!--表格渲染-->
    <el-table
      :data="data"
      :default-sort = "{prop: 'lastModifiedDate', order: 'descending'}"
      :row-class-name="tableRowClassName"
      ref="table"
      style="width: 100%;"
      v-loading=""
    >
      <!--      <el-table-column type="selection" width="55" />-->
      <el-table-column
        :show-overflow-tooltip="true" align="center"
        label="更新时间"
        prop="lastModifiedDate"
        sortable
      />
      <el-table-column :show-overflow-tooltip="true" align="center" label="用户id" prop="userId" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="订单状态">
        <template slot-scope="scope">
          <span v-if="scope.row.state === 0">未付款</span>
          <span style="color: #ff5000"  v-if="scope.row.state === 1">未接单</span>
          <span style="color: orange"  v-if="scope.row.state === 2">已接单</span>
          <span style="color: deepskyblue" v-if="scope.row.state === 3">待完善</span>
          <span style="color: pink" v-if="scope.row.state === 4">配音中</span>
          <span style="color: lightgreen" v-if="scope.row.state === 5">已完成</span>
        </template>
      </el-table-column>
      <el-table-column :show-overflow-tooltip="true" align="center" label="订单类型">
        <template slot-scope="scope">
          <span v-if="scope.row.type === '0'">视频订单</span>
          <span v-if="scope.row.type === '1'">视频订单（加速）</span>
          <span v-if="scope.row.type === '2'">配音订单</span>
        </template>
      </el-table-column>
      <el-table-column :show-overflow-tooltip="true" align="center" label="负责员工" prop="staffId" />
      <!--      <el-table-column align="center" label="视频链接" :show-overflow-tooltip="true" prop="videoId" />-->
      <!--      <el-table-column align="center" label="表单内容" :show-overflow-tooltip="true" prop="content" />-->
      <el-table-column :show-overflow-tooltip="true" align="center" label="订单金额" prop="totalAmount" />
      <el-table-column fixed="right" label="操作" width="120px">
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
import { mapGetters } from 'vuex'
import storeApi from "@/utils/store";
import {MSG_TYPE_SUCCESS} from "@/const/common";

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
  name: 'belongOrder',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: '订单管理', crudMethod: { ...crudOrder }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    return {
      data : [],
      loading : false,
      delFlagOptions: undefined,
    }
  },
  computed: {
    ...mapGetters(["permissions","dicts"])
  },
  created() {
    this.getData();
  },
  methods: {
    getData(){
      this.loading = true;
      return new Promise((resolve, reject) => {
        crudOrder.belong().then(res =>{
          if(res.code === MSG_TYPE_SUCCESS){
            this.data = res.data
          }
          resolve(res);
          this.loading = false;
        }).catch( err => {
          reject(err);
          this.loading = false;
        })
      })
    },
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
