<template>
<div>
  <h2 style="margin-bottom: 50px">工作人员正在加班制作中，请耐心等候……</h2>
  <img src="http://www.zf3d.com/bjqasdasd3f5gt454/ewebeditor/shangchuan/2015/12/16/url_image/20151216094648673.gif">
</div>
</template>

<script>
import storeApi from "@/utils/store";

export default {
  name: "waiting",
  data() {
    return {

    }
  },
  created() {
    var videoOrder = storeApi.get({
      name: 'videoOrder',
    }) || null;
    if (videoOrder === null || videoOrder === undefined) {
      this.$alert('请先选择视频基础需求', {
        confirmButtonText: '确定',
      }).then(
        this.goTo('/addOrder')
      );
    }
  }
}
</script>

<style scoped>

</style>
