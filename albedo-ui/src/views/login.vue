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
        欢迎来到虚拟工坊
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
          style="width: 67%"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" class="el-input__icon input-icon" icon-class="validCode"/>
        </el-input>
        <div class="login-code">
          <img :src="codeUrl" @click="refreshCode">
        </div>
      </el-form-item>
      <el-row>
        <el-col span="12">
          <el-checkbox style="margin:0 0 25px 0;" v-model="loginForm.rememberMe">
            记住我
          </el-checkbox>
        </el-col>
        <el-col span="12">
          <el-link :underline="false" @click="goTo('/findPassword')" class="forgetPsd">忘记密码</el-link>
        </el-col>
      </el-row>
      <!--      <el-checkbox v-model="loginForm.rememberMe" style="margin:0 0 25px 0;">-->
      <!--        记住我-->
      <!--      </el-checkbox>-->
      <el-form-item>
        <el-button
          :loading="loading"

          type="primary"

          style="width: 100px; border: 1px solid #ff5000;color: #fff;background-color: #ff5000;"

          @click.native.prevent="handleLogin"
        >
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
        <el-button
          style="width: 100px;"
          @click="centerDialogVisible=true"
        >
          <span>注 册</span>
        </el-button>
      </el-form-item>

    </el-form>

    <el-dialog
      title="注册用户"
      :visible.sync="centerDialogVisible"
      width="500px"
      center>
      <el-form :model="registerForm" :rules="registerRules" label-width="110px" ref="registerForm"
      >
        <el-form-item prop='userType' label="用户类型">
          <el-select v-model="registerForm.userType" placeholder="请选择用户类型">
            <el-option label="个人用户" value="personal"></el-option>
            <el-option label="企业用户" value="business"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="企业/店铺名称" prop='newCompanyName' v-if="registerForm.userType==='business'">
          <el-input v-model="registerForm.newCompanyName" placeholder="请输入企业/店铺名称"></el-input>
        </el-form-item>
        <!--        <el-form-item v-if="registerForm.userType==='business'" label="所属企业/店铺名称">-->
        <!--          <el-input v-model="registerForm.ownedCompanyName" placeholder="请输入所属企业/店铺名称"></el-input>-->
        <!--        </el-form-item>-->
        <el-form-item prop='username' label="用户名">
          <el-input v-model="registerForm.username" auto-complete="off" placeholder="账号" type="text">
          </el-input>
        </el-form-item>
        <el-form-item prop='password' label="密码">
          <el-input v-model="registerForm.password" type="password" placeholder="请输入密码">
          </el-input>
        </el-form-item>
        <el-form-item prop='rePassword' label="确认密码">
          <el-input v-model="registerForm.rePassword" type="password" placeholder="请再次输入密码">
          </el-input>
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="registerForm.phone" placeholder="请输入手机号"></el-input>
        </el-form-item>
        <el-form-item label="验证码" prop="verifyCode">
          <el-col span="14">
            <el-input
              :length="6"
              v-model="registerForm.verifyCode">
            </el-input>
          </el-col>
          <el-col span="10">
            <el-button :disabled="disabled" @click="sendcode" style="width: 100%">
              {{ btntxt }}
            </el-button>
          </el-col>

        </el-form-item>
        <el-form-item label="邀请码">
          <el-input v-model="registerForm.invitationCode" placeholder="请输入邀请码"></el-input>
        </el-form-item>
      </el-form>

      <el-row style="text-align: center; margin: 20px 0 ;">
        <el-checkbox v-model="checked">我同意</el-checkbox>
        <el-link :underline="false" @click="goTo('/agreement')" type="primary">《虚拟工坊用户使用协议》</el-link>
        和
        <el-link :underline="false" @click="goTo('/privacy')" type="primary">《虚拟工坊隐私政策》</el-link>
      </el-row>

      <div style="text-align: center">
        <el-button type="primary" @click="handleRegister()">注 册</el-button>
        <el-button @click="centerDialogVisible = false">取 消</el-button>
      </div>
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
import loginService from "@/api/login";

