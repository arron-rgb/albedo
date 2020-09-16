<template>
  <div class="container">
    <el-steps :active="$route.meta.stepLine" align-center>
      <el-step title="需求定位"></el-step>
      <el-step title="支付订单"></el-step>
      <el-step title="等待制作"></el-step>
      <el-step title="作品完善"></el-step>
      <el-step title="查看结果"></el-step>
    </el-steps>
  </div>
</template>

<script>
import storeApi from '@/utils/store'
export default {
  name: "stepLine",
  data(){
    return {
      active:storeApi.get({
        name: 'orderState'
      }),
    }
  },
  created() {
    // var state =
    // this.active = state;
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
