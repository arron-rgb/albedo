<template>
    <div class='problems'>
      <div class='pageTitle' v-if="data === 'https://'">常见问题</div>
      <iframe v-else style="width: 100%; height: 500px; border: none" :src="this.data"></iframe>
    </div>
</template>
<script>
import Script from "@/views/biz/script/index";
import storeApi from "@/utils/store";
export default {
  components: {Script},
  data(){
    return{
      data : '',
    }
  },
  created() {
    var list = storeApi.get({ name: 'staticData' });//获得所有的静态资源list
    var dataIndex;
    dataIndex = list.findIndex(o => o.label === '常见问题');
    if(dataIndex !== -1)
      this.data = 'https://' + list[dataIndex].value;
  },
  methods: {

  }
}
</script>
<style lang="scss" scoped>
@import '@/common/style.scss';
    .problems{
        @include guideStyle;
    }
</style>
