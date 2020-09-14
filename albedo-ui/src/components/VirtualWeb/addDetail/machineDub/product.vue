<template>
<div class="product">
  <el-row>
    <el-col span="8">
      <el-upload
        ref="upload"
        class="avatar-uploader"
        action="#"
        :http-request="uploadImg"
        accept="image/jpeg,image/png"
        :show-file-list="false"
        :auto-upload="false"
        :multiple="false"
        :on-change="onUploadChange"
      >
        <img v-if="imageUrl" :src="imageUrl" class="avatar">
        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
      </el-upload>
    </el-col>
    <el-col span="16">
<!--      {{this.imageUrl}}-->
      <el-form label-width="80px">
        <el-form-item label="商品名称">
          <el-input type="text" v-model="data.name"></el-input>
        </el-form-item>
        <el-form-item label="商品描述">
          <el-input type="textarea" :rows="5"  v-model="data.description"></el-input>
        </el-form-item>
      </el-form>
    </el-col>
  </el-row>
  <el-row>
    <el-col offset="10">
      <el-button :loading="loading" type="primary" @click="upload">保存</el-button>
    </el-col>
  </el-row>
<!--    <el-upload-->
<!--    :class="{disabled:uploadDisabled}"-->
<!--    :on-success="handleAvatarSuccess"-->
<!--    :on-change="handleChange"-->
<!--    :on-remove="handleRemove"-->
<!--    :file-list="fileList"-->
<!--    :limit="1"-->
<!--    :on-exceed="exceed"-->
<!--    action="#"-->
<!--    list-type="picture-card"-->
<!--    :auto-upload="false">-->
<!--      <i slot="default" class="el-icon-plus"></i>-->
<!--      <div slot="file" slot-scope="{file}">-->
<!--        <img-->
<!--          class="el-upload-list__item-thumbnail"-->
<!--          :src="file.url" alt=""-->
<!--        >-->
<!--        <span class="el-upload-list__item-actions">-->
<!--          <span-->
<!--            class="el-upload-list__item-preview"-->
<!--            @click="handlePictureCardPreview(file)"-->
<!--          >-->
<!--            <i class="el-icon-zoom-in"></i>-->
<!--          </span>-->
<!--          <span-->
<!--            v-if="!disabled"-->
<!--            class="el-upload-list__item-delete"-->
<!--            @click="handleDownload(file)"-->
<!--          >-->
<!--            <i class="el-icon-download"></i>-->
<!--          </span>-->
<!--          <span-->
<!--            v-if="!disabled"-->
<!--            class="el-upload-list__item-delete"-->
<!--            @click="handleRemove(file)"-->
<!--          >-->
<!--            <i class="el-icon-delete"></i>-->
<!--          </span>-->
<!--        </span>-->
<!--      </div>-->
<!--    </el-upload>-->
<!--      <el-dialog :visible.sync="dialogVisible">-->
<!--        <img width="100%" :src="dialogImageUrl" alt="">-->
<!--      </el-dialog>-->
    </div>

</template>
<script>
import dubOperate from "./dub-service"
import {MSG_TYPE_SUCCESS} from "@/const/common";
export default {
  props:['productData'],
  data(){
      return{
        loading : false,
        imageUrl: '',
        uploadUrl: '',
        // 隐藏加号
        // fileList:[],
        // uploadDisabled:false,
        // dialogVisible: false,
        // addPicture:!this.dialogVisible,
        // disabled: false,
        // dialogImageUrl:'',
        // productData:{
        // proTitle:'',
        // proDescription:'',
        data:{
          urls : '',
          name : '',
          description : '',
        }
        //   profileList:''
          // proTitle:this.item.proTitle,
          // proDescription:this.item.proDescription,
          // profileList:this.item.profileList
        // }

      }
  },
  methods:{
    onUploadChange(file){
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
        _this.imageUrl = e.target.result;
      }

    },
    uploadImg(file){
      var _this = this
      return new Promise((resolve, reject) => {
        dubOperate.uploadFile(file).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            _this.data.urls = res.data.url
            this.saveProduct()
          }
        }).catch(error => {
          this.loading = false;
          reject(error)
        })
      });
    },
    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    },
    upload(){
      if(this.imageUrl === ''){
        this.$message.error('请上传图片！');
        return  false;
      }
      if(this.data.name === ''){
        this.$message.error('商品名称不能为空！');
        return ;
      }
      if(this.data.description === ''){
        this.$message.error('商品描述不能为空！');
        return ;
      }
      this.loading = true;
      //上传图片
      this.$refs.upload.submit()
    },
    saveProduct(){
      //保存商品
      return new Promise((resolve, reject) => {
        dubOperate.saveProduct(this.data).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            // 清空表单数据
            this.data.urls = '';
            this.data.name = '';
            this.data.description = '';
            this.imageUrl = '';
            //关闭对话框
            this.productData.dialogVisible = false;

            this.loading = false;
          }
        }).catch(error => {
          reject(error)
          this.loading = false;
        })
      })
    }
    // handleChange(file,fileList){
    //   this.fileList.push(file)
    //   if(fileList.length >= 1){
    //     this.uploadDisabled = true;
    //   }
    //   this.productData.profileList=this.fileList
    //   this.commitData()
    // },
    //   handleRemove(file) {
    //   this.fileList.filter((item,index)=>{
    //     if (file === item){
    //       this.fileList.splice(index,1)
    //       this.productData.profileList=this.fileList
    //     }
    //   })
    //
    //   this.uploadDisabled = false
    // },
    //  exceed(){
    //       this.$message.error('每个商品最多上传1张图片哦！')
    // },
    // handlePictureCardPreview(file) {
    //   this.dialogImageUrl = file.url;
    //   this.dialogVisible = true;
    // },
    // commitData(){
    //   // 是否要修改
    //   this.item.ifModify=1
    //   this.item.profileList=this.productData.profileList
    //   this.item.proTitle=this.productData.proTitle
    //   this.item.proDescription=this.productData.proDescription
    //    // 点击保存将本次创建的商品信息传到父组件中
    //   this.$emit('saveData',this.item)
    // }
  },
  // mounted(){
    // if(this.item.profileList)
    // {
    //   this.fileList=this.item.profileList
    //   this.uploadDisabled = true
    // }
  // }
}
</script>
<style lang="scss" scoped>
.avatar-uploader{
  border: 1px dashed #d9d9d9 !important;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader:hover {
  border-color: #ff5000 !important;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
//.product{
//    width:100%;
//    height:180px;
//    display:flex;
//    padding:10px;
//    border-top:1px dashed #ebeef5;
//    justify-content: space-evenly;
//    align-items: center;
//    box-sizing: border-box;
//    .disabled ::v-deep.el-upload--picture-card{
//      display:none !important
//    }
//    .avatar-uploader{
//      .el-upload {
//        border: 1px dashed #d9d9d9;
//        border-radius: 6px;
//        cursor: pointer;
//        position: relative;
//        overflow: hidden;
//      }
//      .el-upload:hover {
//        border-color: #409EFF;
//      }
//      .avatar-uploader-icon {
//        font-size: 28px;
//        color: #8c939d;
//        width: 150px;
//        height: 150px;
//        line-height: 150px;
//        text-align: center;
//        border:2px dashed #d9d9d9
//
//      }
//      .avatar {
//        width: 178px;
//        height: 178px;
//        display: block;
//      }
//    }
//    .el-upload-list--picture-card .el-upload-list__item{
//      padding:0 !important;
//    }
//    .el-form-item:nth-child(2){
//        margin-bottom: 0;
//    }
//  }
</style>
