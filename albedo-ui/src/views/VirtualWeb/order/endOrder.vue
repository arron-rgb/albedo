<template>
  <div>
<!--    {{this.orderDetail}}-->
    <div class="container">
      <el-card class="box-card" body-style="padding : 0px">
        <div slot="header" class="clearfix">
          <span class="title">订单详情</span>
        </div>
<!--        {{orderDetail}}-->
        <el-row>
          <el-col span="12">
            <el-row  class="box">
              <el-col span="6">
                创建时间：
              </el-col>
              <el-col span="18">
                {{orderDetail.createdDate}}
              </el-col>
            </el-row>

            <el-row  class="box">
              <el-col span="6">
                创建人：
              </el-col>
              <el-col span="18">
                {{orderDetail.createdBy}}
              </el-col>
            </el-row>

            <el-row  class="box">
              <el-col span="6">
                订单状态：
              </el-col>
              <el-col span="18">
                <el-row>
                  <span v-if="orderDetail.state  === 0">未付款</span>
                  <span v-else-if="orderDetail.state  === 1">未接单</span>
                  <span v-else-if="orderDetail.state  === 2">制作中</span>
                  <span v-else-if="orderDetail.state  === 6">已结单</span>
                  <span v-else>可配音</span>
                </el-row>
              </el-col>
            </el-row>


            <el-row class="box" v-show="orderDetail.type === '0' || orderDetail.type === '1'">
              <el-col span="6">
                加速服务：
              </el-col>
              <el-col span="18">
                {{orderDetail.type === '0' ? '未加速' : '已加速'}}
              </el-col>
            </el-row>

            <!--      ￥<span style="font-size: 26px; color: #ff5000; margin: 0 10px">999</span>元/次-->
            <el-row  class="box">
              <el-col span="6">
                订单价格：
              </el-col>
              <el-col span="18">
                <el-row>
                  <el-col>￥<span style="font-size: 26px; color: #ff8249; margin: 0 10px">{{orderDetail.totalAmount}}</span>元</el-col>
                </el-row>
              </el-col>
            </el-row>
            <el-row  class="box">
              <el-col span="6">
                支付方式：
              </el-col>
              <el-col span="18">
                <span v-if="orderDetail.method === 'ali'">支付宝</span>
                <span v-if="orderDetail.method === 'wechat'">微信</span>
                <span v-if="orderDetail.method === 'balance'">套餐余额</span>
              </el-col>
            </el-row>
          </el-col>


          <el-col span="12">
            <el-row class="box" v-if="orderDetail.type === '0' || orderDetail.type === '1'">
              <!--          视频订单需求-->
              <el-col span="6">
                已选需求：
              </el-col>
              <el-col span="18" style="height: 200px; overflow-y: auto;">
                <span :key="o" v-for="(o,index) in JSON.parse(orderDetail.content).data" >
                  <el-tag :type="typeList[index % 5]"  class="tag" v-for="i in o.data">
                    <p style="line-height: 40px; margin: 0">{{i.value}}<p/>
                  </el-tag>
                </span>
              </el-col>
            </el-row>

            <el-row class="box" v-else>
              <!--          人工配音订单需求-->
              <el-col span="6">
                已选需求：
              </el-col>
              <el-col span="18" style="height: 200px; overflow-y: auto;">
                <el-tag :key="o" :type="typeList[index % 5]" class="tag" v-for="(o,index) in orderDetail.description.slice(1,orderDetail.description.length - 1).split(',')">
                  <p style="line-height: 40px; margin: 0">{{o}}<p/>
                </el-tag>
              </el-col>
            </el-row>

            <el-row class="box" v-if="orderDetail.type === '0' || orderDetail.type === '1'">
              <el-row>
                补充需求（选填）：
              </el-row>
              <el-row style="height: 100px; overflow-y: auto">
                {{orderDetail.description}}
              </el-row>
            </el-row>

            <el-row class="box" v-else>
              <el-col span="6">
                台词文本：
              </el-col>
              <el-col span="18">
                <!--            <el-tag class="tag" v-for="(o,index) in orderDetail.content" :key="o" :type="typeList[index % 5]">-->
                <p style="line-height: 40px; margin: 0">{{orderDetail.content}}<p/>
                <!--            </el-tag>-->
              </el-col>
            </el-row>
          </el-col>
        </el-row>