export default {
  name: 'Login',
  data: function () {
    let validateConfirmPass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.registerForm.password) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
      callback();
    };
    return {
      centerDialogVisible: false,
      codeUrl: '',
      codeLength: 4,
      checked : false,
      cookiePass: '',
      passwordType: 'password',
      btntxt: '获取验证码',
      time: 60,
      disabled: false,
      registerForm: {
        userType: 'personal',
        username: '',
        password: '',
        rePassword: '',
        phone: '',
        verifyCode: '',
        invitationCode: '',
        ownedCompanyName: '',
        newCompanyName: ''
      },
      loginForm: {
        username: '',
        password: '',
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
        newCompanyName: [{required: true, trigger: 'blur', message: '企业/店铺名不能为空'}],
        username: [{required: true, trigger: 'blur', message: '用户名不能为空'}],
        password: [{required: true, trigger: 'blur', message: '密码不能为空'}],
        rePassword: [{required: true, trigger: 'blur', message: '密码不能为空'}, {validator: validateConfirmPass}],
        phone: [{required: true, length: 11, trigger: 'blur', message: '请输入11位手机号'}],
        verifyCode: [{required: true, length: 6, trigger: 'blur', message: '请输入6位验证码'}]
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
    if (this.$route.query.func === 'toRegister') {
      this.centerDialogVisible = true
    }
    if (this.$route.query.func === 'createBusiness') {
      this.centerDialogVisible = true
      this.registerForm.userType = 'business'
    }
  },
  methods: {
    validateConfirmPass: (rule, value, callback) => {
      if (validate.checkNotNull(this.registerForm.password)) {
        if (validate.checkNull(value)) {
          callback(new Error("请再次输入密码"));
          return;
        } else if (value !== this.registerForm.password) {
          callback(new Error("两次输入密码不一致!"));
          return;
        }
      }
      callback();
    },
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
            this.$router.push({path: this.redirect || '/'})
          }).catch((e) => {
            this.loading = false
            this.refreshCode()
          })
        }
      })
    },
    handleRegister() {
      if(!this.checked){
        this.$alert('请先同意《虚拟工坊用户使用协议》和《虚拟工坊隐私政策》', {
          confirmButtonText: '确定',
        })
      }else{
        this.$refs.registerForm.validate(valid => {
          if (valid) {
            this.$store.dispatch('Register', this.registerForm).then(() => {
              // console.log(this.registerForm);
              // this.$router.push({path: this.redirect || '/'})
              this.centerDialogVisible = false;
            }).catch((e) => {
            })
          }
        });
      }
    },
    //验证手机号码部分
    sendcode() {

      if (this.registerForm.phone === '') {
        this.$alert('请输入手机号码！', '提示', {
          confirmButtonText: '确定',
        });
        return;
      }

      this.time = 60;
      this.disabled = true;
      this.timer();

      return new Promise((resolve, reject) => {//获取验证码
        loginService.getVerify(this.registerForm.phone).then((res) => {
          resolve(res)
        }).catch((err) => {
          reject(err)
        })
      });
    },
    timer: function () {
      if (this.time > 0) {
        this.time--;
//                 console.log(this.time);
        this.btntxt = this.time + "s,后获取";
        setTimeout(this.timer, 1000);
      } else {
        this.time = 0;
        this.btntxt = "获取验证码";
        this.disabled = false;
      }
    },
    goTo(url, data) {
      //带参数跳转
      // console.log(data)
      this.$router.push({path: url, query: {func: data}});
    },
  }
}
</script>

<style lang="scss" rel="stylesheet/scss">
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  //background-color: #f8f8f9;
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
  margin-top: 30px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);

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

.forgetPsd:hover {
  color: #ff5000 !important;
}
</style>
