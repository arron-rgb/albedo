<template>
    <div class="selectAttri">
<!--        <div class="directBar">-->
<!--            <h3>选择配音属性</h3>-->
<!--            <div class="directBtn">-->
<!--                <el-button  @click="next">下一步</el-button>-->
<!--            </div>-->
<!--        </div>-->
        <div class="markContainer">
<!--          人工配音音色-->
            <div class="addLogo">
                <h3 class="barTitle">
                    选择音色属性
                </h3>
                <div class="selectBar" v-if="this.dubType === '1'">
                    <div class="attriType" v-for="(list,index) in attriType" :key="index">
                        <div class="listType">{{list.listType}}</div>
                        <div class="attriList">
                            <el-button style="border:1px solid #ebeef5" v-for="(attri,id) in list.list" :key="id" @click="addVoice(index,id)"
                            :class="{active:attriType[index].active===id,'select-button':attriType[index].active!==id}">
                                {{attri}}
                            </el-button>
                        </div>
                    </div>
                </div>


<!--              机器配音音色-->
              <div class="selectBar" v-if="this.dubType === '2'">
<!--                <div class="selectBar">-->
                <div class="attriType" v-for="(list,index) in machineAttri" :key="index">
                  <div class="listType">{{list.listType}}</div>
                  <div class="attriList"  v-for="(attri,id) in list.list" :key="id" @click="selectVoice(attri)">
                    <el-tooltip content="点击试听" placement="top">
                      <el-button style="border:1px solid #ebeef5" @click="voiceList = [{data : attri.value, id : attri.id}]"
                                 :class="{active:attriType[index].active===id,'select-button':attriType[index].active!==id}">
                        {{attri.value}}
                        <i class="el-icon-bell"></i>
                      </el-button>
                    </el-tooltip>
<!--                    <m-audio class="voiceButton" src="" :text="attri.value"></m-audio>-->
                  </div>
                </div>
                  <audio v-show="false" ref="audio" src=""></audio>
              </div>
            </div>
            <div class="showSelected">
              <el-row style="min-height: 100px;">
                <h3 class="barTitle">
                    已选属性
                </h3>
<!--                <div  class="selectedAttri">-->
                <el-tag v-for="(item,id) in voiceList" :key="item" :type="typeList[id % 5]" class="myTags">{{item.data}}</el-tag>
<!--                <span v-if="this.dubType === '2'" style="line-height: 45px; margin-left: 100px">{{ backData }}</span>-->
                <!--                </div>-->
              </el-row>
              <el-row style="text-align: left; margin-top: 10px;">
                <el-col span="6">
                  <h3 class="barTitle">
                    配音字数
                  </h3>
                </el-col>
                <el-col span="5" style="margin-top: 3px">
                  <span style="font-size: 30px; color: #ff5000">{{this.words}}</span>
                </el-col>
                <el-col span="13">
                  <span style="line-height: 45px">字</span>
                </el-col>
              </el-row>
              <el-row style="text-align: left; margin-top: 10px;">
                <el-col span="6">
                  <h3 class="barTitle">
                    预计时长
                  </h3>
                </el-col>
                <el-col span="5" style="margin-top: 3px">
                  <span style="font-size: 30px; color: #ff5000">{{this.time}}</span>
                </el-col>
                <el-col span="3">
                  <span style="line-height: 45px">分钟</span>
                </el-col>
                <el-col span="10" v-if="this.dubType === '1'">
                  <span style="line-height: 45px; color: #666666">
                    （套餐余量：
                    {{this.audioTime}}分钟）</span>
                </el-col>
              </el-row>
              <el-row style="text-align: left; margin-top: 10px;" v-if="this.dubType === '1'">
                <el-col span="6">
                  <h3 class="barTitle">
                    配音价格
                  </h3>
                </el-col>
                <el-col span="5" style="margin-top: 3px">
                  <span style="font-size: 30px; color: #ff5000">{{this.price}}</span>
                </el-col>
                <el-col span="13">
                  <span style="line-height: 45px">元</span>
                </el-col>
              </el-row>
              <el-row style="margin-top: 30px">
                <el-button :loading="loading" type="primary" style="width: 300px" @click="payDub">{{this.dubType === '1' ? '前往支付' : '提交'}}</el-button>
              </el-row>
            </div>
        </div>
    </div>
</template>
<script>
import storeApi from "@/utils/store";
import payOrder from "@/views/VirtualWeb/order/payOrder-server";
import {MSG_TYPE_SUCCESS} from "@/const/common";
import {mapGetters} from "vuex";