<!--        {{orderDetail.videoList}}-->
        <el-table
          :data="orderDetail.videoList"
          :default-sort = "{prop: 'createdDate', order: 'descending'}"
          :row-class-name="tableRowClassName"
          style="width: 95%; margin: auto; padding-bottom: 30px; font-size: 14px">

          <el-table-column
            type="expand">
            <template slot-scope="scope">
<!--              音频-->
              <div v-if="scope.row.dubType === 0 || scope.row.dubType === '0' || scope.row.dubType === 1 || scope.row.dubType === '1'">
                <el-row class="line">
                  <el-col span="4">
                    您的音频：
                  </el-col>
                  <el-col span="20">
                    <aplayer :music="{
                                title: '您的音频',
                                artist: '请试听',
                                src: scope.row.audioUrl,
                                theme: '#ff5000'
                              }" style="width: 100%; margin:  auto"
                             v-if="scope.row.audioUrl !== '' && scope.row.audioUrl !== null"
                    />
                    <span v-else>音频已失效</span>
                  </el-col>
                </el-row>
              </div>

<!--              台词文本-->
              <div v-if="scope.row.dubType === 2 || scope.row.dubType === '2' || scope.row.dubType === 1 || scope.row.dubType === '1'">
                <el-row class="line">
                  <el-col span="4">
                    您的台词：
                  </el-col>
                  <el-col span="20">
                    <div style="width: 100%; line-height: 24px; max-height: 200px; overflow-y: auto; margin-bottom: 30px">{{scope.row.audioText}}</div>
                  </el-col>
                </el-row>
              </div>

<!--              视频展示-->
              <el-row class="line">
                <el-col span="4">
                  <el-row >您的视频：</el-row>
                </el-col>
                <el-col span="20">
                  <span v-if="scope.row.outputUrl === '' || scope.row.outputUrl === null">视频已失效/合成中</span>
                  <el-row style="text-align: center" v-else>
                    <my-video :video-data="scope.row.outputUrl" style="width: 100%" type="user"></my-video>
                    <el-button @click="download(scope.row.outputUrl)">
                      下载视频
                      <i class="el-icon-download el-icon--right" style="font-size: 18px"></i>
                    </el-button>
                  </el-row>
                </el-col>
              </el-row>
              <el-row>
              </el-row>
            </template>
          </el-table-column>

          <el-table-column
            label="视频id"
            prop="orderId"
            sortable>
          </el-table-column>

          <el-table-column
            label="创建时间"
            prop="createdDate"
            sortable>
          </el-table-column>

          <el-table-column
            label="最后修改人"
            prop="lastModifiedBy"
            sortable>
          </el-table-column>

          <el-table-column
            label="配音方式"
            sortable>
            <template slot-scope="scope">
              <span v-if="scope.row.dubType === 2 || scope.row.dubType === '2'">机器配音</span>
              <span v-if="scope.row.dubType === 1 || scope.row.dubType === '1'">人工配音</span>
              <span v-if="scope.row.dubType === 0 || scope.row.dubType === '0'">上传音频</span>
            </template>
          </el-table-column>
        </el-table>

      </el-card>
    </div>
  </div>
</template>

