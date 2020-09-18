<template>
    <div class="uploadDub">
        <div class="directBar">
            <h3>上传音频</h3>
            <el-button type="primary" :loading="loading"  @click="next">提交音频</el-button>
        </div>
        <div class="uploadContainer">
            <div class="uploadCard">
                <!-- <div class="uploadTitle">
                    上传配音
                </div> -->
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
                    <div class="el-upload__tip" slot="tip">格式支持：mp3,wav,pcm,m4,mp4,wma,且不超过2GB</div>
                </el-upload>
            </div>
        </div>

      <aplayer style="width: 800px; margin:  auto" v-if="url !== ''"
               :music="{
                  title: this.name,
                  artist: '请试听',
                  src: this.url,
                  theme: '#ff5000'
                }"
      />
    </div>
</template>
<script>
import dubOperate from "@/components/VirtualWeb/addDetail/machineDub/dub-service";
import {MSG_TYPE_SUCCESS} from "@/const/common";
import aplayer from 'vue-aplayer'
import storeApi from "@/utils/store";
import payOrder from "@/views/VirtualWeb/order/payOrder-server";
export default {
  data(){
    return{
      url: '',
      name: '',
      videoOrder: null,
      loading: false,
    }
  },
  components: {
    aplayer
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
      console.log(videoOrder);
      this.videoOrder = videoOrder;
    }
  },
  methods: {
      next() {
        this.loading = true;
        // 检查是否上传了音频
        // console.log(this.url);
        if(this.url === null || this.url === undefined || this.url === ''){
          this.$message.error('请先上传音频！');
          this.loading = false;
          return ;
        }
        // 调用上传方法
        this.$refs.upload.submit();
      },
      onUploadChange(file) {
        // console.log(file);
        this.name = file.name
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
      goTo(url, data) {
        //带参数跳转
        // console.log(data)
        this.$router.push({path: url, query: {data: data}});
      },
      uploadAud(file) {
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
    saveAudio(audioUrl){//提交支付请求
      console.log(this.videoOrder);
      var data = {
        orderId : this.videoOrder.id,
        type : 0,//配音方式  0上传   1下单   2合成
        audioUrl : audioUrl,
        time : storeApi.get({
          name: 'duration',
        }),
      }
      console.log(data);
      return new Promise((resolve, reject) => {
        payOrder.placeSecond(data).then((res) => {
          //订单保存成功，跳转等待页面
          // console.log(res)
          resolve();
          this.loading = false;
          //清除videoOrder
          storeApi.clear({
            name: 'videoOrder'
          });
          this.goTo('/addOrder');
        }).catch(error => {
          reject(error)
          this.loading = false;
        })
      })

    },
    },
}
</script>
<style lang="scss" scoped>
    .uploadDub{
        width:100%;
        .directBar{
            width:100%;
            padding:20px 40px;
            display:flex;
            justify-content: space-between;
            align-items: center;
        }
        .uploadContainer{
            width:100%;
            height:100%;
            display:flex;
            justify-content: space-around;
            align-items: flex-start;
            padding:20px 0;
            .uploadCard{
                display:flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;
                width:1000px;
                .upload-demo{
                    width:100%;
                    margin:0 50px;
                    ::v-deep .el-upload-dragger{
                        width:600px !important;
                    }
                }
            }
        }
    }
</style>
