<template>
  <div id="app">
    <my-header></my-header>
    <div id="v-content" v-bind:style="{minHeight: Height+'px'}">
      <router-view v-if="this.show === 1"/>
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
    var source;
    return new Promise((resolve, reject) => {
      data.staticsData('source').then(res => {
        if (res.code === MSG_TYPE_SUCCESS) {
          // console.log(res.data);
          source = res.data.source;
          storeApi.set({
            name: 'staticData',
            content: res.data.source,
            type: 'session'
          });
          this.show = 1;
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
      // setTimeout({}, 500);
      //  this.show = 1;
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
<style lang="scss">
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

.el-tabs__item:hover{
  color: #ff5000 !important;
}

.el-tabs__item.is-active{
  color: #ff5000 !important;
}
.el-tabs__active-bar {
  background-color: #ff5000 !important;
}

.el-button:hover{
  background-color: rgba(255, 80, 0, 0.1) ;
  color: #ff5000 ;
  border-color: rgba(255, 80, 0, 0.1)
}
.el-button:focus{
  background-color: rgba(255, 80, 0, 0.1);
  color: #ff5000;
  border-color: rgba(255, 80, 0, 0.1);
}

//修改el-button默认的样式
.el-button--primary{
  background-color: #ff5000 !important;
  color: white !important;
  border-color: #ff5000!important;
}
.el-button--primary:hover{
  background-color: #ff5000 !important;
  border-color: #ff5000 !important;
  color: white !important;
}
.el-button--primary:focus{
  background-color: #ff5000 !important;
  color: white !important;
  border-color: #ff5000 !important;
}

//修改el-radio默认样式
.el-radio-button{
  margin: 5px!important;
  margin-bottom: 10px!important;
}
.el-radio-button__inner{
  border: 1px solid #DCDFE6 !important;
  border-radius: 4px !important;
  padding: 2px !important;
}
.el-radio-button__inner:hover{
  background-color: rgba(255, 237, 229, 0.4)!important;
  color: #ff5000!important;
  border-color: #ff5000 !important;
}

.el-radio-button__orig-radio:checked+.el-radio-button__inner{
  color: white !important;
  background-color: #ff5000 !important;
  border-color: #ff5000 !important;
  box-shadow: none !important;
}
//修改el-check-button样式
.el-checkbox-button{
  margin: 5px !important;
}
.el-checkbox-button__inner{
  border: 1px solid #DCDFE6 !important;
  border-radius: 4px !important;
  padding: 2px !important;
}
.el-checkbox-button__inner:hover{
  background-color: rgba(255, 237, 229, 0.4) !important;
  color: #ff5000 !important;
  border-color: #ff5000 !important;
}
.el-checkbox-button.is-checked .el-checkbox-button__inner{
  background-color: #ff5000 !important;
  color: white !important;
  border-color: #ff5000 !important;
  box-shadow: none !important;
}


.el-radio.is-bordered.is-checked{
  border-color: #ff5000 !important;
}
.el-radio__input.is-checked .el-radio__inner{
  border-color: #ff5000 !important;
  background-color: #ff5000 !important;
}
.el-radio__input.is-checked+.el-radio__label{
  color: #ff5000 !important;
  .button-icon{
    background-color: #ff5000 !important;
  }
  .button-text{
    color: #ff5000 !important;
  }
}
.el-radio__inner:hover{
  border-color: #ff5000 !important;
  //background-color: #ff5000 !important;
}

.el-step__title.is-finish{//修改步骤条颜色
  color: #ff5000 !important;
}
.el-step__head.is-finish{
  color: #ff5000 !important;
  border: #ff5000 !important;
}
.el-menu-item:hover{
  color: #ff5000 !important;
}

//.el-input__inner:focus{
//  border: #ff5000 1px solid !important;
//}
//.el-input__inner:hover{
//  border: #ff5000 1px solid !important;
//}
//.el-input-number__increase:hover{
//  color: #ff5000;
//}
.el-input-number__decrease:hover{
  color: #ff5000 !important;
}
.el-textarea__inner:focus{
  border: #ff5000 1px solid !important;
}

.el-checkbox__input.is-checked+.el-checkbox__label{
  color: #ff5000 !important;
}
.el-checkbox__inner:hover{
  border-color: #ff5000 !important;
}
.el-checkbox__input.is-checked .el-checkbox__inner{
  background-color: #ff5000 !important;
  border-color: #ff5000 !important;
}
</style>
