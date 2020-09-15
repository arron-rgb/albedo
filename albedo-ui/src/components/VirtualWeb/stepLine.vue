<template>
  <div class="container">
    <el-steps :active="active" align-center>
      <el-step title="需求定位"></el-step>
      <el-step title="支付订单"></el-step>
      <el-step title="等待制作"></el-step>
      <el-step title="作品完善"></el-step>
      <el-step title="查看结果"></el-step>
    </el-steps>
  </div>
</template>

<script>
import {mapGetters} from 'vuex'
export default {
  name: "stepLine",
  data(){
    return {
      active:0,
    }
  },
  created() {
    this.$store.getters.user.userType
  }
}
</script>

<style scoped>
.container{
  width: 1200px;
  margin: auto;
  padding: 30px 0;
}
</style>
