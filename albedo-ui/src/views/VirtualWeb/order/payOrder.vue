<template>
<div>
  <div class="container">
    <el-card class="box-card" body-style="padding : 0px">
      <div slot="header" class="clearfix">
        <span class="title">需求清单</span>
      </div>


      <el-row class="box">
        <el-col span="4">
          已选需求：
        </el-col>
        <el-col span="20">
          <el-tag class="tag" v-for="(o,index) in this.list" :key="o" :type="typeList[index % 5]" span="18">{{o.data[0].value}}</el-tag>
        </el-col>
      </el-row>

      <el-row class="box">
        <el-col span="4">
          补充需求（选填）：
        </el-col>
        <el-col span="20">
          <el-input type="textarea" :rows="3" v-model="description" placeholder="请输入文本"></el-input>
        </el-col>
      </el-row>

      <el-row class="box">
        <el-col span="4">
          加速服务（30元/次）：
        </el-col>
        <el-col span="20">
          <el-row>
            <el-col span="6">
              <el-radio-group v-model="type" text-color="#ff5000" fill="#ff5000">
                <el-radio label="1" border>启用</el-radio>
                <el-radio label="0" border>不启用</el-radio>
              </el-radio-group>
            </el-col>
            <el-col span="18" style="font-size: 14px; color: #909399">tips：启用加速服务将提速80%，预计24小时内完成视频</el-col>
          </el-row>
        </el-col>
      </el-row>

<!--      ￥<span style="font-size: 26px; color: #ff5000; margin: 0 10px">999</span>元/次-->
      <el-row  class="box">
        <el-col span="4">
          合计：
        </el-col>
        <el-col span="20">
          <el-row>
            <el-col span="6">￥<span style="font-size: 26px; color: #ff8249; margin: 0 10px">{{this.totalAmount}}</span>元</el-col>
          </el-row>
        </el-col>
      </el-row>

      <el-row class="box">
        <el-col span="4">
          支付方式：
        </el-col>
        <el-col span="20">
          <el-radio-group v-model="payType" text-color="#ff5000" fill="#ff5000">
            <el-radio style="height: 80px; width: 200px" label="0" border>
              <a style="height: 60px; line-height: 60px">
                <img style="height: 60px; position: absolute" src="@/assets/VirtualWeb/alipay.jpg">
              </a>
            </el-radio>
            <el-radio style="height: 80px; width: 200px"  label="1" border>
              <a style=" line-height: 60px; padding-left: 10px">
                <img style="height: 60px; position: absolute" src="@/assets/VirtualWeb/wechat.png">
              </a>
            </el-radio>
            <el-radio style="height: 80px; width: 200px"  label="2" border>
              <a style=" line-height: 60px; padding-left: 10px;font-size: 24px">
                <i class="el-icon-s-custom"></i>
              </a>
              <a style=" line-height: 60px;font-size: 16px">
                抵扣会员次数
              </a>
            </el-radio>
          </el-radio-group>
        </el-col>
      </el-row>

      <el-row style="margin: 50px 0">
        <el-button :loading="loading" style="width: 150px" type="primary" @click="toPay">前往支付</el-button>
      </el-row>
    </el-card>
  </div>
</div>
</template>

<script>
import storeApi from "@/utils/store";
import payOrder from '@/views/VirtualWeb/order/payOrder-server'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import store from "@/store";
export default {
  name: "payOrder",
  data(){
    return{
      list : [],
      typeList : ["", "success", "info", "warning", "danger"],
      description : '',
      type : '1',//加速服务，0 不加速， 1加速
      payType : '0', //0 支付宝支付， 1微信支付
      totalAmount : 1029,
      data : '',
      loading : false,
      priceList : [999, 1999, 0],
    }
  },
  watch: {
    type : function (val){
      this.type = val;
      this.totalAmount = this.priceList[0] + val * 30;
    }

  },
  created() {
    var list = storeApi.get({
      name: 'videoConfig'
    }) || null;
    if(list === null || list === undefined){
      this.$alert('请先选择视频基础需求', {
        confirmButtonText: '确定',
      }).then(
        this.goTo('/addOrder')
      );
    }
    else{
      this.list = list
    }
  },
  methods:{
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
    toPay(){
      this.loading = true;
      var content = {data : this.list}
      var data = {
        content : JSON.stringify(content),
        methods : '',
        totalAmount : this.totalAmount,
        type : this.type
      }
      return new Promise((resolve, reject) => {
        payOrder.save(data).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            console.log(res)
            this.$message({
              message: '订单提交成功，即将跳转支付页面',
              type: 'success'
            });
            this.toPurchase(res.data);
          }
          this.loading = false;
        }).catch(error => {
          reject(error)
          this.loading = false;
        })
      })
    },
    toPurchase(key){

      var data = {
        orderId : key,
        subject : '单人主播视频订单',
        token : store.getters.token,
      }
      console.log(data);
      payOrder.purchase(data).then(res => {
        if (res.code === MSG_TYPE_SUCCESS) {
          console.log(res)
          this.$message({
            message: '支付成功！',
            type: 'success'
          });
        }

      }).catch(error => {
        reject(error)
      })
    }
  }
}
</script>

<style scoped>
.container{
  width: 1200px;
  margin: auto;
  padding: 30px 0;
}
.clearfix{
  text-align: left;
  /*background: rgba(255,80,0,0.1);*/
}
.title{
  width: 100%;
  margin-left: 40px;
  /*color: rgba(255, 80, 0, 0.7);*/
  font-size: 24px;
  /*line-height: 50px;*/
}

.box-card{
  height: 100%;
  padding: 0;
}


.tag{
  min-width: 100px;
  line-height: 40px;
  text-align: center;
  font-size: 14px;
  min-height: 40px;
  margin: 10px;
}

.box{
  padding: 10px 60px;
  text-align: left;
  line-height: 50px;
}

/*.myRadio{*/
/*  margin-left:10px;*/
/*}*/
/*.myRadio{*/
/*  color: #ff5000;*/
/*  background-color: #ff5000;*/
/*}*/

/*.radio-wrapper {*/
/*  display: flex;*/
/*  flex-direction: row;*/
/*  align-items: center;*/
/*.icon {*/
/*  width: 30px;*/
/*  height: 30px;*/
/*  margin-left: 5px;*/
/*  margin-right: 5px;*/
/*}*/
/*}*/
/*.radio-border {*/
/*  width: 180px;*/
/*  height: 70px;*/
/*  border-radius: 5px;*/
/*  border: 1px solid #d7dae2;*/
/*}*/
</style>
