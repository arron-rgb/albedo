<template>
<div class="selfDub">
    <div class="descriBlock">
        <el-steps class="directStep" :active="this.$store.state.dubActive" finish-status="success" simple style="margin-top: 20px">
        <el-step title="上传录音" ></el-step>
        <el-step title="添加水印" ></el-step>
        <el-step title="等待结果" ></el-step>
        </el-steps>
    <div class="proBlock">
      <router-view></router-view>
    </div>
  </div>
</div>
</template>
<style lang="scss" scoped>
@import '@/common/style.scss';
.selfDub{
    width:100%;
    display:flex;
    justify-content: center;
    align-items: center;
}
.descriBlock{
    margin:50px 0;
    width:1200px;
    display:flex;
    flex-direction:column;
    justify-content: center;
    align-items: center;
    .directStep{
      width:100%;
      margin-bottom:20px
    }
    ::v-deep .el-steps--simple{
      margin-top:0 !important
    }
    .proBlock{
        width:100%;
        height:100%;
        display:flex;
        justify-content:flex-start;
        align-items: center;
        flex-direction: column;
        border:2px dashed #ccc;
        box-sizing: border-box;
    }
} 
</style>