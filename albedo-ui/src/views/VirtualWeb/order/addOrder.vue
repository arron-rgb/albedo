<template>
    <div class="container">
      <el-row>
        <el-col span="18">
          <el-collapse accordion class="container-box">
            <el-collapse-item v-for="item in data" :key="item">
              <template slot="title">{{item.title}}</template>

              <el-radio-group v-model="selectData" @change="videoList(item.title, o)" v-for="o in item.data" :key="o" size="small">
                <el-radio-button :label="o.value">
                  <img class="img" v-show="o.url !== null" :src="o.url">
                  <div class="button-text">{{o.value}}</div>
                </el-radio-button>
                <div v-show="o.value !== null" class="button-text" style="line-height: 20px; color: #909399">{{o.value}}</div>
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
            <el-tag v-for="(item, index) in backData" v-show="backData.length > 0" :type="typeList[index % 5]" :key="item" class="myTags">
              {{item.data[0].value}}
            </el-tag>
          </el-card>
        </el-col>
      </el-row>
    </div>
</template>
<script>
import crudConfig from '@/views/biz/config/config-service'
import crudOrder from '@/views/biz/order/order-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import storeApi from '@/utils/store'
export default {
  name: "addOrder",
  data () {
    return {
      backData : [],
      data : [],
      selectData : '',
      typeList : ["", "success", "info", "warning", "danger"],
    }
  },
  created() {
    // this.getData();
    this.getCurrentOrder()
  },
  methods : {
    getCurrentOrder(){//获取当前订单
      return new Promise((resolve, reject) => {
        crudOrder.current().then(res => {
          console.log(res);
          if (res.code === MSG_TYPE_SUCCESS) {
            if(res.data.state === 5){//上一单已完结，可以进行下一单
              this.getData();
            }
            else if(res.data.state === 0){//有订单创建未付款
              storeApi.set({
                name: 'videoOrder',
                content: res.data,
                type: 'session'
              });
              this.$alert('您有订单尚未付款，即将前往付款页面！', '警告', {
                confirmButtonText: '确定',
              }).then(() => {
                this.goTo("/payOrder", "hadOrder");
              });
            }
            else if(res.data.state === 1 || res.data.state === 2 ){//已付款尚未制作
              storeApi.set({
                name: 'videoOrder',
                content: res.data,
                type: 'session'
              });
              this.goTo('/waiting');
            }
            else if(res.data.state === 4){//已经选好台词尚未加入音频
              storeApi.set({
                name: 'videoOrder',
                content: res.data,
                type: 'session'
              });
              this.goTo('/waiting');
            }
            else if(res.data.state === 3){//视频已上传等待配音
              storeApi.set({
                name: 'videoOrder',
                content: res.data,
                type: 'session'
              });
              this.goTo('/addDetail')
            }
            // this.data = res.data.data
          }
        }).catch(error => {
          this.getData();//没有新订单，可以进行下一单
        })
      })
    },
    getData(){
      //获得视频属性数据
      return new Promise((resolve, reject) => {
        crudConfig.list().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            console.log(res)
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
        this.backData.push({
          title : title,
          data : [{name : data.name, value : data.value}]
        })
      } else {
        //修改数据
        this.backData[dataIndex].data = [{name : data.name, value : data.value}];
      }
    },
    toPay() {
      //没有选完选项
      if (this.data.length > this.backData.length) {
        //找到没有选择的第一个选项
        for (var i = 0; i < this.data.length ; i++) {
          // console.log(this.data[i].title)
          var dataIndex = this.backData.findIndex(o => o.title === this.data[i].title);
          // console.log(dataIndex)
          if (dataIndex === -1) {
            this.$alert('“' + this.data[i].title + '”尚未选择', '警告', {
              confirmButtonText: '确定',
            });
          }
        }
      }
      else{
        //保存已选的视频选项
        // console.log(this.backData)
        storeApi.set({
          name: 'videoConfig',
          content: this.backData,
          type: 'session'
        })

        storeApi.set({//更新步骤条状态
          name: 'orderState',
          content: 1,
          type: 'session'
        });
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
  max-width: 210px;
  line-height: 32px;
  font-size: 14px;
  padding: 0 20px;
}

.box-card{
  height: 300px;
}
.myTags{
  min-width: 80px;
  line-height: 40px;
  text-align: center;
  font-size: 14px;
  min-height: 40px;
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
