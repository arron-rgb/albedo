<template>
<div class="myReceipt">
    <div class="pageTitle">我的发票</div>

  <el-dialog
    title="新增抬头"
    :visible.sync="dialogVisible"
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
        <span>抬头名称：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.name"
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
</div>

</template>

<script>
import crudInvoice from '@/views/biz/invoice/invoice-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
export default {
  name: "proDetail",
  components: {
  },
  data() {
    return {
      dialogVisible : false,
      invoiceData: {
        accountBank: "",//开户行
        accountNumber: "",//银行账号
        companyLocation: "",//公司地址
        companyPhone: "",//公司电话
        description: "",
        name: "",//抬头名称
        type : '0',//0-个人，1-企业
        taxNum: "",//纳税人识别号\社会统一信用代码
      },
      loading : false,
    }
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
            this.dialogVisible = false;
            resolve();
          }
        }).catch(error => {
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

</style>
