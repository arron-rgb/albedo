<template>
<!-- 上传商品，添加图片，商品文字详情描述 -->
<div class="machineDub">
  <div class="descriBlock">
    <!--    步骤条-->
    <step-line></step-line>
    <div class="proBlock">
      <router-view></router-view>
    </div>
  </div>

</div>

</template>

<script>
import stepLine from "@/components/VirtualWeb/stepLine";

export default {
  name: "machineDub",
  components : {
    stepLine,
  },
}
</script>

<style lang="scss" scoped>
@import '@/common/style.scss';
.machineDub{
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
      display:flex;
      justify-content: center;
      align-items: center;
    }
}
</style>
