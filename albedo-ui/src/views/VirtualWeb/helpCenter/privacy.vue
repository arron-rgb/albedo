<template>
    <div class='taobaoGuide'>
<!--       <div class='pageTitle'>使用协议</div>-->
<!--      <div v-html="this.html"></div>-->
      <iframe style="width: 100%; height: 500px; border: none" :src="this.agreement"></iframe>
    </div>
</template>
<style lang="scss" scoped>
@import '@/common/style.scss';
    .taobaoGuide{
        @include guideStyle;
    }

</style>
<script>
import storeApi from "@/utils/store";
import axios from 'axios'
export default {
  data(){
    return{
      agreement : '',
      html : '',
    }
  },
  created() {
    var list = storeApi.get({ name: 'staticData' });//获得所有的静态资源list
    var dataIndex;
    dataIndex = list.findIndex(o => o.label === '隐私政策');
    this.agreement = 'https://' + list[dataIndex].value;

  },
  methods: {

  }
}
</script>
