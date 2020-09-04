<template>
  <div>
<!--    步骤条-->
    <step-line></step-line>

    <div class="container">
      <el-row>
        <el-col span="18">
          <el-collapse accordion class="container-box">
            <el-collapse-item v-for="item in data" :key="item">
              <template slot="title">{{item.title}}</template>
              <el-radio-group v-model="selectData" @change="videoList(item.title, o.value)" v-for="o in item.data" :key="o" size="small">
                <el-radio-button :label="o.value">
                  <img class="img" src="https://img.xiaopiu.com/userImages/img42507173b7e04c88.png">
                  <div class="button-text">{{o.value}}</div>
                </el-radio-button>
              </el-radio-group>
            </el-collapse-item>
          </el-collapse>
        </el-col>
        <el-col span="6">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>已选需求</span>
              <el-button style="float: right; padding: 3px 0" type="text" @click="toPay()">前往支付></el-button>
            </div>
            <el-tag v-for="item in backData" v-show="backData.length > 0" type="warning" :key="item" class="mytabs">
              {{item.data}}
            </el-tag>
          </el-card>
        </el-col>
      </el-row>
    </div>
  </div>
</template>
<script>
import stepLine from "@/components/VirtualWeb/stepLine";
import crudOrderForm from '@/views/biz/order-form/order-form-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";

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
      selectData : "",
      backData : [],
      data : []
    }
  },
  created() {
    this.getData()
  },
  methods : {
    getData(){
      //获得视频属性数据
      return new Promise((resolve, reject) => {
        crudOrderForm.getVedioConfig().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.data = res.data.data
          }
        }).catch(error => {
          reject(error)
        })
      })
    },
    videoList(title, data) {
      var dataIndex = this.backData.findIndex(o => o.title === title);
      if (dataIndex === -1) {
        //列表中没有数据
        this.backData.push(
          {
            title: title,
            data: data
          }
        )
      } else {
        //修改数据
        this.backData[dataIndex].data = data;
      }
    },
    toPay() {
      //没有选完选项
      if (this.data.length > this.backData.length) {
        //找到没有选择的第一个选项
        for (var i = 0; i < this.data.length ; i++) {
          console.log(this.data[i].title)
          var dataIndex = this.backData.findIndex(o => o.title === this.data[i].title);
          console.log(dataIndex)
          if (dataIndex === -1) {
            this.$alert('“' + this.data[i].title + '”尚未选择', '警告', {
              confirmButtonText: '确定',
            });
          }
        }
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

/*.img-button{*/
/*  padding: 2px;*/
/*}*/
.select-button{
  margin-bottom: 10px;
  padding: 2px;
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

/*.el-tabs__item:hover {*/
/*  color: #ff5000;*/
/*  cursor: pointer;*/
/*}*/
/*.el-tabs__item:focus {*/
/*  color: #ff5000;*/
/*  cursor: pointer;*/
/*}*/
/*.el-tabs__active-bar{*/
/*  background-color: #ff5000;*/
/*}*/
/*.el-tabs__item.is-active{*/
/*  color: #ff5000;*/
/*}*/
/*.title{*/
/*  text-align: center;*/
/*  font-size: 18px;*/
/*  color: #0D203E;*/
/*  line-height: 40px;*/
/*  padding: 10px 0 40px 0;*/
/*}*/

/*.button-box{*/
/*  margin: 20px;*/
/*}*/
.img{
  width: 210px;
  height: 280px;
}
.button-text{
  line-height: 32px;
  font-size: 14px;
  padding: 0 20px;
}

/*.transition-box {*/
/*  margin-bottom: 10px;*/
/*  width: 200px;*/
/*  height: 100px;*/
/*  border-radius: 4px;*/
/*  background-color: #409EFF;*/
/*  text-align: center;*/
/*  color: #fff;*/
/*  padding: 40px 20px;*/
/*  box-sizing: border-box;*/
/*  margin-right: 20px;*/
/*}*/

.box-card{
  height: 300px;
}
.mytabs{
  margin: 10px;
}
</style>
