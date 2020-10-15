<template>
  <div class="body">
    <el-image :src="this.url" />
  </div>
</template>

<script>
import storeApi from "@/utils/store";

export default {
  name: "train",
  data (){
    return{
      url: ''
    }
  },
  mounted() {
    var list = storeApi.get({ name: 'staticData' });//获得所有的静态资源list

    console.log(list);

    var dataIndex;
    dataIndex = list.findIndex(o => o.label === '代播培训');
    this.url = 'https://' + list[dataIndex].value;
  }
}
</script>

<style scoped>
.body{
  width: 1200px;
  margin: auto;
}
</style>
