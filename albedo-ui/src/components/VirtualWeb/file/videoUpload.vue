<template>
  <div class="uploadContainer">
    <el-upload
      :auto-upload="false"
      :data="{ orderId : this.videoId}"
      :file-list="fileList"
      :on-change="onUploadChange"
      :on-success="uploadSussess"
      action="/a/biz/order/upload"
      class="upload-demo"
      drag
      multiple
      ref="upload">
      <i class="el-icon-upload"></i>
      <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
      <div class="el-upload__tip" slot="tip">只能上传mp4文件，且不超过4GB</div>
    </el-upload>
    <el-button @click="submitUpload" size="small" style="margin-left: 10px;" type="primary">上传到服务器</el-button>
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
  name: "videoUpload",
  data(){
    return {
      videoId : '',
      fileList: [],

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
      this.videoId = orderData.id;
    }
  },
  methods :{
    submitUpload() {
      this.$refs.upload.submit();
    },
    onUploadChange(file) {//检查文件是否合法

      this.name = file.name;
      const isIMAGE = (file.raw.type === 'video/mp4');
      const isLt1M = file.size / 1024 / 1024 / 1024 < 4;

      if (!isIMAGE) {
        this.$message.error('只能上传mp4格式的视频！');
        return;
      }
      if (!isLt1M) {
        this.$message.error('上传文件大小不能超过4GB！');
        return;
      }
    },
    uploadSuccess(key){
      this.$alert('视频上传成功，辛苦了！', '提示',{
        confirmButtonText: '确定',
        callback: action => {
          this.goTo('/order/order')
        }
      });
    },
    goTo(path){
      this.$router.push({path: path});
    }
  }
}
</script>

<style scoped>
.uploadContainer{
  width: 80%;
  margin: 20px auto;
  text-align: center;
}
</style>
