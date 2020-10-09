<template>
  <div class='home' v-if="this.showPage = 1">

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
      <el-aside style=" background: none" width="300px;">
<!--        <p class="mouseover_button"  style="background-color: #99c2fb">虚拟直播</p>-->
<!--        <p class="mouseover_button" style="background-color: #c9bafb">虚拟场景</p>-->
<!--        <p class="mouseover_button" style="background-color: #fbb9ab">智能详情匹配</p>-->
        <p :class="{active:i === isShow}" :key="i" @mouseover="mouseover(i)"  class="mouseover_button" v-for="(item,i) in virtual.row">{{item.title}}</p>
      </el-aside>
      <el-main>
<!--        static.vlivest.com/3e5c8a0c8bd70742c5af00782176f782.png-->
        <el-row>
          <el-col span="20">
            <div class="showBox">
<!--              <img src="http://static.vlivest.com/436ec166195aa58d40552e684e5d46cd.gif" style=" width:635px; margin-top: 35px">-->

              <el-carousel :autoplay="false" @change="carouselChange" indicator-position="none" ref="screenCarousel" style="margin-top: 10px;height: 410px">
                <el-carousel-item :key="i" style="height: 410px" v-for="(item,i) in virtual.row" >
<!--                  <img style="background-size: cover; width: 100%" :src="item.img">-->
                  <div class='videoPlayer'>
                    <video-player  :options="{
                                     autoplay: true,
                                     loop: true,
                                     preload: 'auto',
                                     aspectRatio: '7:4',
                                     fluid: true,
                                     sources:[{
                                       type : 'video/mp4',
                                       src : item.video
                                     }],
                                     controlBar: false
                                   }"
                                   :playsinline="true"
                                   class="video-player vjs-custom-skin"
                                   ref="videoPlayer">
                    </video-player>
                  </div>
                </el-carousel-item>
              </el-carousel>
            </div>
          </el-col>
          <el-col span="4">
            <div class="phoneBox">
<!--              <img src="http://static.vlivest.com/436ec166195aa58d40552e684e5d46cd.gif">-->
              <el-carousel :autoplay="false" @change="carouselChange" indicator-position="none" ref="phoneCarousel" style="">
                <el-carousel-item  :key="i" style="" v-for="(item,i) in virtual.col" >
                  <div class='videoPhone' >
                    <video-player :options="{
                                         autoplay: true,
                                         loop: true,
                                         preload: 'auto',
                                         aspectRatio: '9:16',
                                         fluid: true,
                                         sources:[{
                                           type : 'video/mp4',
                                           src : item.video,
                                         }],
                                         controlBar: false
                                       }"
                                   :playsinline="true"
                                   class="video-player vjs-custom-skin"
                                   ref="videoPlayer">
                    </video-player>
                  </div>
                </el-carousel-item>
              </el-carousel>
            </div>
          </el-col>
        </el-row>

<!--        <el-carousel height="400px" @change="carouselChange" direction="vertical" ref="carousel" :autoplay="false" indicator-position="none">-->
<!--          <el-carousel-item v-for="(item,i) in virtual" :key="i" >-->
<!--            <img style="background-size: cover; margin: 10px; width: 100%" :src="item.img">-->
<!--          </el-carousel-item>-->
<!--        </el-carousel>-->
      </el-main>
    </el-container>

    <!-- 视频 -->
    <div class="body">
      <my-video></my-video>
    </div>


    <!-- 步骤条 -->
    <div class='descriBlock stepBlock'>
      <div class='blockTitle'>一站式智能生成虚拟直播视频</div>
      <div class="stepContainer">
        <div class='stepBar'>
          <el-steps :active="5" align-center>
            <el-step title="需求定位"></el-step>
            <el-step title="确认订单"></el-step>
            <el-step title="查看虚拟制作结果"></el-step>
            <el-step title="编辑、配音"></el-step>
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
            <td>一次生成、长期使用</td>
            <td>≥10000元/月</td>
          </tr>
          <tr>
            <td>机构服务费用</td>
            <td>无</td>
            <td>坑位费+佣金</td>
          </tr>
          <tr>
            <td>动画制作费用</td>
            <td></td>
            <td>≥100000元/人/场景</td>
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
          <el-form-item label="企业名称" prop="companyName">
            <el-input v-model="form.companyName" placeholder="请输入您所在的企业名称"></el-input>
          </el-form-item>
          <el-form-item label="您的姓名" prop="name">
            <el-input v-model="form.name" placeholder='请输入您的姓名'></el-input>
          </el-form-item>
          <el-form-item label="联系电话" prop="phone">
            <el-input v-model="form.phone" placeholder="我们将稍后联系您"></el-input>
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
import crudContactInfo from '@/views/biz/contact-info/contact-info-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import store from "@/store";
import storeApi from "@/utils/store";


