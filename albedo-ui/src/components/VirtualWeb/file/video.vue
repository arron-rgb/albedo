<template>
  <div class='videoPlayer' v-if="videoData !== null && videoData !== undefined && videoData !== []">
    <video-player  :options="playerOptions"
                   :playsinline="true"
                   class="video-player vjs-custom-skin"
                   ref="videoPlayer">
    </video-player>
    <el-button :loading="loading" @click="delVideo" type="primary" v-if="this.type === 'staff'">删除</el-button>
  </div>
</template>

<script>
import storeApi from "@/utils/store";
import crudOrder from "@/views/biz/order/order-service";
import {MSG_TYPE_SUCCESS} from "@/const/common";

export default {
  name: "video",
  props:['videoData', 'type'],
  data (){
    return {
      orderData : {},
      loading : false,
      playerOptions : {
        playbackRates: [0.7, 1.0, 1.5, 2.0], //播放速度
        autoplay: false, //如果true,浏览器准备好时开始回放。
        muted: false, // 默认情况下将会消除任何音频。
        loop: false, // 导致视频一结束就重新开始。
        preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
        // language: 'zh-CN',
        aspectRatio: '9:16', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
        fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
        sources: [{
          type: "video/mp4",
          src: ''//url地址

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
    // var orderData = storeApi.get({
    //   name: 'orderData'
    // }) || null;
    // if(orderData === null || orderData === undefined){
    //   this.$alert('请先选择相关视频！', '提示',{
    //     confirmButtonText: '确定',
    //     callback: action => {
    //       this.goTo('/order/order')
    //     }
    //   });
    // }else{
    //   this.orderData = orderData;
    //   // this.playerOptions.sources[0].src = 'https://' + orderData.videoId;
    //   this.playerOptions.sources[0].src = 'https://' + this.videoData.originUrl
    // }
    // console.log(this.videoData);
    if(this.type === 'staff')
      this.playerOptions.sources[0].src = 'https://' + this.videoData.originUrl
    else{
      this.playerOptions.aspectRatio = '16:9';
      this.playerOptions.sources[0].src = 'https://' + this.videoData;
    }

  },
  methods : {
    delVideo(){
      this.loading = true;
      var data = [this.videoData.id]
      return new Promise((resolve, reject) => {
        crudOrder.delVideo(data).then(res => {
          location.reload();
          resolve(res);
          this.loading = false
        }).catch(res => {
          this.loading = false
          reject(res);
        })
      })
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {func: data}});
    },
  }
}
</script>

<style scoped>
.videoPlayer{
  width: 300px;
  text-align: center;
}
</style>
