<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
                <el-date-picker class="datetime-item" end-placeholder="结束日期" range-separator=":" size="small" start-placeholder="开始日期" type="datetimerange" v-model="query.createdDate">
          </el-date-picker>
          <el-input @keyup.enter.native="toQuery" class="filter-item input-small" clearable placeholder="输入创建时间搜索" size="small" v-model="query.createdBy" />
          <el-input @keyup.enter.native="toQuery" class="filter-item input-small" clearable placeholder="输入开票金额搜索" size="small" v-model="query.totalAmount" />
          <el-input @keyup.enter.native="toQuery" class="filter-item input-small" clearable placeholder="输入开票记录id搜索" size="small" v-model="query.recordIds" />
        <el-select @change="crud.toQuery" class="filter-item input-small" clearable placeholder="状态" size="small" v-model="query.type">
          <el-option :key="index" :value="1" label="已开" />
          <el-option :key="index" :value="0" label="未开" />
        </el-select>
        <rrOperation />
      </div>
      <crudOperation :permission="permission" />
    </div>

<!--    抬头查看-->
    <el-dialog
      :close-on-click-modal="false"

      :visible.sync="invoiceDialog"
      append-to-body
      title="查看抬头"
      width="600px"
    >
<!--      {{this.invoiceData}}-->
      <el-row class="box">
        <el-col span="6">用户类型：</el-col>
        <el-col span="18">{{this.invoiceData.type === 0 ? '个人' : '企业'}}</el-col>
      </el-row>
      <el-row class="box">
        <el-col span="6">名称：</el-col>
        <el-col span="18">{{this.invoiceData.name}}</el-col>
      </el-row>
      <el-row class="box">
        <el-col span="6">联系方式：</el-col>
        <el-col span="18">{{this.invoiceData.companyPhone}}</el-col>
      </el-row>
      <el-row class="box">
        <el-col span="6">联系地址：</el-col>
        <el-col span="18">{{this.invoiceData.companyLocation}}</el-col>
      </el-row>
      <el-row class="box" v-show="this.invoiceData.type === 1">
        <el-col span="6">税号/社会统一信用代码：</el-col>
        <el-col span="18">{{this.invoiceData.taxNum}}</el-col>
      </el-row>
      <el-row class="box" v-show="this.invoiceData.type === 1">
        <el-col span="6">银行账号：</el-col>
        <el-col span="18">{{this.invoiceData.accountNumber}}</el-col>
      </el-row>
      <el-row class="box" v-show="this.invoiceData.type === 1">
        <el-col span="6">开户银行：</el-col>
        <el-col span="18">{{this.invoiceData.accountBank}}</el-col>
      </el-row>
    </el-dialog>
	<!--Form表单-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="800px"
    >
      <el-form :inline="true" :model="form" label-width="120px" ref="form" size="small">
        <el-form-item :rules="[{required: true,message: '请输入0未开 1已开', trigger: 'change'},{min: 0,max: 1,message: '长度在 0 到 1 个字符', trigger: 'change'},]" label="0未开 1已开" prop="type">
			  <el-select class="input-small" placeholder="0未开 1已开" v-model="query.type">
			    <el-option :key="index" :label="item.label" :value="item.value" v-for="(item,index) in typeOptions" />
			  </el-select>

        </el-form-item>
      </el-form>
      <div class="dialog-footer" slot="footer">
        <el-button @click="crud.cancelCU" type="text">取消</el-button>
        <el-button :loading="crud.status.cu === 2" @click="crud.submitCU" type="primary">确认</el-button>
      </div>
    </el-dialog>
    <!--表格渲染-->
    <el-table
      :data="isInvoiceData"
      @selection-change="crud.selectionChangeHandler"
      @sort-change="crud.sortChange"
      ref="table"
      style="width: 100%;"
      v-loading="isInvoiceDataLoading"
    >
      <el-table-column type="selection" width="55" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="创建时间" prop="createdDate" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="创建的用户id" prop="createdBy" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="开票金额" prop="totalAmount" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="开票记录id" prop="recordIds" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="修改人" prop="lastModifiedBy" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="抬头">
        <template slot-scope="scope">
          <el-button @click="showInvoice(scope.row.invoiceId)">查看</el-button>
        </template>
      </el-table-column>
      <el-table-column :show-overflow-tooltip="true" align="center" label="状态" prop="type">
        <template slot-scope="scope">
          {{scope.row.type === 0 ? '未开' : '已开'}}
        </template>
      </el-table-column>