export default {
  data() {
    return {
      loading: false,
      attriType: [
        {listType: '性别', list: ['男', '女'], active: -1},
        {listType: '声音', list: ['婴儿', '儿童', '少年', '青年', '中年'], active: -1},
        {listType: '类型', list: ['讲述播报', '综艺播报', '新闻播报'], active: -1},
        {listType: '标签', list: ['大气', '活力', '浑厚', '甜美', '激情'], active: -1}
      ],
      machineAttri: [
        {
          listType: '男声', list: [{value: '亲和男声', id: 1, url : 'https://static.vlivest.com/e8ff2ce3d906f4fb6d912134bbd1a9b7.mp3'},
            {value: '成熟男声', id: 2, url : 'https://static.vlivest.com/d5403c16008e0f85e7f1fea0ebfeb41e.mp3'},
            {value: '情感男声', id: 6, url : 'https://static.vlivest.com/9658768c83869c4c8df83571dcdc02d7.mp3'}]
        },
        {
          listType: '女声', list: [{value: '亲和女声', id: 0, url : 'https://static.vlivest.com/664e6a26b95d70a01e258d5b7179aca5.mp3'},
            {value: '温暖女声', id: 4, url : 'https://static.vlivest.com/c4e19299b5582b9c680d6374c0afd563.mp3'},
            {value: '情感女声', id: 5, url : 'https://static.vlivest.com/fe449a95a29ddf9899ec0b0817c92334.mp3'},
            {value: '客服女声', id: 7, url : 'https://static.vlivest.com/a2358c7afbcbb73c62b24d3bd4a64744.mp3'},
            {value: '通用女声', id: 1002, url : 'https://static.vlivest.com/5d0a9791aae1f56931463024c25c969a.mp3'},]
        }
      ],
      typeList: ["", "success", "info", "warning", "danger"],
      words: 0,
      time: '',
      price: '',
      dubType: '',
      backData: null,
      videoOrder: '',
      voiceList:[],
      audioTime : 0,
    }
  },
  computed: {
    ...mapGetters([
      'balance',
    ])
  },
  created() {
    var videoOrder = storeApi.get({
      name: 'videoOrder',
    }) || null;
    var textList = storeApi.get({
        name: 'textList',
      }) || null;
    if (videoOrder === null || videoOrder === undefined || textList === null || textList === undefined) {
      this.$alert('请先选择视频基础需求', {
        confirmButtonText: '确定',
      }).then(
        // this.goTo('/addOrder')
      );
    } else {
      this.videoOrder = videoOrder;
    }

    var list = storeApi.get({ name: 'priceData' });//获得所有的静态资源list
    var dataIndex = list.findIndex(o => o.label === '人工配音');
    // 向上取整
    this.words = storeApi.get({
      name: 'words'
    }) || 0;
    this.balance.audioTime === null ? this.audioTime = 0 : this.audioTime = this.balance.audioTime
    this.time = Math.ceil(this.words / 200);
    this.time > this.audioTime ? this.price = (this.time - this.audioTime) * list[dataIndex].value : this.price = 0;
    //获取配音方式
    this.dubType = storeApi.get({
      name: 'dubType'
    }) || null;
    if (this.dubType === null || this.dubType === undefined) {
      this.$alert('请先选择配音方式！', '警告', {
        confirmButtonText: '确定',
      }).then(
        this.$router.replace('addDetail')
      );
    }
  },
  methods: {
    addVoice(listid, id){
      var selectItem = {
        title : this.attriType[listid].listType,
        data : this.attriType[listid].list[id]
      }
      var dataIndex = this.voiceList.findIndex(o => o.title === selectItem.title);
      if(dataIndex === -1){//不在库里
        this.voiceList.push(selectItem);
      }
      else{
        this.voiceList[dataIndex] = selectItem;
      }
      this.attriType[listid].active = id;
    },
    // next(){
    //     this.$router.replace('paymentPage')
    //     this.$store.commit('NEXT')
    // },
    selectVoice(attri){
      console.log(attri);
      this.voiceList = [{data : attri.value, id : attri.id}];
      this.$refs.audio.src =  attri.url;
      this.$refs.audio.play();
    },
    payDub() {
      if (this.dubType === '1') {//人工配音订单
        if (this.voiceList.length < 4) {
          this.$alert('请完整选择音色属性！', '提示', {
            confirmButtonText: '确定',
          });
        } else {
          this.loading = true;
          //提交订单
          var text = [];
          for(var i = 0; i < this.voiceList.length; i++){
            text.push(this.voiceList[i].data)
          }
          this.saveText(null,text)
        }
      }
      if (this.dubType === '2') {//机器配音订单
        if (this.voiceList.length !== 1) {
          this.$alert('请完整选择音色属性！', '提示', {
            confirmButtonText: '确定',
          });
        } else {
          //提交订单
          this.loading = true;
          this.saveText(this.voiceList[0].id, null);
        }
      }
    },
    saveText(voiceType, description) {//提交支付请求
      // console.log(this.videoOrder);
      var data = {
        orderId: this.videoOrder.id,
        voiceType:voiceType === null ? description : [voiceType],
        type: this.dubType,//配音方式  0上传   1下单   2合成
        totalAmount: this.price,
        content: storeApi.get({
          name: 'textList',
        }),
        duration: storeApi.get({
          name: 'duration',
        }),
      }

      return new Promise((resolve, reject) => {
        payOrder.placeSecond(data).then(res => {//保存订单并获取订单id
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)

            if(data.type === '2'){//机器配音
              storeApi.clear({
                name: 'textList',
              });
              storeApi.clear({
                name: 'duration',
              });
              this.loading = false;
              this.goTo('/addOrder');
            }else{//人工配音
              storeApi.clear({
                name: 'textList',
              });
              storeApi.clear({
                name: 'duration',
              });
              this.loading = false;
              if(res.data === null){//用套餐余量抵消成功
                this.$alert("人工配音订单提交成功，请耐心等待！", '提示', {
                  confirmButtonText: '确定',
                  callback: action => {
                    this.goTo('/addOrder');
                  }
                });
                resolve(res);
              }else{
                this.$alert("人工配音订单提交成功，即将前往支付页面！", '提示', {
                  confirmButtonText: '确定',
                  callback: action => {
                    window.open(res.data);
                  }
                });
              }
            }
          }
          this.loading = false;
        }).catch(error => {
          reject(error)
          this.loading = false;
        })
      })
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
  },
}
</script>
<style lang="scss" scoped>
.selectAttri{
    width:100%;
    .directBar{
        width:100%;
        padding:20px 50px;
        display:flex;
        justify-content: space-between;
        align-items: center;
    }
    .markContainer{
        width:100%;
        height:100%;
        display:flex;
        justify-content: space-around;
        align-items: flex-start;
        //padding:20px 0;
        .addLogo{
          padding: 15px;
          width:700px;
          min-height:200px;
          border:1px solid #ebeef5;
          border-radius: 5px;
            //background-color: rgb(245,247,250);
            .barTitle{
                width:100%;
                padding:10px;
                text-align: left;
              margin: 0;
            }
            .selectBar{
                width:100%;
                height:300px;
                padding: 0 15px;
                display:flex;
                flex-direction: column;
                justify-content: space-evenly;
                align-items: flex-start;
                .attriType{
                    background-color: whitesmoke;
                    display:flex;
                    justify-content: center;
                    align-items: center;
                    .listType{
                        margin:0 20px;
                    }
                    .attriList{
                        background-color:white;
                        display:flex;
                        align-items: center;
                        .el-button{
                            border:1px solid white;
                            & + .el-button{
                                margin-left:0
                            }
                        }

                    }
                     .select-button{
                        &:hover{
                            background-color: rgba(255, 237, 229, 0.4);
                            color: #ff5000;
                            border-color: #ff5000;
                        }

                    }
                     .active{
                        background-color: #ff5000;;
                        color: white;
                        border: 0;
                    }
                }
            }
        }
        .showSelected{
            width:480px;
            margin-left: 20px;
            min-height:370px;
            border-radius: 5px;
            border:1px solid #ebeef5;
            padding: 15px;
            .barTitle{
                width:100%;
                padding:10px;
                text-align: left;
                margin: 0;
            }
            .selectedAttri{
                margin-top: 30px;
                padding:10px 40px;
                height:100px;
                display:flex;
                justify-content:flex-start;
                .el-tag{
                    background-color: #fff8e6;
                    border-color: #fff1cc;
                    color: #ffba00;
                    &:hover {
                        color: #ff5000;
                        cursor: pointer;
                    }
                    &:focus {
                    color: #ff5000;
                    cursor: pointer;
                    }
                    &+ .el-tag{
                        margin-left:20px;
                    }
                }
                .el-tag--small{
                    height:30px;
                    line-height:30px;
                    font-size:14px;
                    border-radius:8px;
                }
            }




        }

    }
}
.myTags{
  min-width: 80px;
  line-height: 40px;
  text-align: center;
  font-size: 14px;
  min-height: 40px;
  margin: 10px;
}
.voiceButton{
  border-radius: 10px;
  height: 40px;
  margin: 3px;
}
.voiceButton:checked{
  border: #ff5000;
  color: #ff5000;
}
</style>
