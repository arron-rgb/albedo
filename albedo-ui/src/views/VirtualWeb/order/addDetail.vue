<template>
<div class='addDetail'>
<!--  步骤条-->
  <step-line></step-line>

  <!-- 视频 -->
  <div class='videoPlayer'>
    <video-player  class="video-player vjs-custom-skin"
                   ref="videoPlayer"
                   :playsinline="true"
                   :options="playerOptions">
    </video-player>
  </div>

  <!-- 提示开始配置，选择视频时长以及配音方式 -->
  <div class="descriBlock">
    <div class="blockTitle">详情配置</div>
    <div class="startBar">
      <el-row  class="box">
        <el-col span="4">
          设置视频时长：
        </el-col>
        <el-col span="20">
          <el-row>
            <el-input-number v-model="duration" size="medium"  :min="1" :max="120" label="设置视频时长"></el-input-number>
             分钟 （允许范围：1-120分钟）
          </el-row>
        </el-col>
      </el-row>
      <el-row  class="box">
        <el-col span="4">
          选择配音方式：
        </el-col>
        <el-col span="20">
          <el-radio-group v-model="dubType" text-color="#ff5000" fill="#ff5000">
            <el-radio style="height: 80px; width: 230px"  label="0" border>
              <a style=" line-height: 60px;font-size: 24px">
                <i class='el-icon-folder-opened button-icon' ></i>
              </a>
              <a class="button-text">
                自行上传音频
              </a>
            </el-radio>
            <el-radio style="height: 80px; width: 230px"  label="1" border>
              <a style=" line-height: 60px;font-size: 24px">
                <i class='el-icon-s-custom button-icon' ></i>
              </a>
              <a class="button-text">
                人工声优配音
              </a>
            </el-radio>
            <el-radio style="height: 80px; width: 230px"  label="2" border>
              <a style=" line-height: 60px;font-size: 24px">
                <i class='el-icon-microphone button-icon' ></i>
              </a>
              <a class="button-text">
                智能机器配音
              </a>
            </el-radio>
          </el-radio-group>
        </el-col>
      </el-row>

      <el-row style="margin: 50px 0">
        <el-button style="width: 150px" size="medium" type="primary" @click="toMore">下一步</el-button>
      </el-row>

    </div>
  </div>
</div>
</template>


<script>
import stepLine from "@/components/VirtualWeb/stepLine";
import storeApi from "@/utils/store";

export default {
  name: "addDetail",
  components : {
    stepLine,
  },
  data() {
    return {
      duration: '',
      dubType: '',//2 机器配音  1  人工配音    0 自行上传配音
      videoData : null,
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
          type: "video/mp4",
          src: null //url地址

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
      },
    }

  },
  created() {
    var videoOrder = storeApi.get({
      name: 'videoOrder',
    }) || null;
    if (videoOrder === null || videoOrder === undefined) {
      this.$alert('请先选择视频基础需求', {
        confirmButtonText: '确定',
      }).then(
        this.goTo('/addOrder')
      );
    }
    else {
      this.videoData = videoOrder;
      this.playerOptions.sources[0].src = require(videoOrder.videoId);
      // console.log(this.playerOptions.sources[0].src);
    }
  },
  methods: {
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
    toMore(){
      if(this.duration === '' || this.duration === null){
        this.$alert('请先设置视频时长!', '提示', {
          confirmButtonText: '确定',
        });
      }else if(this.dubType === '' || this.dubType === null)
      {
        this.$alert('请先选择配音方式', '提示', {
          confirmButtonText: '确定',
        });
      }else{
        //保存视频时长
        storeApi.set({
          name: 'dubType',
          content: this.dubType,
          type: 'session'
        });
        storeApi.set({
          name: 'duration',
          content: this.duration,
          type: 'session'
        });
        switch (this.dubType){
          case "0": this.goTo('/uploadDub');break;
          case "1": this.goTo('/newProduct');break;
          case "2": this.goTo('/newProduct');break;
        }
      }
    }

 }
}

</script>

<style scoped lang='scss'>
@import '@/common/style.scss';
.addDetail{
  display:flex;
  justify-content:center;
  align-items: center;
  flex-direction: column;
  .my-video{
    width: 1200px;
  }
  .box{
    padding: 10px 60px;
    text-align: left;
    line-height: 50px;
    width: 100%;
  }
  .descriBlock{
    margin:50px 0;
    width:1200px;
    display:flex;
    flex-direction:column;
    justify-content: center;
    align-items: center;
    @include blockTitle();
    .startBar{
      width:100%;
      display:flex;
      justify-content: space-around;
      align-items: center;
      flex-direction: column;
      .setDuration{
        width:710px;
        display: flex;
        justify-content:flex-start
      }
      .setDubway{
        width:100%;
        .el-row{
          width:100%;
          display:flex;
          justify-content: center;
          align-items: center;
        }
        & ::v-deep .el-col.el-col-5{
          padding-left:0 !important;
          padding-right:0 !important;
          height:70%;
          display:flex;
          justify-content:center;
          align-items: center;
          .el-card{
            width:200px;
            height:250px;
            // margin:0 20px;
            font-size:16px;
            &:hover{
              cursor:pointer
            }
            & .el-card__header{
                color:whitesmoke;
                padding:16px 20px 0px 18px !important;
                border-bottom:none !important;
              i{
                border:1px solid $orange;
                border-radius: 50%;
                background-color: $orange;
                padding:10px;
              }
              i::before{
                font-size:60px
              }
          }
          & .el-card__body{
              padding:10px 20px 20px 25px
            }
          .cardTitle{
            margin:10px 0;

          }
          }

      }
      &::v-deep .el-row{
        height:100%
      }
    }
    }


  }

}

.videoPlayer {
  width: 1200px;
  margin-bottom: 30px;
  position: relative;
  display: inline-block;
  border: 1px solid transparent;
  //overflow: hidden;
  margin-right: 4px;
}
.button-icon{
  position: relative;
  top: 5px;
  margin-right: 5px;
  background-color: #909399;
  color: white;
  font-size: 28px;
  border-radius: 20%;
  padding: 5px;
}
.button-icon:focus{
  background-color: #ff5000;
}

.button-text{
  font-weight: 550;
  font-size: 16px;
  color: #909399
}
</style>
