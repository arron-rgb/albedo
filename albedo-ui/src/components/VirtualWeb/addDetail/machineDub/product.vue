<template>
<div class="product">
    <el-upload
    :class="{disabled:uploadDisabled}"
    :on-success="handleAvatarSuccess"
    :on-change="handleChange"
    :on-remove="handleRemove"
    :file-list="fileList"
    :limit="1"
    :on-exceed="exceed"
    action="#"
    list-type="picture-card"
    :auto-upload="false">
      <i slot="default" class="el-icon-plus"></i>
      <div slot="file" slot-scope="{file}">
        <img
          class="el-upload-list__item-thumbnail"
          :src="file.url" alt=""
        >
        <span class="el-upload-list__item-actions">
          <span
            class="el-upload-list__item-preview"
            @click="handlePictureCardPreview(file)"
          >
            <i class="el-icon-zoom-in"></i>
          </span>
          <span
            v-if="!disabled"
            class="el-upload-list__item-delete"
            @click="handleDownload(file)"
          >
            <i class="el-icon-download"></i>
          </span>
          <span
            v-if="!disabled"
            class="el-upload-list__item-delete"
            @click="handleRemove(file)"
          >
            <i class="el-icon-delete"></i>
          </span>
        </span>
      </div>
    </el-upload>
      <el-dialog :visible.sync="dialogVisible">
        <img width="100%" :src="dialogImageUrl" alt="">
      </el-dialog>

      <el-form :model="productData" label-width="80px">
        <el-form-item label="商品名称">
          <el-input type="text" v-model="productData.proTitle" @input="commitData"></el-input>
        </el-form-item>
        <el-form-item label="商品描述">
          <el-input type="textarea" v-model="productData.proDescription"  @input="commitData"></el-input>
        </el-form-item>
      </el-form>
    </div>

</template>
<script>
export default {
  props:['item'],
  data(){
      return{
        // 隐藏加号
        fileList:[],
        uploadDisabled:false,
        dialogVisible: false,
        addPicture:!this.dialogVisible,
        disabled: false,
        dialogImageUrl:'',
        productData:{
          proTitle:this.item.proTitle,
          proDescription:this.item.proDescription,
          profileList:this.item.profileList
        }
      }
  },
  methods:{
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
    handleChange(file,fileList){
      this.fileList.push(file)
      if(fileList.length >= 1){
        this.uploadDisabled = true;
      }
      this.productData.profileList=this.fileList
      this.commitData()
    },
      handleRemove(file) {
      this.fileList.filter((item,index)=>{
        if (file === item){
          this.fileList.splice(index,1)
          this.productData.profileList=this.fileList
        }
      })
      
      this.uploadDisabled = false
    },
     exceed(){
          this.$message.error('每个商品最多上传1张图片哦！')
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    commitData(){
      // 是否要修改
      this.item.ifModify=1
      this.item.profileList=this.productData.profileList
      this.item.proTitle=this.productData.proTitle
      this.item.proDescription=this.productData.proDescription
       // 点击保存将本次创建的商品信息传到父组件中
      this.$emit('saveData',this.item)
    }
  },
  mounted(){
    if(this.item.profileList)
    {
      this.fileList=this.item.profileList
      this.uploadDisabled = true
    }
  }
}
</script>
<style lang="scss" scoped>
.product{
    width:100%;
    height:180px;
    display:flex;
    padding:10px;
    border-top: 2px dashed #ccc; 
    justify-content: space-evenly;
    align-items: center;
    box-sizing: border-box;
    .disabled ::v-deep.el-upload--picture-card{
      display:none !important
    }
    .avatar-uploader{
      .el-upload {
        border: 1px dashed #d9d9d9;
        border-radius: 6px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
      }
      .el-upload:hover {
        border-color: #409EFF;
      }
      .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 150px;
        height: 150px;
        line-height: 150px;
        text-align: center;
        border:2px dashed #d9d9d9

      }
      .avatar {
        width: 178px;
        height: 178px;
        display: block;
      }
    }
    .el-upload-list--picture-card .el-upload-list__item{
      padding:0 !important;
    }
    .el-form-item:nth-child(2){
        margin-bottom: 0;
    }
  }
</style>