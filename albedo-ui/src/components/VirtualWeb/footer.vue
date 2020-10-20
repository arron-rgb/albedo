<template>
  <div class='footer'>

    <div class="footerContainer">
      <div class="footerBox">
        <div class="footerLeft">
          <el-row class='linkList' >
            <el-link :underline='false' @click="goTo('contactUs')" type='info'>联系我们</el-link>
            <el-link :underline='false' @click="goTo('agreement')" type='info'>使用协议</el-link>
            <el-link :underline='false' @click="toBackend" type='info'>员工入口</el-link>

          </el-row>
          <el-row style="text-align: left;">
            <span style="margin-left: 105px">Copyright © 2019-2020 杭州葳锐信息科技有限公司版权所有</span>
          </el-row>
        </div>
        <div class="footerRight">
          <img class='QRCode' :src="QRCode" alt="">
          <span>微信扫一扫 - 联系我们</span>
        </div>
      </div>
    </div>

    <div class="footerBox">
      <div class="authority">

        <img class='policeIcon' :src="policeIcon" alt="">
        <span>浙ICP备2020031611号</span>
      </div>
    </div>
  </div>

</template>
<script>
import storeApi from "@/utils/store";
import store from "@/store";

export default {
  data(){
    return {
      QRCode:'http://static.vlivest.com/327e84ea1ab73cae84d0c4d293b8e31a.jpg',
      policeIcon:require('@/assets/VirtualWeb/footerBar/img/policeIcon.jpg')

    }

  },
  created() {
    var list = storeApi.get({ name: 'staticData' });//获得所有的静态资源list
    var dataIndex = list.findIndex(o => o.label === '底部二维码');
    this.QRCode = 'https://' + list[dataIndex].value;

  },
  methods :{
    toBackend(){
      if(store.getters.loginSuccess) {//已登录
        if (store.state.user.user.roleNames === '个人用户' || store.state.user.user.roleNames === '企业管理员' || store.state.user.user.roleNames === '企业普通用户') {
          this.$alert('该入口仅员工账户可进！！', '提示', {
            confirmButtonText: '确定'
          });
        } else {
          this.goTo('/user/center')
        }
      }
      else{
        this.$alert('请先登录！', '提示', {//未登录则需先登录
          confirmButtonText: '确定',
          callback: action => {
            this.goTo('/login');
          }
        });
      }
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {func: data}});
    },
  }

}
</script>
<style scoped lang='scss'>
//@import  '@/common/reset.css';
//@import '@/common/style.scss';
.footer{
  width: 100%;
  height:240px;
  font-size: 13px;
  color:#7d7d7d;
  display:flex;
  justify-content: space-around;
  flex-direction: column;
  align-items: center;
  // background-color: $light-orange;
  /* letter-spacing: 1px; */
}
.footerBox{
  width: 1200px !important;
  margin: auto;
  text-align: center;
  align-items: center;
}
.footerContainer{
  // background-color: $light-orange;
  width:100%;
  margin: auto;
  height:100%;
  padding: 10px 40px;
  //display:flex;
  //justify-content: space-around;
  //align-items: center;
  border-top:1px  solid #ccc;
  border-bottom:1px  solid #ccc

}
.footerLeft{
  float: left;
  //padding: 30px;
  //display:flex;
  width: 600px;
  margin-right: 200px;
  //justify-content: space-around;
  //flex-direction: column;
  //align-items: flex-start;

}
.linkList{
  width:100%;
  display:flex;
  justify-content: space-between;
  align-items: center;
  margin:50px 0 30px 0;

}
.footerRight{
  display:flex;
  justify-content: space-around;
  flex-direction: column;
  align-items: center;
}
.QRCode{
  width:120px;
  height:120px;
}
.authority{
  margin:20px auto;
  //display:flex;
  //justify-content: space-between;
  align-items: center;

}
.policeIcon{
  margin:0 5px
}

</style>
