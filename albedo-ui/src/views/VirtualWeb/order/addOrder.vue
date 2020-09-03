<template>
  <div>
<!--    步骤条-->
    <step-line></step-line>

    <div class="container">
      <el-row>
        <el-col span="18">
          <el-collapse accordion class="container-box">
            <el-collapse-item>
              <template slot="title">您所属的类型</template>
              <div>
                  <el-button class="select-button" @click="backData.belongType = item" border="true" v-for="(item) in list.belongType" :label="item" :key="item">
                    {{item}}
                  </el-button>
              </div>

<!--              {{backData.belongType}}-->

            </el-collapse-item>
            <el-collapse-item>
              <template slot="title">您喜欢的主播模式</template>
              <div>
    <!--            {{backData.anchorType}}-->

                <el-tabs v-model="anchorType" @tab-click="handleClick">
                  <el-tab-pane v-for="(item) in list.anchorType" :label="item" :key="item">
                    <div class="title">请选择主播姿势</div>
<!--                    <div>{{backData.anchorPosture}}</div>-->
                    <el-button class="select-button img-button" @click="backData.anchorPosture = item.text" border="true" v-for="(item) in anchor[anchorType]" :label="item" :key="item">
                      <img class="img" :src="item.img">
                      <div class="button-text">{{item.text}}</div>
                    </el-button>
                  </el-tab-pane>
                </el-tabs>

    <!--            <div style="margin-top: 20px; height: 200px;">-->
    <!--              <el-collapse-transition>-->
    <!--                <div v-show="isShow">-->
    <!--                  <el-carousel :autoplay="false" indicator-position="none" arrow="never">-->
    <!--                    <el-carousel-item v-for="item in list.anchorType.length" :key="item">-->
    <!--                      <div class="title">请选择主播姿势</div>-->
    <!--                      <el-button class="select-button" @click="backData.anchorPosture = item" border="true" v-for="(item) in anchor[backData.anchorType]" :label="item" :key="item">-->
    <!--                        {{item}}-->
    <!--                      </el-button>-->
    <!--                    </el-carousel-item>-->
    <!--                  </el-carousel>-->
    <!--                </div>-->
    <!--              </el-collapse-transition>-->
    <!--            </div>-->


    <!--            <el-tabs v-model="backData.anchorType" type="border-card">-->
    <!--              <el-tab-pane v-for="(item) in list.anchorType"-->
    <!--              :key="item" :label=item>-->
    <!--                <div class="title">-->
    <!--                  请选择主播姿势-->
    <!--                </div>-->
    <!--                <div>-->
    <!--                  {{backData.anchorPosture}}-->
    <!--                  <el-radio-group v-model="backData.anchorPosture" >-->
    <!--                    <el-radio-button class="button-box" v-for="(item, i) in anchor[backData.anchorType]"-->
    <!--                              :key="i" :label=item.text>-->
    <!--                      <img class="img" :src="item.img">-->
    <!--                      <div class="button-text">{{item.text}}</div>-->
    <!--                    </el-radio-button>-->
    <!--                  </el-radio-group>-->
    <!--                </div>-->

    <!--              </el-tab-pane>-->
    <!--            </el-tabs>-->
              </div>
            </el-collapse-item>
          </el-collapse>
        </el-col>
        <el-col span="6">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>已选需求</span>
              <el-button style="float: right; padding: 3px 0" type="text">前往支付></el-button>
            </div>
            <el-tag v-for="item in backData" v-show="item != -1" type="warning" :key="item" class="mytabs">
              {{item}}
            </el-tag>
          </el-card>
        </el-col>
      </el-row>
    </div>
  </div>
