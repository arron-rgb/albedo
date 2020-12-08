<template>
  <div class='videoPlayer' @click='changeShow' >
    <div class="tipsText" v-show='showVideoText'>
      <h2>高效直播，事半功倍</h2>
      <h4>点击查看案例视频</h4>
    </div>
    <video-player  class="video-player vjs-custom-skin"
                   ref="videoPlayer"
                   :playsinline="true"
                   :options="playerOptions">
    </video-player>
  </div>
</template>

<script>
import storeApi from "@/utils/store";

export default {
  name: "video",
  data(){
    return{
      showVideoText:true,
      playerOptions :	{
        playbackRates: [0.7, 1.0, 1.5, 2.0], //播放速度
        autoplay: false, //如果true,浏览器准备好时开始回放。
        muted: false, // 默认情况下将会消除任何音频。
        loop: false, // 导致视频一结束就重新开始。
        preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
        // language: 'zh-CN',
        aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
        fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
        sources: [{
          type: "video/ogg"||"video/webm"||"video/mp4",
          src: "https://cdn.theguardian.tv/webM/2015/07/20/150716YesMen_synd_768k_vp8.webm" //url地址

        }],
        //poster: require("@/assets/VirtualWeb/NormalUser/img/videoCover.jpg"), //你的封面地址
        // width: document.documentElement.clientWidth,
        notSupportedMessage: '此视频暂无法播放，请稍后再试',
        //允许覆盖Video.js无法播放媒体源时显示的默认信息。
        controlBar: {
          timeDivider: true,
          durationDisplay: true,
          remainingTimeDisplay: false,
          fullscreenToggle: true  //全屏按钮
        }
      },

    }
  },
  created() {
    var list = storeApi.get({ name: 'staticData' });//获得所有的静态资源list
    var dataIndex = list.findIndex(o => o.label === '主页案例视频');
    // console.log(list[dataIndex].value);
    this.playerOptions.sources[0].src = 'https://' + list[dataIndex].value;

  },
  methods: {
    // 是否显示视频文字
    changeShow(){
      this.showVideoText=!this.showVideoText;
    },
  }
}
</script>

<style  scoped lang='scss'>
@import '@/common/style.scss';
.videoPlayer {
  margin-bottom: 150px;
  position: relative;
  display: inline-block;
  width: 800px;
  border: 1px solid transparent;
  //overflow: hidden;
  margin-right: 4px;

  .tipsText {
    width: 400px;
    height: 40px;
    position: absolute;
    z-index: 10;
    top: -100px;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    font-size: 20px;
    color: whitesmoke;
    /* 悬浮穿透 */
    pointer-events: none
  }

}
.vjs-custom-skin ::v-deep .video-js .vjs-big-play-button{
  border-radius:50%;
  width:50px;
  height:50px !important;
  line-height: 48px !important;
  margin-left:-0.5em !important;
  margin-top:2em !important
}
</style>
