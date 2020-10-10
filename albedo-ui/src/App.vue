<template>
  <div id="app">
    <my-header></my-header>
    <div id="v-content" v-bind:style="{minHeight: Height+'px'}">
      <router-view/>
    </div>
    <my-footer></my-footer>
  </div>
</template>

<script>
import myHeader from '@/components/VirtualWeb/header'
import myFooter from '@/components/VirtualWeb/footer'
import data from "@/api/data";
import {MSG_TYPE_SUCCESS} from "@/const/common";
import storeApi from "@/utils/store";

export default {
  name: 'App',
  components: {
    myHeader,
    myFooter
  },
  data() {
    return {
      Height: 0,
      show: 0
    }
  },
  beforeCreate() {
    return new Promise((resolve, reject) => {
      data.staticsData('source').then(res => {
        if (res.code === MSG_TYPE_SUCCESS) {
          // console.log(res.data);
          storeApi.set({
            name: 'staticData',
            content: res.data.source,
            type: 'session'
          });
          resolve()
        }
      }).catch(error => {
        reject(error)
      })

      data.staticsData('biz').then(res => {
        if (res.code === MSG_TYPE_SUCCESS) {
          // console.log(res.data);
          storeApi.set({
            name: 'priceData',
            content: res.data.biz,
            type: 'session'
          });
          resolve()
        }
      }).catch(error => {
        reject(error)
      })
      this.show = 1;
      setTimeout({}, 500);
    })

  },
  mounted() {
    // this.getStaticsData();
    //动态设置内容高度 让footer始终居底   header+footer的高度是100
    this.Height = document.documentElement.clientHeight - 300;
    window.onresize = () => {
      this.Height = document.documentElement.clientHeight - 300
    };
  },
  methods: {
    getStaticsData() {
      return new Promise((resolve, reject) => {
        data.staticsData('source').then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res.data);
            storeApi.set({
              name: 'staticData',
              content: res.data.source,
              type: 'session'
            });
            resolve()
          }
        }).catch(error => {
          reject(error)
        })

        data.staticsData('biz').then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res.data);
            storeApi.set({
              name: 'priceData',
              content: res.data.biz,
              type: 'session'
            });
            resolve()
          }
        }).catch(error => {
          reject(error)
        })
        this.show = 1;
      })
    }
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

body {
  margin: 0;
}
</style>
