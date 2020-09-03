<template>
  <div class='home'>

    <!-- 轮播图 -->
    <div class="block">
      <el-carousel height="340px">
        <el-carousel-item v-for="(item,index) in carousel" :key="index">
          <a :href='item.url'><img class='banner' :src="item.img" alt=""></a>
        </el-carousel-item>
      </el-carousel>
    </div>

    <!-- 平台介绍 -->
    <el-container class="body">
      <el-aside width="400px;" style=" background: none">
        <p class="mouseover_button" :class="{active:i==isShow}" @mouseover="mouseover(i)"  v-for="(item,i) in virtual" :key="i">{{item.title}}</p>
      </el-aside>
      <el-main>
        <el-carousel height="400px" @change="carouselChange" direction="vertical" ref="carousel" :autoplay="false" indicator-position="none">
          <el-carousel-item v-for="(item,i) in virtual" :key="i" >
            <img style="background-size: cover; margin: 10px; width: 100%" :src="item.img">
          </el-carousel-item>
        </el-carousel>
      </el-main>
    </el-container>

    <!-- 视频 -->
    <my-video></my-video>


    <!-- 步骤条 -->
    <div class='descriBlock stepBlock'>
      <div class='blockTitle'>一站式智能生成虚拟直播视频</div>
      <div class="stepContainer">
        <div class='stepBar'>
          <el-steps :active="5" align-center>
            <el-step title="需求定位"></el-step>
            <el-step title="确认订单"></el-step>
            <el-step title="查看虚拟制作结果"></el-step>
            <el-step title="上传商品详情"></el-step>
            <el-step title="生成直播视频"></el-step>
          </el-steps>
        </div>
      </div>


    </div>



    <!-- 描述文字 -->
    <div class='descriBlock description'>
      <div class='blockTitle'>高效灵活</div>
      <div class='descriContainer'>
        <el-row :gutter="12">
          <el-col :span="6">
            <el-card shadow='hover'>
              <div slot='header' class='clearfix'>
                <i class='el-icon-video-camera'></i>
              </div>
              <h3 class='cardTitle'>持续收益</h3>
              <div>24小时不断直播，持续增加品牌曝光度</div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card shadow='hover'>
              <div slot='header' class='clearfix'>
                <i class='el-icon-magic-stick'></i>
              </div>
              <h3 class='cardTitle'>精准企划</h3>
              <div>根据品牌企划更换主播形象/场景，优化品牌形象</div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card shadow='hover'>
              <div slot='header' class='clearfix'>
                <i class='el-icon-monitor'></i>
              </div>
              <h3 class='cardTitle'>在线接单</h3>
              <div>在线对接详细要求完成制作，节省商家寻找机构制作的时间</div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card shadow='hover'>
              <div slot='header' class='clearfix'>
                <i class='el-icon-document'></i>
              </div>
              <h3 class='cardTitle'>稳定可靠</h3>
              <div>订单可追溯，给予商家可靠保证</div>
            </el-card>
          </el-col>
        </el-row>
      </div>

    </div>


    <!-- 成本表格 -->
    <div class='descriBlock cost'>
      <div class='blockTitle'>降低成本</div>
      <div class='costContainer'>
        <table>
          <tr class='tableHead' >
            <th></th>
            <th>虚拟直播平台</th>
            <th>传统直播平台</th>
          </tr>
          <tr>
            <td>主播费用</td>
            <td>低</td>
            <td>高</td>
          </tr>
          <tr>
            <td>机构服务费用</td>
            <td>低</td>
            <td>高</td>
          </tr>
          <tr>
            <td>动画制作费用</td>
            <td>低</td>
            <td>高</td>
          </tr>
        </table>
      </div>


    </div>


    <!-- service -->
    <div class="descriBlock service">
      <div class="blockTitle">企业服务</div>
      <div class="serviceContainer">
        <span class="descriSpan">企业账户面向大客户，提供品牌专属定制服务，方便企业进行统一支付及员工账户管理</span>
        <el-form ref="form" label-position="top" :model="form" label-width="80px" :rules="rules" class="demo-ruleForm">
          <el-form-item label="企业名称" prop="enterprise">
            <el-input v-model="form.enterprise" placeholder="请输入您所在的企业名称"></el-input>
          </el-form-item>
          <el-form-item label="您的姓名" prop="name">
            <el-input v-model="form.name" placeholder='请输入您的姓名'></el-input>
          </el-form-item>
          <el-form-item label="联系电话" prop="tel">
            <el-input v-model="form.tel" placeholder="我们将稍后联系您"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm('form')">提交咨询</el-button>
          </el-form-item>
        </el-form>
        <el-link :underline="false" @click="goTo('/proService')"  class="learn-more"> >> 了解更多</el-link>
      </div>

    </div>


  </div>
</template>



