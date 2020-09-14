<template>
<div class='addDetail'>
<!--  步骤条-->
  <step-line></step-line>
  <!-- 视频 -->
  <my-video style="width: 1200px; margin: auto; padding: 0 50px"></my-video>

  <!-- 提示开始配置，选择视频时长以及配音方式 -->
  <div class="descriBlock">
    <div class="blockTitle">详情配置</div>
    <div class="startBar">

      <el-row  class="box">
        <el-col span="4">
          设置视频时长：
        </el-col>
        <el-col span="20">
          <el-row>
<!--            <el-input :rules="durationRules" style="width: 150px;" size="medium" v-model="duration" placeholder="请输入时长"></el-input>-->
            <el-input-number v-model="duration" size="medium"  :min="1" :max="120" label="设置视频时长"></el-input-number>
             分钟 （允许范围：1-120分钟）
          </el-row>
        </el-col>
      </el-row>
<!--      <div class="setDuration">-->
<!--        &lt;!&ndash; <div class="tips">选择视频时长</div> &ndash;&gt;-->
<!--        <el-form ref="durationForm" :model="durationForm" >-->
<!--          <el-form-item label="选择视频时长">-->
<!--            <el-select v-model="durationForm.duration" placeholder="请选择视频时长">-->
<!--              <el-option label="15分钟" value="15min"></el-option>-->
<!--              <el-option label="30分钟" value="30min"></el-option>-->
<!--              <el-option label="45分钟" value="45min"></el-option>-->
<!--            </el-select>-->
<!--          </el-form-item>-->
<!--        </el-form>-->
<!--      </div>-->
      <el-row  class="box">
        <el-col span="4">
          选择配音方式：
        </el-col>
        <el-col span="20">
          <el-radio-group v-model="dubType" text-color="#ff5000" fill="#ff5000">
            <el-radio style="height: 80px; width: 230px"  label="0" border>
              <a style=" line-height: 60px;font-size: 24px">
                <i class='el-icon-folder-opened button-icon' ></i>
              </a>
              <a class="button-text">
                自行上传音频
              </a>
            </el-radio>
            <el-radio style="height: 80px; width: 230px"  label="1" border>
              <a style=" line-height: 60px;font-size: 24px">
                <i class='el-icon-s-custom button-icon' ></i>
              </a>
              <a class="button-text">
                人工声优配音
              </a>
            </el-radio>
            <el-radio style="height: 80px; width: 230px"  label="2" border>
              <a style=" line-height: 60px;font-size: 24px">
                <i class='el-icon-microphone button-icon' ></i>
              </a>
              <a class="button-text">
                智能机器配音
              </a>
            </el-radio>
          </el-radio-group>
        </el-col>
      </el-row>

      <el-row style="margin: 50px 0">
        <el-button style="width: 150px" size="medium" type="primary" @click="toMore">下一步</el-button>
      </el-row>