</template>
<script>
import stepLine from "@/components/VirtualWeb/stepLine";
export default {
  name: "page order 1",
  components : {
    stepLine,
  },
  data () {
    return {
      msg: "我是page1组件",
      isShow : 0,
      anchorType: 0,
      backData : {belongType: -1, anchorPosture: "-1"},
      list: {belongType : ["美妆护肤、时尚配饰","母婴萌娃", "家电乐器、汽车嗨购",
          "美食吃货、乡村味道", "旅行看世界", "日用小百货"],
        anchorType: ["单人主播模式", "双人主播模式"]},
      anchor : [
        [{text : "单人站播", img : "https://img.xiaopiu.com/userImages/img42507173b7e04c88.png"},
          { text : "单人坐播", img : "https://img.xiaopiu.com/userImages/img42507173b7e04c88.png"}],
        [{text : "双人站播", img : "https://img.xiaopiu.com/userImages/img42507173b7e04c88.png"},
          { text : "双人坐播", img : "https://img.xiaopiu.com/userImages/img42507173b7e04c88.png"}]
      ],
      data : {
        "anchorNum": [
          {
            "id": 6,
            "name": "anchorNum",
            "value": "单人主播"
          },
          {
            "id": 7,
            "name": "anchorNum",
            "value": "双人主播"
          }
        ],
        "seat": [
          {
            "id": 8,
            "name": "seat",
            "value": "站姿"
          },
          {
            "id": 9,
            "name": "seat",
            "value": "坐姿"
          }
        ],
        "style": [
          {
            "id": 13,
            "name": "style",
            "url": "http://www.baidu.com",
            "value": "度假"
          },
          {
            "id": 14,
            "name": "style",
            "url": "http://www.baidu.com",
            "value": "海边"
          }
        ],
        "label": [
          {
            "id": 4,
            "name": "label",
            "value": "美妆护肤"
          },
          {
            "id": 5,
            "name": "label",
            "value": "时尚配饰"
          }
        ],
        "anchorType": [
          {
            "id": 10,
            "name": "anchorType",
            "value": "活力青春型"
          },
          {
            "id": 11,
            "name": "anchorType",
            "value": "成熟稳重型"
          },
          {
            "id": 12,
            "name": "anchorType",
            "value": "浪漫古风型"
          }
        ],
        "plusService": {
          "component": [
            {
              "id": 17,
              "name": "component",
              "url": "http://www.baidu.com",
              "value": "气球"
            },
            {
              "id": 18,
              "name": "component",
              "url": "http://www.baidu.com",
              "value": "狗"
            }
          ],
          "color": [
            {
              "id": 23,
              "name": "color",
              "url": "http://www.baidu.com",
              "value": "red"
            },
            {
              "id": 24,
              "name": "color",
              "url": "http://www.baidu.com",
              "value": "#000"
            }
          ],
          "clothes": [
            {
              "id": 21,
              "name": "clothes",
              "url": "http://www.baidu.com",
              "value": "衣服1"
            },
            {
              "id": 22,
              "name": "clothes",
              "url": "http://www.baidu.com",
              "value": "衣服2"
            }
          ],
          "hairstyle": [
            {
              "id": 19,
              "name": "hairstyle",
              "url": "http://www.baidu.com",
              "value": "发型1"
            },
            {
              "id": 20,
              "name": "hairstyle",
              "url": "http://www.baidu.com",
              "value": "发型2"
            }
          ]
        }
      }
  //   {label : "您喜欢的主播", msg : [{text : "活力青春型1号", img : "https://img.xiaopiu.com/userImages/img42082173b7808cd0.png"},
  //     { text : "活力青春型2号", img : "https://img.xiaopiu.com/userImages/img42082173b7808cd0.png"},
  //     { text : "成熟稳重型1号", img : "https://img.xiaopiu.com/userImages/img42233173b7924bc8.png"},
  //     { text : "成熟稳重型2号", img : "https://img.xiaopiu.com/userImages/img42236173b7928e30.png"},
  //   ]},
  // ]
    }
  },
  methods : {
    dataChange(data){
      console.log(data)
      this.backData.belongType = data;
    },
    paneShow(){
      if(this.backData.anchorType === 0)
      {
        this.isShow = !this.isShow;
      }
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
.container-box{
  margin: auto;
  margin: 0 30px;
  padding: 0 30px;
  /*float: left;*/
  border: 1px solid #EBEEF5;
  background-color:#FFF;
  border-radius: 4px;
  color: #303133;
  transition: .3s;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
}

.img-button{
  padding: 2px;
}
.select-button{
  margin-bottom: 10px;
}
.select-button:hover{
  background-color: rgba(255, 237, 229, 0.4);
  color: #ff5000;
  border-color: #ff5000;
}

.select-button:focus{
  background-color: rgb(255, 80, 0);
  color: white;
  border: 0;
  /*margin: 0 5px;*/
}

.el-tabs__item:hover {
  color: #ff5000;
  cursor: pointer;
}
.el-tabs__item:focus {
  color: #ff5000;
  cursor: pointer;
}
.el-tabs__active-bar{
  background-color: #ff5000;
}
.el-tabs__item.is-active{
  color: #ff5000;
}
.title{
  text-align: center;
  font-size: 18px;
  color: #0D203E;
  line-height: 40px;
  padding: 10px 0 40px 0;
}

.button-box{
  margin: 20px;
}
.img{
  width: 210px;
  height: 280px;
}
.button-text{
  line-height: 40px;
  font-size: 16px;
}

.transition-box {
  margin-bottom: 10px;
  width: 200px;
  height: 100px;
  border-radius: 4px;
  background-color: #409EFF;
  text-align: center;
  color: #fff;
  padding: 40px 20px;
  box-sizing: border-box;
  margin-right: 20px;
}

.box-card{
  height: 300px;
}
.mytabs{
  margin: 10px;
}
</style>