<script>
import myVideo from "@/components/VirtualWeb/video";
export default {
  name: "NormalUser",
  components : {
    myVideo,
  },
  data(){
    return {
      virtual:[{title: '虚拟直播', img: require('@/assets/VirtualWeb/timg.jpg')},
        {title: '虚拟场景', img: require('@/assets/VirtualWeb/timg1.jpg')},
        {title: '智能详情匹配', img: require('@/assets/VirtualWeb/timg2.jpg')}],

      // carousel:[{img:require(''), url: ''}],
      isShow: 0,
      carousel:[{img:require('@/assets/VirtualWeb/NormalUser/img/img1.jpg'),url:''},
        {img:require('@/assets/VirtualWeb/NormalUser/img/img2.jpg'),url:''},
        {img:require('@/assets/VirtualWeb/NormalUser/img/img3.jpg'),url:''},
        {img:require('@/assets/VirtualWeb/NormalUser/img/img4.jpg'),url:''}],


      form: {
        enterprise:'',
        name:'',
        tel:''
      },
      rules: {
        enterprise:[
          {required:true,message:'请输入您所在的企业名称', trigger:'blur'}
        ],
        name: [
          { required: true, message: '请输入您的姓名', trigger: 'blur' },
          { min: 2, max: 5, message: '长度在 2 到 5 个字符', trigger: 'blur' }
        ],
        tel:[
          {required:true,message:'请输入您的联系方式',trigger:'blur'},
          {
            min:11,max:11,message:'请输入11位电话号码',trigger:'blur'
          }
        ]
      }

    }
  },

  methods: {
    mouseover(key){//button绑定走马灯
      this.$refs.carousel.setActiveItem(key);
      this.isShow = key;
    },
    carouselChange(key){//走马灯绑定button
      this.isShow = key;
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          alert('submit!');
        } else {
          console.log('error submit!!');
          return false;
        }
      });
      this.form.enterprise=''
      this.form.name=''
      this.form.tel=''
    },
    goTo(path){
      this.$router.push({path: path});
    }
  }

}
</script>

<style  scoped lang='scss'>
@import '@/common/style.scss';

.home{
  text-align: center;
  width:100%;
  display:flex;
  flex-direction: column;
  justify-content: space-around;
  align-items: center;
  .body{
    width: 1200px;
    margin: 50px auto;
    .mouseover_button{
      width: 316px;
      height: 121px;
      margin: 30px 50px;
      background-color: #f6f9fc;
      border-radius: 10px;
      line-height: 121px;
      color: #203152;
      font-size: 20px;
      font-family: "SourceHanSansCN-Regular","Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
    }
    .active {
      background-color: $bg-orange;
      color: white;
    }

  }
  .block{
    min-width: 1200px;
    margin: auto;
    .banner{
      height:100%;
    }
    width: 100%;
    margin: auto;
  }


  .descriBlock{
    width:100%;
    padding:100px 0px;
    display:flex;
    justify-content: space-around;
    align-items: center;
    flex-direction:column;
  }
  .stepBlock{
    @include blockTitle($light-orange);
  }
  .stepContainer{
    width:1200px;
    margin:0 auto;
    .stepBar{
      // background-color:rgba(255,237,229,0.6);
      width:100%;
      padding:70px 0;
      letter-spacing: 1px;
      ::v-deep.el-step__head.is-finish{
        color:white !important;
        border-color:$orange !important;
      }
      ::v-deep .el-step__line{
        top:25px;
      }
      ::v-deep .el-step__icon{
        width:50px;
        height:50px;
        background-color:$orange;
        font-size: 2rem;
      }
      ::v-deep.el-step__title.is-finish{
        color:$orange
      }

    }
  }

  .description{
    @include blockTitle(white);
    margin-bottom:0px;
    .descriContainer{
      display:flex;
      justify-content: center;
      align-items: center;
      margin:50px 0 0 0;
      width:1200px;
      height:100%;
      & ::v-deep .el-col.el-col-6{
        padding-left:0 !important;
        padding-right:0 !important;
        height:70%;
        .el-card{
          width:217px;
          height:250px;
          margin:0 20px;
          font-size:16px;
          & .el-card__header{
            color:whitesmoke;
            padding:16px 20px 0px 18px !important;
            border-bottom:none !important;
            i{
              border:1px solid $orange;
              border-radius: 50%;
              background-color: $orange;
              padding:10px;
            }
            i::before{
              font-size:60px
            }
          }
          & .el-card__body{
            padding:10px 20px 20px 25px
          }
          .cardTitle{
            margin:10px 0;

          }
        }

      }
      &::v-deep .el-row{
        height:100%
      }
    }

  }
  .cost{
    @include blockTitle($light-orange);
    box-sizing: border-box;
    .costContainer{
      width:1200px;
      display: flex;
      justify-content: center;
      align-items: center;
      padding:70px 0;
      table{
        border:2px solid white;
        box-shadow:0 2px 12px 0 rgba(0,0,0,0.1);
        border-collapse: collapse;
        .tableHead{
          background-color: rgba(255,80,0,0.1);
          color:$textColor !important
        }
        th{
          border:2px solid white;
          width:250px;
          height:60px;
          font-size:18px;
          // font-weight: 100;
        }
        td{
          border:2px solid white;
          width:250px;
          height:60px;
          font-size:18px;
          &:first-child{
            background-color: rgba(255,80,0,0.1);
            color:$textColor
          };
          &:nth-child(2){
            color:#41b883
          }
          &:nth-child(3){
            color:$orange
          }

        }
      }
    }
  }

  .service{
    @include blockTitle(white);
    width:100%;
    background-color:white;
    display:flex;
    justify-content: center;
    align-items: center;
    .serviceContainer{
      width:1200px;
      &::v-deep .el-form{
        margin:40px auto 0;
        width:500px;
      };
      &::v-deep .is-required{
        display:flex;
        justify-content: flex-start;
        flex-direction: column;
      }
      & ::v-deep .el-button--primary{
        background-color: $bg-orange;
        border-color:$bg-orange
      }
    }

  }

}
.learn-more:hover{
  color: #ff5000;
}
</style>