<!--      <div class="setDubway">-->
<!--        <el-row :gutter="12">-->
<!--          <el-col :span="5">-->
<!--            <div class="cardBox" @click='goTo("uploadDub")'>-->
<!--              <div class="cardBox" @click='goTo("newProduct")'>-->
<!--                <el-card shadow='hover'>-->
<!--                  <div slot='header' class='clearfix'>-->
<!--                    <i class='el-icon-video-camera'></i>-->
<!--                  </div>-->
<!--                  <h3 class='cardTitle'>自行上传配音</h3>-->
<!--                  &lt;!&ndash; <div>24小时不断直播，持续增加品牌曝光度</div> &ndash;&gt;-->
<!--                </el-card>-->
<!--              </div>-->
<!--            </div>-->
<!--          </el-col>-->
<!--          <el-col :span="5">-->
<!--            <div class="cardBox" @click='goTo("selectAttri")'>-->
<!--              <div class="cardBox" @click='goTo("uploadDub")'>-->
<!--                <el-card shadow='hover' >-->
<!--                  <div slot='header' class='clearfix'>-->
<!--                    <i class='el-icon-magic-stick'></i>-->
<!--                  </div>-->
<!--                  <h3 class='cardTitle'>人工配音</h3>-->
<!--                  &lt;!&ndash; <div>情绪表达饱满，主播形象更加生动</div> &ndash;&gt;-->
<!--                </el-card>-->
<!--              </div>-->
<!--            </div>-->
<!--          </el-col>-->
<!--          <el-col :span="5">-->
<!--            <div class="cardBox" @click='goTo("newProduct")'>-->
<!--              <el-card shadow='hover' >-->
<!--                <div slot='header' class='clearfix'>-->
<!--                  <i class='el-icon-monitor'></i>-->
<!--                </div>-->
<!--                <h3 class='cardTitle' @click='goTo("newProduct")'>智能机器配音</h3>-->
<!--                &lt;!&ndash; <div>机器自动配音，快捷高效</div> &ndash;&gt;-->
<!--              </el-card>-->
<!--            </div>-->
<!--          </el-col>-->
<!--        </el-row>-->
<!--      </div>-->

    </div>
  </div>
</div>
</template>


<script>
import stepLine from "@/components/VirtualWeb/stepLine";
import myVideo from "@/components/VirtualWeb/video";
import storeApi from "@/utils/store";

export default {
  name: "addDetail",
  components : {
    stepLine,
    myVideo,
  },
  data() {
    return {
      duration: '',
      dubType: '',//2 机器配音  1  人工配音    0 自行上传配音
    }

  },
  methods: {
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
    toMore(){
      if(this.duration === '' || this.duration === null){
        this.$alert('请先设置视频时长!', '提示', {
          confirmButtonText: '确定',
        });
      }else if(this.dubType === '' || this.dubType === null)
      {
        this.$alert('请先选择配音方式', '提示', {
          confirmButtonText: '确定',
        });
      }else{
        //保存视频时长
        storeApi.set({
          name: 'dubType',
          content: this.dubType,
          type: 'session'
        });
        storeApi.set({
          name: 'duration',
          content: this.duration,
          type: 'session'
        });
        switch (this.dubType){
          case "0": this.goTo('/uploadDub');break;
          case "1": this.goTo('/newProduct');break;
          case "2": this.goTo('/newProduct');break;
        }
      }
    }

 }
}

</script>

<style scoped lang='scss'>
@import '@/common/style.scss';
.addDetail{
  display:flex;
  justify-content:center;
  align-items: center;
  flex-direction: column;
  .my-video{
    width: 1200px;
  }
  .box{
    padding: 10px 60px;
    text-align: left;
    line-height: 50px;
    width: 100%;
  }
  .descriBlock{
    margin:50px 0;
    width:1200px;
    display:flex;
    flex-direction:column;
    justify-content: center;
    align-items: center;
    @include blockTitle();
    .startBar{
      width:100%;
      display:flex;
      justify-content: space-around;
      align-items: center;
      flex-direction: column;
      .setDuration{
        width:710px;
        display: flex;
        justify-content:flex-start
      }
      .setDubway{
        width:100%;
        .el-row{
          width:100%;
          display:flex;
          justify-content: center;
          align-items: center;
        }
        & ::v-deep .el-col.el-col-5{
          padding-left:0 !important;
          padding-right:0 !important;
          height:70%;
          display:flex;
          justify-content:center;
          align-items: center;
          .el-card{
            width:200px;
            height:250px;
            // margin:0 20px;
            font-size:16px;
            &:hover{
              cursor:pointer
            }
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


  }

}

.button-icon{
  position: relative;
  top: 5px;
  margin-right: 5px;
  background-color: #909399;
  color: white;
  font-size: 28px;
  border-radius: 20%;
  padding: 5px;
}
.button-icon:focus{
  background-color: #ff5000;
}

.button-text{
  font-weight: 550;
  font-size: 16px;
  color: #909399
}
</style>
