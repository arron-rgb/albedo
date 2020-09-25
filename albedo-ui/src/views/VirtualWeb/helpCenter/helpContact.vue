<template>
<div class='helpContact'>
  <el-row class="tac">
    <el-col :span="6">
      <el-menu
        :default-active="$route.path"
        router
        class="el-menu-vertical-demo"
        @open="handleOpen"
        @close="handleClose">
        <el-submenu>
            <template slot="title">快速入门</template>
            <el-menu-item index="siteGuide">网站指南</el-menu-item>
<!--            <el-menu-item index="taobaoGuide">淘宝直播指南</el-menu-item>-->
        </el-submenu>
        <el-menu-item index="problems">
          <span slot="title">常见问题</span>
        </el-menu-item>
        <el-menu-item index="contactUs">
          <span slot="title">联系我们</span>
        </el-menu-item>
      </el-menu>
    </el-col>
    <el-col :span="16" class='showText'>
      <router-view></router-view>
    </el-col>
  </el-row>
</div>

</template>

<script>
export default {
  name: "helpContact",
  data(){
    return {

    }
  },
  methods: {
    handleOpen(key, keyPath) {
      console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    }
  }
}
</script>

<style lang='scss' scoped>
.helpContact{
  .el-menu-vertical-demo {
    box-shadow: 1px 1px 20px rgba(0,0,0,0.1);
    height: 600px;
  }
  width:1200px;
  margin: auto;
  box-sizing: border-box;
  .tac{
    .el-col-6{
      margin-left:30px;
    }
    padding:20px 0 80px 0;
    //background-color:rgb(245,247,249);
    .el-menu{
      border-right:none;
    }
  ::v-deep .el-submenu .el-menu-item{
    font-size:12px;
    color:#7d7d7d;
  }
  .showText{
    margin-left:20px;
    background-color:white;
    box-shadow: 1px 1px 20px rgba(0,0,0,0.1);
    height: 600px;
  }
 }


}


</style>
