<template>
  <div>
<!--    {{this.orderData}}-->
<!--    视频订单详情查看-->
    <el-card class="box-card" body-style="padding : 0px" v-if="orderData.type === '2'">
      <div slot="header" class="clearfix">
        <span class="title">订单详情</span>
      </div>

      <el-row  class="box">
        <el-col span="4">
          用户所选音色
        </el-col>
        <el-col span="20">
          <el-tag class="tag"  v-for="(item,index) in voiceData" :key="index">
            {{item}}
          </el-tag>
        </el-col>
      </el-row>

      <el-row  class="box">
        <el-col span="4">
          台词内容
        </el-col>
        <el-col span="20">
          {{this.orderData.content}}
        </el-col>
      </el-row>

      <el-row class="box">
        <el-col span="4">
          处理人
        </el-col>
        <el-col span="20">
          {{this.orderData.staffId === null ? '暂无' : this.orderData.staffId}}
        </el-col>
      </el-row>

      <el-row class="box" style="text-align: center" v-if="orderData.state === 1">
        <el-button @click="takeOrder(orderData.id)" :loading="loading" type="primary" style="width: 150px">接单</el-button>
      </el-row>

<!--      <el-row class="box" style="text-align: center" v-if="orderData.state === 2">-->
      <audio-upload v-if="orderData.state === 2"></audio-upload>
<!--      </el-row>-->
    </el-card>

    <el-card class="box-card" body-style="padding : 0px" v-else>
      <div slot="header" class="clearfix">
        <span class="title">订单详情</span>
      </div>

      <el-row  class="box">
        <el-col span="4">
          用户所选需求
        </el-col>
        <el-col span="20">
<!--          {{JSON.parse(this.orderData.content).data}}-->
          <el-row style="text-align: center">
            <el-col span="8">所属分类</el-col>
            <el-col span="8">所选需求</el-col>
            <el-col span="8">示例图片</el-col>
          </el-row>
          <el-row v-for="(o,index) in JSON.parse(this.orderData.content).data" :key="o">

            <el-row class="box-table" v-for="item in o.data">
              <el-col span="8" >{{o.title}}</el-col>
              <el-col span="8" >{{item.value}}</el-col>
              <el-col span="8" >
                <img class="img" v-show="item.url !== undefined && item.url !== null" :src="'http://' + item.url">
              </el-col>
            </el-row>
          </el-row>
<!--          <span v-for="(o,index) in JSON.parse(this.orderData.content).data" :key="o">-->

<!--            <el-card body-style="padding : 5px" class="box-contain" v-for="item in o.data">-->
<!--&lt;!&ndash;              {{item}}&ndash;&gt;-->

<!--              <img class="img" v-show="item.url !== undefined && item.url !== null" :src="'http://' + item.url">-->
<!--              <div class="button-title">{{item.title}}</div>-->
<!--              <div class="button-text">{{item.value}}</div>-->
<!--&lt;!&ndash;            <el-tag v-for="(item, n) in " :key="n" class="tag" span="18">{{item.value}}</el-tag>&ndash;&gt;-->
<!--            </el-card>-->
<!--          </span>-->
        </el-col>
      </el-row>

      <el-row class="box">
        <el-col span="4">
          是否加速
        </el-col>
        <el-col span="20">
          <span v-if="this.orderData.type === '1'" style="color: #ff5000">加速订单</span>
          <span v-else>普通订单</span>
        </el-col>
      </el-row>

      <el-row class="box">
        <el-col span="4">
          附加图片
        </el-col>
        <el-col span="10" v-show="this.orderData.logoUrl !== '' && this.orderData.logoUrl !== null">
          <el-row>logo图片</el-row><br />
          <img class="img2" :src="'http://' + this.orderData.logoUrl">
        </el-col>
        <el-col span="10" v-show="this.orderData.adUrl !== '' && this.orderData.adUrl !== null">
          <span>贴片图片</span><br />
          <img class="img2" :src="'http://' + this.orderData.adUrl">
        </el-col>
      </el-row>

      <el-row class="box">
        <el-col span="4">
          处理人
        </el-col>
        <el-col span="20">
          {{this.orderData.staffId === null ? '暂无' : this.orderData.staffId}}
        </el-col>
      </el-row>

      <el-row class="box" v-if="orderData.state > 2">
        <el-col span="4">
          产品视频
        </el-col>
        <el-col span="20">
          <my-video :key="item" :video-data="item" style="float: left; margin: 10px" v-for="item in videoList"></my-video>
        </el-col>
      </el-row>

      <el-row class="box" style="text-align: center" v-if="orderData.state === 1">
          <el-button @click="takeOrder(orderData.id)" :loading="loading" type="primary" style="width: 150px">接单</el-button>
      </el-row>

      <el-row class="box" v-if="orderData.state > 1">
        <video-upload></video-upload>
      </el-row>

      <el-row class="box" style="text-align: center" v-if="orderData.state > 1">
        <el-button :loading="updateLoading" @click="update">更新订单</el-button>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import storeApi from "@/utils/store";
