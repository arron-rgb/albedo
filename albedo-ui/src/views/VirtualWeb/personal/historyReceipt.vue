<template>
<div class="myReceipt">
  <div class="pageTitle">
  <el-row>
    <el-col span="16">  已开发票订单</el-col>
    <el-col span="4">
<!--      <el-button type="primary" @click="addVisible = true">新增发票抬头</el-button>-->
    </el-col>
    <el-col span="4">
<!--      <el-button @click="manage">管理发票抬头</el-button>-->
    </el-col>
  </el-row>
  </div>

<!--  可开票的订单列表-->
  <el-table
    :data="list"
    stripe="true"
    :default-sort = "{prop: 'createdDate', order: 'descending'}"
    style=""
    v-loading="tableLoading"
  >
    <el-table-column
      label="创建时间"
      sortable
      prop="createdDate">
    </el-table-column>
    <el-table-column
      label="订单id"
      prop="outerId">
    </el-table-column>
    <el-table-column
      label="订单类型"
    >
      <template slot-scope="props">
        <span v-if="props.row.type === '0'">套餐订单</span>
        <span v-if="props.row.type === '1'">视频订单</span>
        <span v-if="props.row.type === '2'">语音订单</span>
      </template>
    </el-table-column>
    <el-table-column
      label="订单价格"
      sortable
      prop="totalAmount">
    </el-table-column>
    <el-table-column
      label="流水号"
      sortable
      prop="outTradeNo">
    </el-table-column>
  </el-table>

</div>

</template>

<script>
import crudInvoiceRequest from '@/views/biz/invoice-request/invoice-request-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
export default {
  name: "proDetail",
  components: {
  },
  data() {
    return {
      tableLoading :false,
      list:[],
      loading : false,
    }
  },
  created() {
    this.getHistory();
  },
  methods : {
    getHistory(){
      this.tableLoading = true;
      return new Promise((resolve, reject) => {
        crudInvoiceRequest.history().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.list = res.data;
            this.tableLoading = false;
            resolve();
          }
        }).catch(error => {
          this.tableLoading = false;
          reject(error)
        })
      })
    },
  }
}
</script>
<style lang="scss" scoped>
@import '@/common/style.scss';

.myReceipt{
  height: 100%;
  overflow-y: scroll;
    .pageTitle{
        @include pageTitle
    }
  .formRow{
    height: 30px;
    margin-bottom: 20px;
    line-height: 30px;
  }
}
.el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 100%;
}
</style>
