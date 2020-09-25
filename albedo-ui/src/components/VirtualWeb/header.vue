<template>
  <div id="banner" v-show='$route.meta.showHeader'>
    <el-menu :default-active="$route.path" router id="banner_container" active-text-color="#ff5000" mode="horizontal">
      <!--      <el-menu-item index="logo">-->
      <el-link :underline="false" index="logo" type="text" id="logo" @click = "goTo('/')">
        <img :src="logo_src" alt="Vue logo" style="height: 50px; margin: 5px 0 ">
      </el-link>
      <!--      </el-menu-item>-->
      <el-menu-item index="addOrder">
        虚拟直播服务
      </el-menu-item>
      <el-menu-item index="proService">
        企业版
      </el-menu-item>
      <el-menu-item index="contactUs ">
        联系我们
      </el-menu-item>

      <template>
        <div  v-show='!$store.getters.loginSuccess'>
          <div class="sign" index="sign-in">
            <el-button style="width: 90px;background-color: #ff5000;color: white" @click="goTo('login')">登录</el-button>
          </div>
          <div style="float: right; margin-right: 10px" index="sign_up">
            <el-link :underline="false" style="color: #909399;line-height: 60px" type="text" @click="goTo('login', 'toRegister')">
              <a class="sign-up">注册</a>
            </el-link>
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
            <el-menu-item index="memberCenter" v-show="this.$store.getters.user.userType !== '1'">会员中心</el-menu-item>
            <el-menu-item index="myOrder">我的订单</el-menu-item>
            <el-menu-item index="myReceipt">开取发票</el-menu-item>
            <el-menu-item index="historyReceipt">我的发票</el-menu-item>
<!--            <el-menu-item index="security">安全中心</el-menu-item>-->
            <el-menu-item @click="open">退出登录</el-menu-item>
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
      logo_src: 'http://static.vlivest.com/dfc7b86a7d1f3be3b8b7ea580f0936c6.png',
    }
  },
  methods: {
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {func: data}});
    },
    open() {
      this.$confirm('确定注销并退出系统吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        cancelButtonClass: 'cancel-btn',
        type: 'warning'
      }).then(() => {
        this.logout()
      })
    },
    logout() {
      this.$store.dispatch('LogOut').then(() => {
        this.$router.push({path:'/'});
      })
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
  z-index: 10;
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
  margin-left: 10px;
  line-height: 60px;
}
.sign-up:hover{
  color: #ff5000;
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
.cancel-btn{
  color: #ff5000 !important;
  background-color: rgba(255, 80, 0, 0.1) !important;
}

</style>
