<template>
<div class="myReceipt">
  <div class="pageTitle">
  <el-row>
    <el-col span="16">  可开发票订单</el-col>
    <el-col span="4">
      <el-button type="primary" @click="addVisible = true">新增发票抬头</el-button>
    </el-col>
    <el-col span="4">
      <el-button @click="manage">管理发票抬头</el-button>
    </el-col>
  </el-row>
  </div>

  <el-dialog
    title="新增抬头"
    :visible.sync="addVisible"
    width="800px"
    style="padding: 0"
  >

    <el-row class="formRow">
      <el-col offset="6" span="18" style="text-align: left">
        <el-radio v-model="invoiceData.type" label="0">个人</el-radio>
        <el-radio v-model="invoiceData.type" label="1">公司</el-radio>
      </el-col>
    </el-row>

    <el-row class="formRow">
      <el-col span="6">
        <span>抬头名称（必填）：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.name"
        ></el-input>
      </el-col>
    </el-row>

    <el-row class="formRow">
      <el-col span="6">
        <span>邮箱地址（必填）：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.email"
        ></el-input>
      </el-col>
    </el-row>

    <el-row class="formRow" v-if="invoiceData.type === '1'">
      <el-col span="6">
        <span>社会统一信用代码：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.taxNum"
        ></el-input>
      </el-col>
    </el-row>

    <el-row class="formRow" v-if="invoiceData.type === '1'">
      <el-col span="6">
        <span>银行账户：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.accountNumber"
        ></el-input>
      </el-col>
    </el-row>

    <el-row class="formRow" v-if="invoiceData.type === '1'">
      <el-col span="6">
        <span>开户银行：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.accountBank"
        ></el-input>
      </el-col>
    </el-row>

    <el-row class="formRow">
      <el-col span="6">
        <span>联系方式：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.companyPhone"
        ></el-input>
      </el-col>
    </el-row>

    <el-row class="formRow">
      <el-col span="6">
        <span>联系地址：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.companyLocation"
        ></el-input>
      </el-col>
    </el-row>

    <el-button :loading="loading" type="primary" @click="toSave">保存</el-button>
  </el-dialog>
  <el-dialog
    title="抬头列表"
    :visible.sync="selectVisible"
    width="900px"
    style="padding: 0;"
  >
    <el-table
      :data="invoiceList"
      stripe="true"
      v-loading="tableLoading"
      :default-sort = "{prop: 'createdDate', order: 'descending'}"
      style="overflow-y: scroll;height: 500px"
    >
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-form label-position="left" inline class="demo-table-expand">
            <el-form-item label="联系方式">
              <span>{{ props.row.companyPhone === "" ? '未填写' : props.row.companyPhone }}</span>
            </el-form-item>
            <el-form-item label="联系地址">
              <span>{{ props.row.companyLocation === "" ? '未填写' : props.row.companyLocation }}</span>
            </el-form-item>
            <el-form-item label="银行账号">
              <span>{{ props.row.accountNumber === "" ? '未填写' : props.row.accountNumber }}</span>
            </el-form-item>
            <el-form-item label="开户银行">
              <span>{{ props.row.accountBank === "" ? '未填写' : props.row.accountBank }}</span>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column
        label="创建时间"
        sortable
        prop="createdDate">
      </el-table-column>
      <el-table-column
        label="发票类型"
      >
        <template slot-scope="props">
          <span v-if="props.row.type === 0">个人</span>
          <span v-if="props.row.type === 1">企业</span>
        </template>
      </el-table-column>
      <el-table-column
        label="抬头名称"
        sortable
        prop="name">
      </el-table-column>
      <el-table-column
        label="邮箱地址"
        sortable
        prop="email">
      </el-table-column>
      <el-table-column
        label="社会统一信用代码"
        prop="taxNum">
      </el-table-column>
      <el-table-column
        label="操作">
        <template slot-scope="props">

          <el-button v-if="manageInvoice" slot="reference" :loading="delLoading" type="primary" @click="delInvoice(props.row.id)">删除</el-button>

          <el-button v-if="!manageInvoice" :loading="loading" type="primary" @click="invoiceRequest(props.row.id)">选择</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-dialog>

<!--  可开票的订单列表-->
  <el-table
    :data="purchaseList"
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
    <el-table-column
      label="操作">
      <template slot-scope="props">
        <el-button type="primary" @click="toInvoice(props.row.id)">开票</el-button>
      </template>
    </el-table-column>
  </el-table>

