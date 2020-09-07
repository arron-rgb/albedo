<template>
    <div class="container">
      <el-row>
        <el-col span="18">
          <el-collapse accordion class="container-box">
            <el-collapse-item v-for="item in data" :key="item">
              <template slot="title">{{item.title}}</template>

              <el-radio-group v-model="selectData" @change="videoList(item.title, o.value)" v-for="o in item.data" :key="o" size="small">
                <el-radio-button :label="o.value">
                  <img class="img" v-show="o.url !== null" :src="o.url">
                  <div class="button-text">{{o.value}} {{o.url}}</div>
                </el-radio-button>
              </el-radio-group>
            </el-collapse-item>
          </el-collapse>
        </el-col>
        <el-col span="6">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>已选需求</span>
              <a class="text-button" @click="toPay()">前往支付></a>
            </div>
            <el-tag v-for="item in backData" v-show="backData.length > 0" type="warning" :key="item" class="mytabs">
              {{item.data}}
            </el-tag>
          </el-card>
        </el-col>
      </el-row>
    </div>
</template>
<script>
import crudConfig from '@/views/biz/config/config-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import storeApi from '@/utils/store'
export default {
  name: "addOrder",
  data () {
    return {
      backData : [],
      data : [],
      selectData : '',
    }
  },
  created() {
    this.getData()
  },
  methods : {
    getData(){
      //获得视频属性数据
      return new Promise((resolve, reject) => {
        crudConfig.list().then(res => {
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
      else{
        //保存已选的视频选项
        storeApi.set({
          name: 'videoConfig',
          content: this.backData,
          type: 'session'
        })
        this.goTo("/payOrder");
      }
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
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

.img{
  width: 210px;
  height: 280px;
}
.button-text{
  line-height: 32px;
  font-size: 14px;
  padding: 0 20px;
}

.box-card{
  height: 300px;
}
.mytabs{
  margin: 10px;
}
.text-button{
  /*color: #1890ff;*/
  color: #ff5000;
  font-size: 14px;
  float: right;
  padding: 3px 0;
}
.text-button:hover{
  color: #ff5000;
}
</style>
