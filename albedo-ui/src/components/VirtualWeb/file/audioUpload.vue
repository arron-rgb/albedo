<template>
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
        :before-upload="beforeUpload"
        :auto-upload="false"
        :multiple="false"
        :on-change="onUploadChange"
        drag>
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <div class="el-upload__tip" slot="tip">格式支持：mp3,且不超过200MB</div>
      </el-upload>
    </div>
    <aplayer style="margin:  auto" v-if="this.url !== ''"
             :music="{
                  title: this.name,
                  artist: '请试听',
                  src: this.url,
                  theme: '#ff5000'
                }"
    />
    <el-button type="primary" style="margin-top: 20px" :loading="loading"  @click="next">提交音频</el-button>

    <!--遮罩层-->
    <div class="loading" v-if="loading" >
      <h4 class="tips">{{tips}}</h4>
      <!--进度条-->
      <el-progress type="line" :percentage="percentage" color="#ff5000" class="progress" :show-text="true"></el-progress>
    </div>
    <!--上传完成提示对话框-->
<!--    <el-dialog-->
<!--      title="提示"-->
<!--      :visible="dialogVisible"-->
<!--      width="30%"-->
<!--      :modal-append-to-body='false'-->
<!--    >-->
<!--      <span>{{tips}}</span>-->
<!--      <span slot="footer" class="dialog-footer">-->
<!--        <el-button type="primary" @click="ensure">确 定</el-button>-->
<!--      </span>-->
<!--    </el-dialog>-->
  </div>
</template>

<script>
import dubOperate from "@/components/VirtualWeb/addDetail/machineDub/dub-service";
import {MSG_TYPE_SUCCESS} from "@/const/common";
import axios from 'axios'
import crudOrder from "@/views/biz/order/order-service";
import aplayer from 'vue-aplayer'
import storeApi from "@/utils/store";

export default {
  name: "audioUpdate",
  data(){
    return {
      url : '',
      name : '',
      loading : false,
      videoId : '',
      percentage:0,
      tips:'',
      // dialogVisible:false,
      state : 0,
    }
  },
  components :{
    aplayer
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
      this.videoId = orderData.id;
    }
  },
  methods :{
    next() {//上传音频
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
      this.tips = '正在上传中……';
    },
    beforeUpload(file){
      let fd = new FormData();
      fd.append('file', file);
      let config = {
        onUploadProgress: progressEvent => {
          //progressEvent.loaded:已上传文件大小
          //progressEvent.total:被上传文件的总大小
          let complete = (progressEvent.loaded / progressEvent.total ).toFixed(2) * 100 ;
          this.percentage = complete;
        },
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      };

      axios.post('/a/file/upload',fd,config)
        .then((res)=>{
          // console.log(res);
          if(res.data.code === MSG_TYPE_SUCCESS) {//文件上传成功
            this.saveAudio(res.data.data.url);
            this.$notify({
              message: '文件上传成功！',
            });
          }
        })
        .catch((err)=>{
          this.$notify({
            message: '文件上传失败，请稍后重试！',
          });
        })
    },
    ensure(){
      this.dialogVisible = false;
      this.loading = false;
    },
    onUploadChange(file) {//检查文件是否合法

      this.name = file.name;
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
    // uploadAud(file) {//上传文件
    //   var _this = this
    //   let config = {
    //     onUploadProgress: progressEvent => {
    //       //progressEvent.loaded:已上传文件大小
    //       //progressEvent.total:被上传文件的总大小
    //       let complete = (progressEvent.loaded / progressEvent.total ).toFixed(2) * 100 ;
    //       this.percentage = complete;
    //       if (this.percentage >= 100){
    //         this.dialogVisible = true
    //       }
    //     },
    //     headers: {
    //       'Content-Type': 'multipart/form-data'
    //     }
    //   };
    //   console.log('fdasdfa');
    //   return new Promise((resolve, reject) => {
    //     dubOperate.uploadFile(file, config).then(res => {
    //       if (res.code === MSG_TYPE_SUCCESS) {
    //         //音频上传成功，二次保存订单
    //         console.log(res.data.url);
    //         this.saveAudio(res.data.url);
    //       }
    //     }).catch(error => {
    //       this.loading = false;
    //       reject(error)
    //     })
    //   });
    // },
    saveAudio(url){
      var data = {
        orderId : this.videoId,//视频订单id
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
.uploadContainer{
  width: 80%;
  margin: auto;
}

.loading{
  position: absolute;
  left: 0;
  top: 0;
  right: 0;
  bottom: 0;
  background: black;
  opacity: 0.8;
}
.progress{
  width: 200px;
  height: 200px;
  position: absolute;
  top: 50%;
  left: 50%;
  margin-left: -100px;
  margin-top: -100px;
}
.tips{
  color: white;
  position: absolute;
  top: 50%;
  left: 50%;
  margin-left: -100px;
  margin-top: -150px;
}
</style>