<!--      <el-table-column fixed="right" label="操作" v-permission="[permission.edit,permission.del]" width="120px">-->
<!--        <template slot-scope="scope">-->
<!--          <el-button @click="changeInvoice(scope.row)" type="primary">开票</el-button>-->
<!--&lt;!&ndash;          <udOperation :data="scope.row" :permission="permission" />&ndash;&gt;-->
<!--        </template>-->
<!--      </el-table-column>-->
    </el-table>
	<!--分页组件-->
    <pagination />
  </div>
</template>

<script>
import crudTInvoiceRequest from '@/views/biz/t-invoice-request/t-invoice-request-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import { mapGetters } from 'vuex'
import crudInvoice from "@/views/biz/invoice/invoice-service";
import {MSG_TYPE_SUCCESS} from "@/const/common";

const defaultForm = {
  type: null,
}
export default {
  name: 'TInvoiceRequest',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: '开票请求', crudMethod: { ...crudTInvoiceRequest }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    return {
      invoiceDialog : false,
      invoiceData : {},
      delFlagOptions: undefined,
      isInvoiceData : [],
      isInvoiceDataLoading : false,
	  validateNumber: (rule, value, callback) => {
	    validate.isNumber(rule, value, callback)
	  },
	  validateDigits: (rule, value, callback) => {
	    validate.isDigits(rule, value, callback)
	  },
      permission: {
        edit: 'biz_tInvoiceRequest_edit',
        del: 'biz_tInvoiceRequest_del'
      }
     }
  },
  computed: {
    ...mapGetters(["permissions","dicts","user"])
  },
  created() {
    this.getisInvoiceRequest();
    this.delFlagOptions = this.dicts["sys_flag"]
  },
  methods: {
    getisInvoiceRequest(){//获取已开票订单
      this.isInvoiceDataLoading = true;
      var params = {
        type : 1
      }
      return new Promise((resolve, reject) => {
        crudTInvoiceRequest.page(params).then(res => {
          if(res.code === MSG_TYPE_SUCCESS){
            this.isInvoiceData = res.data.records;
            this.isInvoiceDataLoading = false;
          }
          resolve(res);
        }).catch(res => {
          this.isInvoiceDataLoading = false;
          reject(res);
        })
      });
    },
    showInvoice(id){
      return new Promise((resolve, reject) => {//获取抬头信息
        crudInvoice.get(id).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            this.invoiceData = res.data;
            this.invoiceDialog = true;
          }
        }).catch(error => {
          reject(error);
        })
      });
    },
    changeInvoice(data){
      this.$alert('确定此订单发票已开并通知用户？', '提示', {
        confirmButtonText: '确定',
        callback: action => {
          this.submitData(data);
          // this.$message({
          //   type: 'info',
          //   message: `action: ${ action }`
          // });
        }
      });
    },
    submitData(data){
      var _data = data;
      _data.type = 1;
      return new Promise((resolve, reject) => {//提交更改数据请求
        crudTInvoiceRequest.save(_data).then(res => {
          resolve(res);
          // if (res.code === MSG_TYPE_SUCCESS) {
          //   this.invoiceData = res.data;
          //   this.invoiceDialog = true;
          // }
        }).catch(error => {
          reject(error);
        })
      });
    }
  }
};
</script>

<style>
.box{
  padding: 0 40px;
  text-align: left;
  line-height: 40px;
  font-size: 14px;
  border-top: 1px solid #dfe6ec;
}
.box:nth-child(2n){
  background-color: #FAFAFA;
}
</style>