import crudOrder from '@/views/biz/order/order-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import audioUpload from '@/components/VirtualWeb/file/audioUpload'
import videoUpload from '@/components/VirtualWeb/file/videoUpload'
import payOrder from "@/views/VirtualWeb/order/payOrder-server";
import myVideo from '@/components/VirtualWeb/file/video'
import MyOrder from "@/views/VirtualWeb/personal/myOrder";


export default {
  name: "orderDetail",
  components: {
    MyOrder,
    audioUpload,
    videoUpload,
    myVideo
  },
  data(){
    return {
      orderData : {},
      loading : false,
      updateLoading : false,
      tagList : ["", "success", "info", "warning", "danger"],
      voiceData : [],
      videoList : []
    }
  },
  created() {
    var orderData = storeApi.get({
      name: 'orderData'
    }) || null;
    if(orderData === null || orderData === undefined){
      this.$alert('请先选择相关视频！', '提示',{
        confirmButtonText: '确定',
        callback: action => {
          this.goTo('/order/order')
        }
      });
    }else{
      this.orderData = orderData;
      if(orderData.state > 2)
        this.getVideo(orderData.id)
      if(orderData.type === '2') {
        this.getVoiceData(orderData.description);
        // this.typeList = ["", "success", "info", "warning", "danger"];
      }
    }
  },
  methods : {
    takeOrder(orderId){//接订单
      this.loading = true;
      return new Promise((resolve, reject) => {
        crudOrder.consume(orderId).then(res => {
          if(res.code === MSG_TYPE_SUCCESS){
            this.$alert('接单成功，请尽快制作哦！', '提示',{
              confirmButtonText: '确定',
              callback: action => {
                this.goTo('/order/order')
              }
            });
          }
          // resolve(res);
          this.loading = false;
        }).catch(res => {
          reject(res);
          this.loading = false;
        })
      })
    },
    getVideo(orderId){//获取订单视频list
      return new Promise((resolve, reject) => {
        crudOrder.getVideoList(orderId).then(res => {
          if(res.code === MSG_TYPE_SUCCESS){
            this.videoList = res.data.records;
          }
          resolve(res);
        }).catch(res => {
          reject(res);
        })
      })
    },
    getVoiceData(data){//获得配音音色数据
      var temp = data.substr(1,data.length - 2);
      this.voiceData = temp.split(',');
    },
    updateOrder(){
      this.updateLoading = true;
      return new Promise((resolve, reject) => {
        payOrder.update(this.orderData.id).then( res =>{
          if(res.code === MSG_TYPE_SUCCESS){
            this.$alert('订单更新成功，辛苦了！', '提示',{
              confirmButtonText: '确定',
              callback: action => {
                this.goTo('/order/belong')
              }
            });
          }
          resolve(res);
        }).catch(err =>{
          reject(err)
        })
        this.updateLoading = false;
      })

    },
    update(){//更新订单状态
      this.$alert('请确保视频已上传！', '提示',{
        confirmButtonText: '确定',
        callback: action => {
          this.updateOrder();
        }
      });
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
  }
}
</script>

<style scoped>
.box-card{
  height: 100%;
  padding-bottom: 30px;
  margin: 10px;
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
.box{
  padding: 0px 60px;
  text-align: left;
  line-height: 50px;
  /*border-bottom: 1px solid #dcdfe6;*/
}

.img{
  background-color: white;
  width: 60px;
  height: 90px;
}
.img2{
  background-color: white;
  width: 80px;
  height: 80px;
}
.box-table{
  text-align: center;
  border-top: 1px solid #dcdfe6;
}

.tag{
  min-width: 100px;
  line-height: 40px;
  text-align: center;
  font-size: 14px;
  min-height: 40px;
  margin: 10px;
}
</style>
