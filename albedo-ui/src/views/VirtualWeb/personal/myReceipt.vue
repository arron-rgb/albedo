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
        <span v-if="invoiceData.type === '1'">公司名称：</span>
        <span v-else>您的姓名：</span>
      </el-col>
      <el-col span="15">
        <el-input
          v-model="invoiceData.name"
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

    <el-button type="primary" @click="saveInvoice">保存</el-button>
  </el-dialog>
</div>

</template>

<script>

export default {
  name: "proDetail",
  components: {
  },
  data() {
    return {
      dialogVisible : true,
      invoiceData: {
        accountBank: "",//开户行
        accountNumber: "",//银行账号
        companyLocation: "",//公司地址
        companyPhone: "",//公司电话
        description: "",
        name: "",//公司名称
        type : '0',//0-个人，1-企业
        taxNum: "",//纳税人识别号\社会统一信用代码
      },
    }
  },
  methods : {
    saveInvoice(){//保存发票

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
