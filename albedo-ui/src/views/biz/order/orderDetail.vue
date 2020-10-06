<template>
  <div>
    {{this.orderData}}
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

      <el-row class="box" style="text-align: center" v-if="orderData.state === 2">
        <div class="uploadContainer">
          <div class="uploadCard">
            <!-- <div class="uploadTitle">
                上传配音
            </div> -->
            {{this.audio}}<br />
            <el-upload
              class="upload-demo"
              ref="upload"
              action="#"
              :show-file-list="false"
              :http-request="uploadAud"
              :auto-upload="false"
              :multiple="false"
              :on-change="onUploadChange"
              drag>
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
              <div class="el-upload__tip" slot="tip">格式支持：mp3,且不超过200MB</div>
            </el-upload>
          </div>
        </div>
<!--        <aplayer style="width: 800px; margin:  auto" v-if="this.url !== ''"-->
<!--                 :music="{-->
<!--                  title: this.name,-->
<!--                  artist: '请试听',-->
<!--                  src: this.url,-->
<!--                  theme: '#ff5000'-->
<!--                }"-->
<!--        />-->
        <el-button type="primary" :loading="loading"  @click="next">提交音频</el-button>
      </el-row>
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

      <el-row class="box" v-if="orderData.videoId !== null">
        <el-col span="4">
          产品视频
        </el-col>
        <el-col span="20">
          <div class='videoPlayer'>
            <video-player  class="video-player vjs-custom-skin"
                           ref="videoPlayer"
                           :playsinline="true"
                           :options="playerOptions">
            </video-player>
          </div>

        </el-col>
      </el-row>

      <el-row class="box" style="text-align: center" v-if="orderData.state === 1">
          <el-button @click="takeOrder(orderData.id)" :loading="loading" type="primary" style="width: 150px">接单</el-button>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import storeApi from "@/utils/store";
import crudOrder from '@/views/biz/order/order-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import dubOperate from "@/components/VirtualWeb/addDetail/machineDub/dub-service";
import aplayer from 'vue-aplayer'

export default {
  name: "orderDetail",
  components: {
    aplayer
  },
  data(){
    return {
      orderData : {},
      loading : false,
      tagList : ["", "success", "info", "warning", "danger"],
      voiceData : [],
      audio : {url : '',
      name : '',},
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
          src: 'http://' + this.orderData.videoId//url地址

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
      if(orderData.type === '2') {
        this.getVoiceData(orderData.description);
        // this.typeList = ["", "success", "info", "warning", "danger"];
      }
    }
  },
  methods : {
    next() {//上传音频
      this.$set(this.loading, null, true);
      // 检查是否上传了音频
      // console.log(this.url);
      if(this.url === null || this.url === undefined || this.url === ''){
        this.$message.error('请先上传音频！');
        this.loading = false;
        return ;
      }
      // 调用上传方法
      this.$refs.upload.submit();
      this.loading = false;
    },
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
    onUploadChange(file) {//检查文件是否合法
      console.log(file);
      this.$set(this.name,  file.name);
      const isIMAGE = (file.raw.type === 'audio/mpeg');
      const isLt1M = file.size / 1024 / 1024 < 200;

      if (!isIMAGE) {
        this.$message.error('只能上传mp3格式的音频！');
        return;
      }
      if (!isLt1M) {
        this.$message.error('上传文件大小不能超过200MB！');
        return;
      }

      var _this = this;

      var reader = new FileReader();
      reader.readAsDataURL(file.raw)
      reader.onload = function (e) {
        //this.result为图片的base64
        // console.log(e.target.result)
        //将图片路径赋值给url

        _this.url = e.target.result;
      }

    },
    uploadAud(file) {//上传文件
      var _this = this
      return new Promise((resolve, reject) => {
        dubOperate.uploadFile(file).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            //音频上传成功，二次保存订单
            // console.log(res.data.url);
            this.saveAudio(res.data.url);
          }
        }).catch(error => {
          this.loading = false;
          reject(error)
        })
      });
    },
    getVoiceData(data){//获得配音音色数据
      var temp = data.substr(1,data.length - 2);
      this.voiceData = temp.split(',');
    },
    saveAudio(url){
      var data = {
        orderId : this.orderData.id,//订单id
        audioUrl: url //音频url
      }
      return new Promise((resolve, reject) => {
        crudOrder.uploadAudio(data).then( res => {
          resolve();
          this.$alert('音频保存成功，辛苦了！', '提示',{
            confirmButtonText: '确定',
            callback: action => {
              this.goTo('/order/order')
            }
          });
        }).catch(error => {
          reject(error);
        })
      })
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
.videoPlayer{
  /*height: 200px;*/
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
