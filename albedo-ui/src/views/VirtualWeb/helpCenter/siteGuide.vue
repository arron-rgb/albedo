<template>
    <div class='siteGuide'>
       <div class='pageTitle' v-if="data === ''">网站指南</div>
      <iframe :src="this.data" style="width: 100%; height: 500px; border: none" v-else></iframe>
    </div>
</template>

<script>
import storeApi from "@/utils/store";
export default {
  data(){
    return{
      data : '',
    }
  },
  created() {
    var list = storeApi.get({ name: 'staticData' });//获得所有的静态资源list
    var dataIndex;
    dataIndex = list.findIndex(o => o.label === '网站指南');
    if(dataIndex !== -1)
      this.data = 'https://' + list[dataIndex].value;
  },
  methods: {

  }
}
</script>
<style lang="scss" scoped>
@import '@/common/style.scss';
    .siteGuide{
        @include guideStyle;
    }
</style>
