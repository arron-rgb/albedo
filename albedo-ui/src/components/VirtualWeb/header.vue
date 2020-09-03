<template>
  <div id="banner" v-show='$route.meta.showHeader'>
    <el-menu :default-active="$route.path" router id="banner_container" active-text-color="#ff5000" mode="horizontal">
      <!--      <el-menu-item index="logo">-->
      <el-button index="logo" type="text" id="logo" @click = "goTo('/')">
        <img alt="Vue logo" style="height: 60px" :src="logo_src">
      </el-button>
      <!--      </el-menu-item>-->
      <el-menu-item index="virtual_live">
        虚拟直播服务
      </el-menu-item>
      <el-menu-item index="proService">
        企业版
      </el-menu-item>
      <el-menu-item index="contact">
        联系我们
      </el-menu-item>

      <template>
        <div  v-show='!$store.getters.loginSuccess'>
          <div class="sign" index="sign_in">
            <el-button style="width: 90px;background-color: #ff5000;color: white" @click="makeChange">登录</el-button>
          </div>
          <div class="sign" index="sign_up">
            <el-button @click='$router.replace("/signupPage")' style="color: #909399" type="text">注册</el-button>
          </div>
        </div>
      </template>
      <template >
        <div v-show='$store.getters.loginSuccess' class='personal'>
          <el-submenu index="personal">
            <template slot="title">
              <i class='el-icon-s-custom'></i>
              <span @click='this.$router.replace("personal")'>我的</span>
            </template>
            <el-menu-item index="myData">个人资料</el-menu-item>
            <el-menu-item index="memberCenter">会员中心</el-menu-item>
            <el-menu-item index="myOrder">我的订单</el-menu-item>
            <el-menu-item index="myReceipt">我的发票</el-menu-item>
            <el-menu-item index="security">安全中心</el-menu-item>
            <el-menu-item @click='logOut'>退出登录</el-menu-item>
          </el-submenu>
        </div>
      </template>
    </el-menu>
  </div>
</template>
<script>
export default {
  name: 'banner',
  props: {
  },
  data()
  {
    return{
      logo_src: require('@/assets/VirtualWeb/logo.png'),
    }
  },
  methods: {
    goTo(url){
      //带参数跳转
      this.$router.push({path:url,query:{setid:123456}});
    },
    makeChange(){
      this.$router.push('pass')
    },
    logOut(){
      this.$store.commit('Login',0)
    }

  },
  mounted(){
    // console.log(this.$store.state.isLogin)
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang='scss'>
@import '@/common/style.scss';
#banner{
  width: 100%;
  height: 61px;
  border-bottom: solid 1px #e6e6e6;
  position: sticky;
  background-color: white;
  top: 0;
  z-index: 9999;
  #banner_container{
    max-width: 1200px;
    min-width: 700px;
    margin: auto;
    #logo
    {
      float: left;
      width: 150px;
      margin: 0 8px;
      height: 60px;
      padding: 0;
    }
  }
}
.sign{
  float: right;
  margin: 10px;
}

.personal{
  float:right;
  height:100%;
  display:flex;
  justify-content: center;
  align-items: center;
  i{
    width:30px;
    height:30px;
    border-radius: 50%;
    padding:5px;
    background-color: $bg_orange;
    color:white
  }
  .el-submenu{
    // width:100px;
    ::v-deep .el-submenu__title{
      padding:0 15px !important;
      &:hover{
        background: white;
      }
      .el-submenu__icon-arrow{
        right:0 !important
      }
      span{
        color:#7d7d7d
      }
    }

  }

  ::v-deep.el-menu--popup{
    min-width:93px !important;

  }


}

</style>