</div>

</template>

<script>
import crudInvoice from '@/views/biz/invoice/invoice-service'
import crudInvoiceRequest from '@/views/biz/t-invoice-request/t-invoice-request-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
export default {
  name: "proDetail",
  components: {
  },
  data() {
    return {
      tableLoading :false,
      addVisible : false,
      selectVisible: false,
      manageInvoice: true,
      invoiceData: {
        accountBank: "",//开户行
        accountNumber: "",//银行账号
        companyLocation: "",//公司地址
        companyPhone: "",//公司电话
        description: "",
        email: "",
        name: "",//抬头名称
        type : '0',//0-个人，1-企业
        taxNum: "",//纳税人识别号\社会统一信用代码
      },
      invoiceList:[],
      purchaseList:[],
      loading : false,
      delLoading: false,
      recordId : null,
    }
  },
  created() {
    this.getPurchaseList();
  },
  methods : {
    toSave(){
      this.loading = true;
      if(this.invoiceData.name === ""){//检查抬头名称
        this.$alert('抬头名称不能为空！', '警告', {
          confirmButtonText: '确定',
        });
        this.loading = false;
        return ;
      }
      if(this.invoiceData.type === "0"){
        this.saveInvoice(this.invoiceData);//保存抬头
      }
      else{
        if(this.invoiceData.taxNum === ""){//企业发票，检查社会统一信用代码
          this.$alert('社会统一信用代码不能为空！', '警告', {
            confirmButtonText: '确定',
          });
          this.loading = false;
        }
        else{
          this.saveInvoice(this.invoiceData);
        }
      }
    },
    saveInvoice(data){//保存抬头
      return new Promise((resolve, reject) => {
        crudInvoice.save(data).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.loading = false;
            this.addVisible = false;
            var newInvoiceData = {
              accountBank: "",//开户行
                accountNumber: "",//银行账号
                companyLocation: "",//公司地址
                companyPhone: "",//公司电话
                description: "",
                name: "",//抬头名称
                type : '0',//0-个人，1-企业
                taxNum: "",//纳税人识别号\社会统一信用代码
                email: ""//邮箱地址
            };
            this.invoiceData = newInvoiceData; // 将数据清空
            resolve();
          }
        }).catch(error => {
          this.loading = false;
          reject(error)
        })
      })
    },
    getInvoiceList(){
      this.tableLoading = true;
      return new Promise((resolve, reject) => {
        crudInvoice.list().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.invoiceList = res.data;
            this.tableLoading = false;
            resolve();
          }
        }).catch(error => {
          this.tableLoading = false;
          reject(error)
        })
      })
    },
    getPurchaseList(){
      this.tableLoading = true;
      return new Promise((resolve, reject) => {
        crudInvoiceRequest.list().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res);
            this.purchaseList = res.data;
            this.tableLoading = false;
            resolve();
          }
        }).catch(error => {
          this.tableLoading = false;
          reject(error)
        })
      })
    },
    toInvoice(recordId){//保存开票id
      this.recordId = recordId;
      this.manageInvoice = false;//不是管理发票
      this.getInvoiceList();//获取最新的抬头列表
      this.selectVisible = true;
    },
    invoiceRequest(id){//提交开发票请求
      this.loading = true;
      var data = {
        "invoiceId": id,
        "recordIds": [this.recordId]
      }
      // console.log(data)
      return new Promise((resolve, reject) => {
        crudInvoiceRequest.requestInvoice(data).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            //开票成，更新未开票的数据
            this.loading = false;
            this.$notify({
              title: '成功',
              message: '开票成功！',
              type: 'success'
            });
            this.getPurchaseList();
            resolve(res);
          }
        }).catch(error => {
          this.loading = false;
          reject(error)
        })
      })
    },
    manage(){

      this.getInvoiceList();
      this.selectVisible = true;
      this.manageInvoice = true;
    },
    delfunction(data){
      return new Promise((resolve, reject) => {
        crudInvoice.del(data).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.delLoading = false;
            this.getInvoiceList();//更新抬头列表数据
            resolve();
          }
        }).catch(error => {
          this.delLoading = false;
          reject(error)
        })
      })
    },
    delInvoice(id){
      this.delLoading = true;
      this.$confirm('确认删除?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        var data = [id];
        this.delfunction(data);
      })
    }
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