<script>
import storeApi from "@/utils/store";
import aplayer from 'vue-aplayer'
import myVideo from '@/components/VirtualWeb/file/video'
export default {
  name: "endOrder",
  components: {
    aplayer,
    myVideo
  },
  data(){
    return{
      orderDetail : null,
      list : [],
      typeList : ["", "success", "info", "warning", "danger"],
      description : '',
      type : '1',//加速服务，0 不加速， 1加速
      payType : 'ali', //0 支付宝支付， 1微信支付
      totalAmount : 1029,
      data : '',
      loading : false,
      priceList : [999, 1999, 0],
      orderId : null,
      playerOptions : {
        playbackRates: [0.7, 1.0, 1.5, 2.0], //播放速度
        autoplay: false, //如果true,浏览器准备好时开始回放。
        muted: false, // 默认情况下将会消除任何音频。
        loop: false, // 导致视频一结束就重新开始。
        preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
        // language: 'zh-CN',
        aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
        fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
        sources: [{
          type: "video/mp4",
          src: null//url地址

        }],
        // poster: require("@/assets/VirtualWeb/NormalUser/img/videoCover.jpg"), //你的封面地址
        // width: document.documentElement.clientWidth,
        notSupportedMessage: '此视频暂无法播放，请稍后再试',
        //允许覆盖Video.js无法播放媒体源时显示的默认信息。
        controlBar: {
          timeDivider: true,
          durationDisplay: true,
          remainingTimeDisplay: false,
          fullscreenToggle: false  //全屏按钮
        }
      }
    }
  },
  watch: {
    type : function (val){
      this.type = val;
      this.totalAmount = this.priceList[0] + val * 30;
    }

  },
  created() {
      var orderDetail = storeApi.get({
        name: 'orderDetail'
      });
      if (orderDetail === null || orderDetail === undefined) {
        this.$alert('请先选择具体视频订单', {
          confirmButtonText: '确定',
        }).then(
          this.goTo('/myOrder')
        );
      }
      else {
        this.orderDetail = orderDetail;
        if(orderDetail.videoId !== '' || orderDetail.videoId !== null )
          this.playerOptions.sources[0].src = 'https://' + orderDetail.videoId;
        // console.log(this.playerOptions.sources[0].src);
      }
  },
  methods:{
    tableRowClassName({row, rowIndex}) {
      // console.log(row)
      if (row.dubType === 1 || row.dubType === '1') {//人工配音
        return 'warning-row';
      } else if (row.dubType === 0 || row.dubType === '0') {//上传音频
        return 'success-row';
      }
      else
        return '';
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
    // downVideo () {
    //   const a = document.createElement('a')
    //   a.setAttribute('download', '虚拟工坊')
    //   a.setAttribute('href', this.playerOptions.sources[0].src)
    //   a.click()
    // },
    download(url){
      let link = document.createElement("a"); //创建a标签
      link.style.display = "none"; //使其隐藏
      link.href = 'https://' + url; //赋予文件下载地址
      link.setAttribute("download", '虚拟工坊'); //设置下载属性 以及文件名
      // document.body.appendChild(link); //a标签插至页面中
      link.click(); //强制触发a标签事件
    }
  }
}
</script>

<style>
.container{
  width: 1200px;
  margin: auto;
  padding: 30px 0;
}
.clearfix{
  text-align: left;
  /*background: rgba(255,80,0,0.1);*/
}
.title{
  width: 100%;
  margin-left: 40px;
  /*color: rgba(255, 80, 0, 0.7);*/
  font-size: 24px;
  /*line-height: 50px;*/
}

.box-card{
  height: 100%;
  padding: 0;
}


.tag{
  min-width: 100px;
  line-height: 40px;
  text-align: center;
  font-size: 14px;
  min-height: 40px;
  margin: 10px;
}

.box{
  padding: 10px 60px;
  text-align: left;
  line-height: 50px;
}

/*.myRadio{*/
/*  margin-left:10px;*/
/*}*/
/*.myRadio{*/
/*  color: #ff5000;*/
/*  background-color: #ff5000;*/
/*}*/

/*.radio-wrapper {*/
/*  display: flex;*/
/*  flex-direction: row;*/
/*  align-items: center;*/
/*.icon {*/
/*  width: 30px;*/
/*  height: 30px;*/
/*  margin-left: 5px;*/
/*  margin-right: 5px;*/
/*}*/
/*}*/
/*.radio-border {*/
/*  width: 180px;*/
/*  height: 70px;*/
/*  border-radius: 5px;*/
/*  border: 1px solid #d7dae2;*/
/*}*/
.line{
  /*margin: 10px auto;*/
  font-size: 16px;
  line-height: 50px;
}
.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}
</style>
