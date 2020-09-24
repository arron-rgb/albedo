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
          <span v-for="(o,index) in this.list" :key="o">
            <el-tag v-for="(item, n) in o.data" class="tag" :type="typeList[(index + n) % 5]" span="18">{{item.value}}</el-tag>
          </span>
        </el-col>
      </el-row>

      <el-row class="box" v-if="!orderId">
        <el-col span="4">
          Logo水印（选填）：
        </el-col>
        <el-col span="20">
          <el-upload
            ref="logoUpload"
            class="avatar-uploader"
            action="#"
            :http-request="(file) => uploadImg(file, 'logo')"
            accept="image/jpeg,image/png"
            :show-file-list="false"
            :auto-upload="false"
            :multiple="false"
            :on-change="(file) => onUploadChange(file, 'logo')"
          >
            <img v-if="logoUrl" :src="logoUrl" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-col>
      </el-row>

      <el-row class="box" v-if="!orderId">
        <el-col span="4">
          贴片水印（选填）：
        </el-col>
        <el-col span="20">
          <el-upload
            ref="picUpload"
            class="avatar-uploader"
            action="#"
            :http-request="(file) => uploadImg(file, 'pic')"
            accept="image/jpeg,image/png"
            :show-file-list="false"
            :auto-upload="false"
            :multiple="false"
            :on-change="(file) => onUploadChange(file, 'pic')"
          >
            <img v-if="picUrl" :src="picUrl" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-col>
      </el-row>

      <el-row class="box">
        <el-col span="4">
          补充需求（选填）：
        </el-col>
        <el-col span="20">
          <el-input type="textarea" :rows="3" v-model="description" placeholder="可告知工作人员您想要的主题配色、水印效果及其他需求哦！"></el-input>
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
            <el-radio style="height: 80px; width: 200px" label="ali" border>
              <a style="height: 60px; line-height: 60px">
                <img style="height: 60px; position: absolute" src="@/assets/VirtualWeb/alipay.jpg">
              </a>
            </el-radio>
<!--            <el-radio style="height: 80px; width: 200px"  label="wechat" border>-->
<!--              <a style=" line-height: 60px; padding-left: 10px">-->
<!--                <img style="height: 60px; position: absolute" src="@/assets/VirtualWeb/wechat.png">-->
<!--              </a>-->
<!--            </el-radio>-->
            <el-radio v-if="times > 0" style="height: 80px; width: 200px"  label="balance" border>
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
        <el-button :loading="loading" style="width: 150px" type="primary" @click="beforePay">前往支付</el-button>
        <el-button :loading="loading" style="width: 150px" v-if="this.orderId !== null" @click="cancel()">取消订单</el-button>
      </el-row>
    </el-card>
  </div>
</div>
</template>

