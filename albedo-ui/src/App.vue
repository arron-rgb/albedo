<template>
  <div id="app">
    <my-header></my-header>
    <div id="v-content" v-bind:style="{minHeight: Height+'px'}"><router-view /></div>
    <my-footer></my-footer>
  </div>
</template>

<script>
import myHeader from '@/components/VirtualWeb/header'
import myFooter from '@/components/VirtualWeb/footer'

export default {
  name: 'App',
  components: {
    myHeader,
    myFooter
  },
  data() {
    return {
      Height: 0
    }
  },
  mounted(){
    //动态设置内容高度 让footer始终居底   header+footer的高度是100
    this.Height = document.documentElement.clientHeight - 300;
    window.onresize = ()=> {this.Height = document.documentElement.clientHeight -300};
  }
}
</script>
<style>
/*@import  '@/common/VirtualWeb/reset.css';*/
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}
body{
  margin: 0;
}
</style>
