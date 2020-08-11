<template>
  <div class="login">
    <el-form
      ref="loginForm"
      :model="loginForm"
      :rules="loginRules"
      class="login-form"
      label-position="left"
      label-width="0px"
    >
      <h3 class="title">
        Albedo 快速开发框架
      </h3>

      <el-form-item prop="username">
        <el-input v-model="loginForm.username" auto-complete="off" placeholder="账号" type="text">
          <svg-icon slot="prefix" class="el-input__icon input-icon" icon-class="user"/>
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          :type="passwordType"
          auto-complete="off"
          placeholder="请输入密码"
          size="small"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" class="el-input__icon input-icon" icon-class="password"/>
          <svg-icon slot="suffix" class="el-input__icon input-icon" icon-class="eye" @click="showPassword"/>
        </el-input>
      </el-form-item>
      <el-form-item prop="code">
        <el-input
          v-model="loginForm.code"
          :maxlength="codeLength"
          :minlength="codeLength"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" class="el-input__icon input-icon" icon-class="validCode"/>
        </el-input>
        <div class="login-code">
          <img :src="codeUrl" @click="refreshCode">
        </div>
      </el-form-item>
      <el-checkbox v-model="loginForm.rememberMe" style="margin:0 0 25px 0;">
        记住我
      </el-checkbox>
      <el-form-item>
        <el-button
          :loading="loading"
          type="primary"
          @click.native.prevent="handleLogin"
        >
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
        <el-button
          :loading="loading"
          type="primary"
          @click="centerDialogVisible=true"
        >
          <span>注 册</span>
        </el-button>
      </el-form-item>

    </el-form>

    <el-dialog
      title="注册用户"
      :visible.sync="centerDialogVisible"
      width="30%"
      center>
      <el-form ref="registerForm" :model="registerForm" label-width="80px" :rules="registerRules"
               :hide-required-asterisk="true" :validate-on-rule-change="true">
        <el-form-item label="用户类型">
          <el-select v-model="registerForm.userType" placeholder="请选择用户类型">
            <el-option label="个人用户" value="personal"></el-option>
            <el-option label="企业用户" value="business"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item v-if="registerForm.userType==='business'" label="企业/店铺名称">
          <el-input v-model="registerForm.newCompanyName" placeholder="请输入企业/店铺名称"></el-input>
        </el-form-item>
        <el-form-item v-if="registerForm.userType==='business'" label="所属企业/店铺名称">
          <el-input v-model="registerForm.ownedCompanyName" placeholder="请输入所属企业/店铺名称"></el-input>
        </el-form-item>
        <el-form-item label="用户名" required>
          <el-input v-model="registerForm.username" auto-complete="off" placeholder="账号" type="text">
          </el-input>
        </el-form-item>
        <el-form-item label="密码" required>
          <el-input v-model="registerForm.password" type="password" placeholder="请输入密码">
          </el-input>
        </el-form-item>
        <el-form-item label="确认密码" required>
          <el-input v-model="registerForm.rePassword" type="password" placeholder="请再次输入密码">
          </el-input>
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="registerForm.phone" placeholder="请输入手机号"></el-input>
        </el-form-item>
        <el-form-item label="邀请码">
          <el-input v-model="registerForm.invitationCode" placeholder="请输入邀请码"></el-input>
        </el-form-item>
      </el-form>
      <el-button type="primary" @click="handleRegister()">注 册</el-button>
      <el-button @click="centerDialogVisible = false">取 消</el-button>
    </el-dialog>
    <!--  底部  -->
    <div v-if="$store.state.settings.showFooter" id="el-login-footer">
      <span v-html="$store.state.settings.footerTxt"/>
      <span> ⋅ </span>
      <a href="http://www.beian.miit.gov.cn" target="_blank">{{ $store.state.settings.caseNumber }}</a>
    </div>
  </div>
</template>

<script>
  import commonUtil from '../utils/common'
  import defaultSettings from '@/settings'

  export default {
    name: 'Login',
    data() {
      return {
        centerDialogVisible: false,
        codeUrl: '',
        codeLength: 4,
        cookiePass: '',
        passwordType: 'password',
        registerForm: {
          userType: "personal",
          companyName: "",
          username: "",
          password: "",
          rePassword: "",
          phone: "",
          verifyCode: "",
          invitationCode: "",
          ownedCompanyName: "",
          newCompanyName: ""
        },
        loginForm: {
          username: 'admin',
          password: '111111',
          rememberMe: false,
          code: '',
          randomStr: ''
        },
        loginRules: {
          username: [{required: true, trigger: 'blur', message: '用户名不能为空'}],
          password: [{required: true, trigger: 'blur', message: '密码不能为空'}],
          code: [{required: true, trigger: 'blur', message: '验证码不能为空'}]
        },
        registerRules: {
          username: [{required: true, trigger: 'blur', message: '用户名不能为空'}],
          password: [{required: true, trigger: 'blur', message: '密码不能为空'}],
          rePassword: [{required: true, trigger: 'blur', message: '密码不能为空'}],
          verifyCode: [{required: true, trigger: 'blur', message: '手机验证码不能为空'}]
        },
        loading: false,
        redirect: undefined
      }
    },
    watch: {
      $route: {
        handler: function (route) {
          this.redirect = route.query && route.query.redirect
        },
        immediate: true
      }
    },
    created() {
      this.refreshCode()
    },
    methods: {
      showPassword() {
        this.passwordType === ''
          ? (this.passwordType = 'password')
          : (this.passwordType = '')
      },
      refreshCode() {
        this.loginForm.randomStr = commonUtil.randomLenNum(this.codeLength, true)
        this.codeUrl = defaultSettings.api + `/code/${this.loginForm.randomStr}`
        this.loginForm.code = ''
      },
      handleLogin() {
        this.$refs.loginForm.validate(valid => {
          if (valid) {
            this.loading = true
            this.$store.dispatch('Login', this.loginForm).then(() => {
              this.loading = false
              console.log(this.redirect)
              this.$router.push({path: this.redirect || '/'})
            }).catch((e) => {
              console.log(e)
              this.loading = false
              this.refreshCode()
            })
          }
        })
      },
      handleRegister() {
        this.centerDialogVisible = true;
        console.log(this.registerForm)
      }
    }
  }
</script>

<style lang="scss" rel="stylesheet/scss">
  .login {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    background-color: #f8f8f9;
    /*请更换为自己的地址，不保证该地址不被删除*/
    /*background-image:url(https://aurora-1255840532.cos.ap-chengdu.myqcloud.com/bg.jpeg);*/
    /*background-size: cover;*/
  }

  .title {
    margin: 0 auto 30px auto;
    text-align: center;
    color: #707070;
  }

  .login-form {
    border-radius: 6px;
    background: #ffffff;
    width: 385px;
    padding: 25px 25px 5px 25px;
    box-shadow: -4px 5px 10px rgba(0, 0, 0, 0.4);

    .el-input {
      height: 38px;

      input {
        height: 38px;
      }
    }

    .input-icon {
      height: 39px;
      width: 14px;
      margin-left: 2px;
    }
  }

  .login-tip {
    font-size: 13px;
    text-align: center;
    color: #bfbfbf;
  }

  .login-code {
    width: 33%;
    display: inline-block;
    height: 38px;
    float: right;

    img {
      cursor: pointer;
      vertical-align: middle
    }
  }
</style>
