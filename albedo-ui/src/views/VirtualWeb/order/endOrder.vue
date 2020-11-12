<template>
  <div>
<!--    {{this.orderDetail}}-->
    <div class="container">
      <el-card class="box-card" body-style="padding : 0px">
        <div slot="header" class="clearfix">
          <span class="title">订单详情</span>
        </div>
<!--        {{orderDetail}}-->
        <el-row  class="box">
          <el-col span="4">
            创建时间：
          </el-col>
          <el-col span="20">
            {{orderDetail.createdDate}}
          </el-col>
        </el-row>

        <el-row  class="box">
          <el-col span="4">
            创建人：
          </el-col>
          <el-col span="20">
            {{orderDetail.createdBy}}
          </el-col>
        </el-row>

        <el-row  class="box">
          <el-col span="4">
            订单状态：
          </el-col>
          <el-col span="20">
            <el-row>
              <span v-if="orderDetail.state  === 0">未付款</span>
              <span v-else-if="orderDetail.state  === 1">未接单</span>
              <span v-else-if="orderDetail.state  === 2">制作中</span>
              <span v-else-if="orderDetail.state  === 6">已结单</span>
              <span v-else>可配音</span>
            </el-row>
          </el-col>
        </el-row>

        <el-row class="box" v-if="orderDetail.type === '0' || orderDetail.type === '1'">
          <el-col span="4">
            已选需求：
          </el-col>
          <el-col span="20" >
            <div :key="o" v-for="(o,index) in JSON.parse(orderDetail.content).data" >
              <el-tag :type="typeList[index % 5]"  class="tag" v-for="i in o.data">
                <p style="line-height: 40px; margin: 0">{{i.value}}<p/>
              </el-tag>
            </div>
          </el-col>
        </el-row>

        <el-row class="box" v-else>
          <el-col span="4">
            已选需求：
          </el-col>
          <el-col span="20">
            <el-tag :key="o" :type="typeList[index % 5]" class="tag" v-for="(o,index) in orderDetail.description.slice(1,orderDetail.description.length - 1).split(',')">
              <p style="line-height: 40px; margin: 0">{{o}}<p/>
            </el-tag>
          </el-col>
        </el-row>

        <el-row class="box" v-if="orderDetail.type === '0' || orderDetail.type === '1'">
          <el-col span="4">
            补充需求（选填）：
          </el-col>
          <el-col span="20">
            {{orderDetail.description}}
          </el-col>
        </el-row>

        <el-row class="box" v-else>
          <el-col span="4">
            台词文本：
          </el-col>
          <el-col span="20">
<!--            <el-tag class="tag" v-for="(o,index) in orderDetail.content" :key="o" :type="typeList[index % 5]">-->
              <p style="line-height: 40px; margin: 0">{{orderDetail.content}}<p/>
<!--            </el-tag>-->
          </el-col>
        </el-row>

        <el-row class="box" v-show="orderDetail.type === '0' || orderDetail.type === '1'">
          <el-col span="4">
            加速服务：
          </el-col>
          <el-col span="20">
            {{orderDetail.type === '0' ? '未加速' : '已加速'}}
          </el-col>
        </el-row>

        <!--      ￥<span style="font-size: 26px; color: #ff5000; margin: 0 10px">999</span>元/次-->
        <el-row  class="box">
          <el-col span="4">
            订单价格：
          </el-col>
          <el-col span="20">
            <el-row>
              <el-col span="6">￥<span style="font-size: 26px; color: #ff8249; margin: 0 10px">{{orderDetail.totalAmount}}</span>元</el-col>
            </el-row>
          </el-col>
        </el-row>
        <el-row  class="box">
          <el-col span="4">
            支付方式：
          </el-col>
          <el-col span="20">
            <span v-if="orderDetail.method === 'ali'">支付宝</span>
            <span v-if="orderDetail.method === 'wechat'">微信</span>
            <span v-if="orderDetail.method === 'balance'">套餐余额</span>
          </el-col>
        </el-row>

        <el-row class="box"  v-if="orderDetail.type === '0' || orderDetail.type === '1'">
          <el-col span="4">
            产品视频：
          </el-col>
          <el-col span="20">
            <div v-if="this.orderDetail.videoId === ''">视频已失效</div>
            <div class='videoPlayer' v-else>
              <video-player  class="video-player vjs-custom-skin"
                             ref="videoPlayer"
                             :playsinline="true"
                             :options="playerOptions">
              </video-player>
              <el-row style="text-align: center">
                <el-button @click="download">下载视频<i style="font-size: 18px" class="el-icon-download el-icon--right"></i></el-button>
              </el-row>
            </div>

          </el-col>
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
export default {
  name: "endOrder",
  data(){
    return{
      orderDetail : null,
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
      playerOptions : {
        playbackRates: [0.7, 1.0, 1.5, 2.0], //播放速度
        autoplay: false, //如果true,浏览器准备好时开始回放。
        muted: false, // 默认情况下将会消除任何音频。
        loop: false, // 导致视频一结束就重新开始。
        preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
        // language: 'zh-CN',
        aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
        fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
        sources: [{
          type: "video/mp4",
          src: null//url地址

        }],
        // poster: require("@/assets/VirtualWeb/NormalUser/img/videoCover.jpg"), //你的封面地址
        // width: document.documentElement.clientWidth,
        notSupportedMessage: '此视频暂无法播放，请稍后再试',
        //允许覆盖Video.js无法播放媒体源时显示的默认信息。
        controlBar: {
          timeDivider: true,
          durationDisplay: true,
          remainingTimeDisplay: false,
          fullscreenToggle: false  //全屏按钮
        }
      }
    }
  },
  watch: {
    type : function (val){
      this.type = val;
      this.totalAmount = this.priceList[0] + val * 30;
    }

  },
  created() {
      var orderDetail = storeApi.get({
        name: 'orderDetail'
      });
      if (orderDetail === null || orderDetail === undefined) {
        this.$alert('请先选择具体视频订单', {
          confirmButtonText: '确定',
        }).then(
          this.goTo('/myOrder')
        );
      }
      else {
        this.orderDetail = orderDetail;
        if(orderDetail.videoId !== '' || orderDetail.videoId !== null )
          this.playerOptions.sources[0].src = 'https://' + orderDetail.videoId;
        // console.log(this.playerOptions.sources[0].src);
      }
  },
  methods:{
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
    downVideo () {
      const a = document.createElement('a')
      a.setAttribute('download', '虚拟工坊')
      a.setAttribute('href', this.playerOptions.sources[0].src)
      a.click()
    },
    download(){
      let link = document.createElement("a"); //创建a标签
      link.style.display = "none"; //使其隐藏
      link.href = this.playerOptions.sources[0].src; //赋予文件下载地址
      link.setAttribute("download", '虚拟工坊'); //设置下载属性 以及文件名
      // document.body.appendChild(link); //a标签插至页面中
      link.click(); //强制触发a标签事件
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
