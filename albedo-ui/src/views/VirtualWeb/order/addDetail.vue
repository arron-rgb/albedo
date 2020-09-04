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
      <div class="setDuration">
        <!-- <div class="tips">选择视频时长</div> -->
        <el-form ref="durationForm" :model="durationForm" >
          <el-form-item label="选择视频时长">
            <el-select v-model="durationForm.duration" placeholder="请选择视频时长">
              <el-option label="15分钟" value="15min"></el-option>
              <el-option label="30分钟" value="30min"></el-option>
              <el-option label="45分钟" value="45min"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </div>
      <div class="setDubway">
          <el-row :gutter="12">
            <el-col :span="5">
              <div class="cardBox" @click='goTo("uploadDub")'>
              <div class="cardBox" @click='goTo("newProduct")'>
                <el-card shadow='hover'>
                  <div slot='header' class='clearfix'>
                    <i class='el-icon-video-camera'></i>
                  </div>
                  <h3 class='cardTitle'>自行上传配音</h3>
                  <!-- <div>24小时不断直播，持续增加品牌曝光度</div> -->
                </el-card>
              </div>
              </div>
            </el-col>
             <el-col :span="5">
               <div class="cardBox" @click='goTo("selectAttri")'>
               <div class="cardBox" @click='goTo("uploadDub")'>
                <el-card shadow='hover' >
                  <div slot='header' class='clearfix'>
                    <i class='el-icon-magic-stick'></i>
                  </div>
                  <h3 class='cardTitle'>人工配音</h3>
                  <!-- <div>情绪表达饱满，主播形象更加生动</div> -->
                </el-card>
               </div>
               </div>
            </el-col>
             <el-col :span="5">
               <div class="cardBox" @click='goTo("newProduct")'>
                  <el-card shadow='hover' >
                    <div slot='header' class='clearfix'>
                      <i class='el-icon-monitor'></i>
                    </div>
                    <h3 class='cardTitle' @click='goTo("newProduct")'>智能机器配音</h3>
                    <!-- <div>机器自动配音，快捷高效</div> -->
                  </el-card>
               </div>
            </el-col>
          </el-row>
      </div>

    </div>
  </div>
</div>
</template>


<script>
import stepLine from "@/components/VirtualWeb/stepLine";
import myVideo from "@/components/VirtualWeb/video";

export default {
  name: "addDetail",
  components : {
    stepLine,
    myVideo,
  },
  data() {
    return {
      durationForm:{
        duration:''
      },
      count: 0
    };

  },
  methods: {

    goTo(path){
      this.$router.replace(path)
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
</style>