<script>
import storeApi from "@/utils/store";
import payOrder from '@/views/VirtualWeb/order/payOrder-server'
import crudOrder from '@/views/biz/order/order-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import loginService from "@/api/login";
import dubOperate from "@/components/VirtualWeb/addDetail/machineDub/dub-service";
export default {
  name: "payOrder",
  data(){
    return{
      list : [],
      typeList : ["", "success", "info", "warning", "danger"],
      description : '',
      type : '1',//加速服务，0 不加速， 1加速
      payType : 'ali', //0 支付宝支付， 1微信支付
      totalAmount : 1029,
      data : '',
      loading : false,
      priceList : [999, 1999, 0],
      orderId : null,
      times : 0,
      logoUrl : '',
      picUrl : '',
      urls : {
        logo : '',
        pic : '',
      },
    }
  },
  watch: {
    type : function (val){
      this.type = val;
      this.totalAmount = this.priceList[0] + val * 30;
    }

  },
  created() {
    if(this.$route.query.data === "hadOrder"){//判断是否是已有订单
      var videoOrder = storeApi.get({
        name: 'videoOrder'
      });
      if (videoOrder === null || videoOrder === undefined) {
        this.$alert('请先选择视频基础需求', {
          confirmButtonText: '确定',
        }).then(
          this.goTo('/addOrder')
        );
      }
      else {
        this.getBalance();
        this.list = JSON.parse(videoOrder.content).data;
        this.type = videoOrder.type;
        this.totalAmount = videoOrder.totalAmount;
        this.description = videoOrder.description;
        this.orderId = videoOrder.id;
      }
    }
    else {//是新的订单，尚未保存
      var list = storeApi.get({
        name: 'videoConfig'
      }) || null;
      if (list === null || list === undefined) {
        this.$alert('请先选择视频基础需求', {
          confirmButtonText: '确定',
        }).then(
          this.goTo('/addOrder')
        );
      } else {
        this.list = list;
        this.getBalance();
      }
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
        method : this.payType,//支付方式
        totalAmount : this.totalAmount,
        type : this.type,
        logoUrl : this.urls.logo,//logo图片
        adUrl : this.urls.pic,//贴片图片
      }
      if(this.orderId !== null){//原有订单直接提交请求
        this.getToken(this.orderId);
      }
      else {
        return new Promise((resolve, reject) => {//新订单先保存
          payOrder.save(data).then(res => {//保存订单并获取订单id
            if (res.code === MSG_TYPE_SUCCESS) {
              // console.log(res)
              this.$message({
                message: '订单提交成功，即将跳转支付页面',
                type: 'success'
              });
              this.getToken(res.data);
            }
            this.loading = false;
          }).catch(error => {
            reject(error)
            this.loading = false;
          })
        })
      }
    },
    balancePurchase(){//会员次数支付
        var data = {
          method: this.payType,
          orderId: this.orderId
        }
        return new Promise((resolve, reject) => {
          payOrder.edit(data).then(res => {//修改订单支付方式成功
            if (res.code === MSG_TYPE_SUCCESS) {
              // console.log(res);
              this.getToken(this.orderId);
            }
            this.loading = false;
          }).catch(error => {
            reject(error)
            this.loading = false;
          })
        })
    },
    getToken(key){//获取token
      return new Promise((resolve, reject) => {
        loginService.token().then((res) => {
          // console.log(res)
          this.toPurchase(key, res);
        }).catch(error => {
          reject(error)
        })
      })
    },
    toPurchase(key, token){//提交支付请求
      var data = {
        orderId : key,
        subject : '虚拟工坊视频订单',
        token : token,
      }
      return new Promise((resolve, reject) => {
        payOrder.purchase(data)
        //清除videoOrder
          storeApi.clear({
            name: 'videoOrder'
          });
          this.goTo('/addOrder');
        })
    },
    cancel(){//取消订单
      this.$alert('确定删除此订单?', '警告', {
        confirmButtonText: '确定',
        cancelButtonClass: '取消',
      }).then(() => {
        this.cancelOrder();
      });
    },
    cancelOrder(){
      var ids = [this.orderId.toString()]
      return new Promise((resolve, reject) => {
        crudOrder.del(ids).then((res) => {
          // console.log(res)
          this.$route.query.data = null;
          storeApi.clear({
            name: 'videoOrder'
          })
          //清除videoOrder
          storeApi.clear({
            name: 'videoConfig'
          });
          this.$alert('订单删除成功！', '警告', {
            confirmButtonText: '确定',
          }).then(() => {
            this.goTo("/addOrder");
          });
        }).catch(error => {
          reject(error);
        })
      })
    },
    getBalance(){
      return new Promise((resolve, reject) => {
        payOrder.balance().then(res => {
          if(res.code === MSG_TYPE_SUCCESS){
            this.times = res.data.tims;
          }
        }).catch(res =>{
          reject();
          }
        )
      })
    },
    uploadImg(file, type){//上传图片
      var _this = this
      return new Promise((resolve, reject) => {
        dubOperate.uploadFile(file).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            if(type === 'logo'){
              _this.urls.logo = res.data.url
              if(_this.urls.pic === '' && _this.picUrl !== ''){//贴片图片尚未上传
                this.$refs.picUpload.submit();
              }
              else{
                _this.toPay();
              }
            }
            else{
              _this.urls.pic = res.data.url;
              if(_this.urls.pic === '' && _this.picUrl !== ''){//贴logo图片尚未上传
                this.$refs.logoUpload.submit();
              }
              else{
                _this.toPay();
              }
            }

          }
        }).catch(error => {
          this.loading = false;
          reject(error)
        })
      });
    },
    onUploadChange(file, type){
      // console.log(file);
      const  isIMAGE = (file.raw.type === 'image/jpeg' || file.raw.type === 'image/png');
      const  isLt1M = file.size / 1024 / 1024 < 1;

      if(!isIMAGE){
        this.$message.error('只能上传jpg/png图片！');
        return  false;
      }
      if(!isLt1M){
        this.$message.error('上传文件大小不能超过1MB！');
        return  false;
      }

      var _this = this;

      var reader = new FileReader();
      reader.readAsDataURL(file.raw)

      reader.onload = function (e){
        //this.result为图片的base64
        // console.log(this.result)
        //将图片路径赋值给url
        if(type === 'pic')
          _this.picUrl =  e.target.result;
        else
          _this.logoUrl = e.target.result;

      }

    },
    beforePay(){
      if(this.logoUrl !== ''){
        this.$refs.logoUpload.submit();
      }
      else if(this.picUrl !== ''){
        this.$refs.logoUpload.submit();
      }
      else
        this.toPay();//没上传logo 和 贴片，直接保存订单
    }
  }
}
</script>

<style scoped>
.avatar-uploader{
  border: 1px dashed #d9d9d9 !important;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  width: 128px;
  height: 128px;
}
.avatar-uploader:hover {
  border-color: #ff5000 !important;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 128px;
  height: 128px;
  line-height: 128px;
  text-align: center;
}
.avatar-uploader-icon:hover {
  color: #ff5000 !important;
}
.avatar {
  width: 128px;
  height: 128px;
  display: block;
}
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
