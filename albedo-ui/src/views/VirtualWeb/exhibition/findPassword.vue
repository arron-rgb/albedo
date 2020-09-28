<template>
  <div  class="cardBox">
    <h3 class="title">
      找回密码
    </h3>

    <el-form :model="data" :rules="dataRules" label-width="80px" v-if="step === 0">
      <el-form-item label="用户名" prop='username'>
        <el-input placeholder="请输入账户名" v-model="data.username">
        </el-input>
      </el-form-item>
      <el-form-item label="手机号" prop="phone">
        <el-input placeholder="请输入手机号" v-model="data.phone"></el-input>
      </el-form-item>
      <el-form-item label="验证码" prop="verifyCode">
        <el-col span="24">
          <el-col span="14">
            <el-input
              :length="6"
              v-model="data.verifyCode">
            </el-input>
          </el-col>
          <el-col span="10">
            <el-button  :disabled="disabled"  @click="sendcode" style="width: 100%">
              {{btntxt}}
            </el-button>
          </el-col>
        </el-col>
      </el-form-item>
      <el-button @click="verity" style="width: 120px" type="primary" >下一步</el-button>
    </el-form>

    <el-form :model="changeForm" :rules="changeFormRules" label-width="80px" v-else>
      <el-form-item label="密码" prop='password'>
        <el-input placeholder="请输入密码" type="password" v-model="changeForm.password">
        </el-input>
      </el-form-item>
      <el-form-item label="确认密码" prop='rePassword'>
        <el-input placeholder="请再次输入密码" type="password" v-model="changeForm.rePassword">
        </el-input>
      </el-form-item>
      <el-button style="width: 120px" type="primary" >提交</el-button>
    </el-form>
  </div>
</template>

<script>
import loginService from "@/api/login";

export default {
  name: "findPassword",
  data() {
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
      data:{
        username : '',
        phone : '',
        verifyCode : '',
      },
      changeForm:{
        password : '',
        rePassword : '',
      },
      btntxt : '获取验证码',
      time : 60,
      step : 0,
      disabled : false,
      dataRules:{
        username: [{required: true, trigger: 'blur', message: '用户名不能为空'}],
        phone: [{required: true, length : 11, trigger: 'blur', message: '请输入11位手机号'}],
        verifyCode: [{required: true, length : 6, trigger: 'blur', message: '请输入6位验证码'}]
      },
      changeFormRules :{
        password: [{required: true, trigger: 'blur', message: '密码不能为空'}],
        rePassword: [{required: true, trigger: 'blur', message: '密码不能为空'}, {validator: validateConfirmPass}],
      }
    }
  },
  methods:{
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
    //验证手机号码部分
    sendcode(){
      if(this.registerForm.phone === ''){
        this.$alert('请输入手机号码！', '提示', {
          confirmButtonText: '确定',
        });
        return;
      }

      this.time = 60;
      this.disabled=true;
      this.timer();

      return new Promise((resolve, reject) => {//获取验证码
        loginService.getVerify(this.registerForm.phone).then((res) => {
          resolve(res)
        }).catch((err) => {
          reject(err)
        })
      });
    },
    timer:function () {
      if (this.time > 0) {
        this.time--;
//                 console.log(this.time);
        this.btntxt=this.time+"s,后获取";
        setTimeout(this.timer, 1000);
      } else{
        this.time=0;
        this.btntxt="获取验证码";
        this.disabled=false;
      }
    },
    verity(){
      this.step = 1;
    }
  }
}
</script>

<style scoped>
.cardBox{
  width: 500px;
  margin: auto;
  margin-top: 30px;
  padding: 25px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
}
.title {
  margin: 0 auto 30px auto;
  padding: 0;
  text-align: center;
  color: #707070;
}
</style>