export default {
  name: "NormalUser",
  components : {
    myVideo,
  },
  // static.vlivest.com/b9b0e49effe711563a2b8b45ec9163c0.mp4,static.vlivest.com/2a9bbd83769bf4db3fda097695e8094c.mp4,static.vlivest.com/040ad337da31ea7bfd5a4c07d5d9bb1e.mp4
  // static.vlivest.com/3dcdcec5e2dd0edfc2d805ec9c318658.mp4,static.vlivest.com/56d5a2a5605031ff5a3d5b929e4f4b3a.mp4,static.vlivest.com/61149a6056458a0e1d809075a5bfa592.mp4
  data(){
    return {
      virtual:{
        row : [{title: '虚拟直播', video: ''},
          {title: '虚拟场景', video: ''},
          {title: '智能详情匹配', video: ''}],
        col : [
          {video : ''},
          {video : ''},
          {video : ''},
        ]
      },
      // virtual:{
      //   row : [{title: '虚拟直播', video: 'http://static.vlivest.com/b9b0e49effe711563a2b8b45ec9163c0.mp4'},
      //   {title: '虚拟场景', video: 'http://static.vlivest.com/2a9bbd83769bf4db3fda097695e8094c.mp4'},
      //   {title: '智能详情匹配', video: 'http://static.vlivest.com/040ad337da31ea7bfd5a4c07d5d9bb1e.mp4'}],
      //   col : [
      //     {video : 'http://static.vlivest.com/3dcdcec5e2dd0edfc2d805ec9c318658.mp4'},
      //     {video : 'http://static.vlivest.com/56d5a2a5605031ff5a3d5b929e4f4b3a.mp4'},
      //     {video : 'http://static.vlivest.com/61149a6056458a0e1d809075a5bfa592.mp4'},
      //   ]
      // },

      // carousel:[{img:require(''), url: ''}],
      isShow: 0,
      showPage : 0,
      carousel:[{img:'',url:''},
        {img:'',url:''},
        {img:'',url:''},
      ],
      // carousel:[{img:'http://static.vlivest.com/bbdbb869ccba312109263a9fccaba0d9.jpg',url:''},
      //   {img:'http://static.vlivest.com/81ac2ed1bf92d632d0a8854a4f1fc5f5.jpg',url:''},
      //   {img:'http://static.vlivest.com/65b46aacbcddea99e6b13f45087ffdaf.jpg',url:''},
      //   ],


      form: {
        companyName: null,
        name: null,
        phone: null,
        status: null,
        description: null,
      },
      rules: {
        companyName:[
          {required:true,message:'请输入您所在的企业名称', trigger:'blur'}
        ],
        name: [
          { required: true, message: '请输入您的姓名', trigger: 'blur' },
          { min: 2, max: 5, message: '长度在 2 到 5 个字符', trigger: 'blur' }
        ],
        phone:[
          {required:true,message:'请输入您的联系方式',trigger:'blur'},
          {
            min:11,max:11,message:'请输入11位电话号码',trigger:'blur'
          }
        ]
      }

    }
  },
  created() {
    this.getMediaData();
  },
  methods: {
    getMediaData(){

      var list = storeApi.get({ name: 'staticData' });//获得所有的静态资源list
      var dataIndex, i;
      dataIndex = list.findIndex(o => o.label === '横屏视频');
      var temp = list[dataIndex].value.split(',');
      for(i = 0 ; i < this.virtual.row.length; i++)
        this.virtual.row[i].video = 'https://' + temp[i];

      dataIndex = list.findIndex(o => o.label === '竖屏视频');
      temp = list[dataIndex].value.split(',');
      for(i = 0 ; i < this.virtual.col.length; i++)
        this.virtual.col[i].video = 'https://' + temp[i];

      dataIndex = list.findIndex(o => o.label === '主页轮播图');
      temp = list[dataIndex].value.split(',');
      for(i = 0 ; i < this.virtual.col.length; i++)
        this.carousel[i].img = 'https://' + temp[i];

      this.showPage = 1;
    },
    mouseover(key){//button绑定走马灯
      this.$refs.screenCarousel.setActiveItem(key);
      this.$refs.phoneCarousel.setActiveItem(key);
      this.isShow = key;
    },
    carouselChange(key){//走马灯绑定button
      this.isShow = key;
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          alert(111)
          this.submitContact()
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    submitContact(){
      return new Promise((resolve, reject) => {
        crudContactInfo.save(this.form).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            resolve(res)
          }
        }).catch(error => {
          reject(error)
        })
      })
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
  .showBox{
    background-image: url("http://static.vlivest.com/3e5c8a0c8bd70742c5af00782176f782.png");

    width:700px;
    height:600px;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
  }
  .phoneBox{
    //static.vlivest.com/da54c6b8ddccfba88a8352f8c5996cb0.png
    background-image: url("http://static.vlivest.com/da54c6b8ddccfba88a8352f8c5996cb0.png");
    width:210px;
    z-index: 9;
    height:300px;
    bottom: 0;
    position: absolute;
    left: 600px;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
  }
  .body{
    width: 1200px;
    margin: 30px auto;
    .mouseover_button{
      width: 316px;
      height: 121px;
      margin: 50px 0;
      background-color: #f6f9fc;
      border-radius: 10px;
      line-height: 121px;
      color: white;
      font-weight: bold;
      font-size: 22px;
      font-family: "SourceHanSansCN-Regular","Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
    }
    .mouseover_button:first-child{
      background-color: #99c2fb;
    }
    .mouseover_button:nth-child(2){
      background-color: #c9bafb
  }
    .mouseover_button:nth-child(3){
      background-color: #fbb9ab
    }
    .active {
      box-shadow: 0 2px 12px 0 rgba(0,0,0,0.5);
    }

  }
  .block{
    min-width: 1200px;
    margin: auto;
    //.banner{
    //  w:100%;
    //}
    width: 100%;
  }


  .descriBlock{
    //width:100%;
    min-width: 1200px;
    width: 100%;
    padding:100px 0;
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
      margin:  auto;
      margin-top: 50px;
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
      margin: auto;
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
.videoPlayer {
  width: 636px;
  height: 410px;
  margin-top: 34px;
  position: relative;
  display: inline-block;
  border: 1px solid transparent;
  //overflow: hidden;
  //margin-right: 4px;
}
.videoPhone{
  width: 148px;
  height: 280px;
  position: absolute;
  left: 33px;
  top: 40px;
}
</style>
