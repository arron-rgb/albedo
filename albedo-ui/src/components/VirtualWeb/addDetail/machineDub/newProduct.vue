<template>
<div class="newProduct">
  <el-row>

<!--  {{words}}-->

  </el-row>
  <el-row style="text-align: center; margin-top: 10px;">
    <el-col span="3" offset="1">
      <h3>
        当前台词总字数
      </h3>
    </el-col>
    <el-col span="3" style="margin-top: 3px;">
      <span style="font-size: 30px; color: #ff5000">{{words}}</span>
    </el-col>
    <el-col span="1">
      <span style="line-height: 55px">字</span>
    </el-col>
    <el-col span="2" offset="1">
      <h3>
        设置时长
      </h3>
    </el-col>
    <el-col span="2" style="margin-top: 3px;">
      <span style="font-size: 30px; color: #ff5000">{{this.duration}}</span>
    </el-col>
    <el-col span="1">
      <span style="line-height: 55px">分钟</span>
    </el-col>
    <el-col span="2" offset="1">
      <h3>
        预计时长
      </h3>
    </el-col>
    <el-col span="2" style="margin-top: 3px;">
      <span style="font-size: 30px; color: #ff5000">{{Math.ceil(this.words / 200)}}</span>
    </el-col>
    <el-col span="1">
      <span style="line-height: 55px">分钟</span>
    </el-col>
    <el-col span="4">
      <div class="directBar">
        <el-button  @click="next">下一步</el-button>
      </div>
    </el-col>
  </el-row>
<!--  {{this.chooseList}}-->
  <el-dialog
    title="新增商品"
    :visible.sync="productData.dialogVisible"
    width="600px">
    <component v-bind:productData="productData" @fatherMethod="getCommodityList" is="product" ></component>
  </el-dialog>

  <el-dialog
    title="编辑话术"
    :visible.sync="scriptVisible"
    width="600px">
    <el-input
      type="textarea"
      :autosize="{minRows: 5}"
      v-model="editScript.data"
      @input="onInput"></el-input>
    <el-button type="primary" @click="saveScript">保存</el-button>
  </el-dialog>

    <div class="proBar">
      <div class="proDeposit">
        <div class="depositBox">
          <h3 class="barTitle">商品库</h3>
          <el-tooltip class="item" effect="dark" content="添加商品" placement="bottom">
            <i class="el-icon-plus" @click="productData.dialogVisible = !productData.dialogVisible"></i>
          </el-tooltip>
        </div>
        <el-scrollbar>
            <el-card
              class="list-group-item"
              v-for="(item,index) in this.productList[pager - 1]"
              :key="index"
              v-loading="commodityLoading"
            >
              <el-row>
                <el-col span="6">
                  <img class="commodityImg" :src="'http://' + item.urls">
                </el-col>
                <el-col style="padding-left: 10px" span="18">
                  <el-row>
                    <el-col span="19">
                      <span style="font-size: 18px; line-height: 30px">{{item.name}}</span>
                    </el-col>
                    <el-col span="3">
                      <el-tooltip class="item" effect="dark" content="删除商品" placement="top">
                        <i class="el-icon-circle-close" @click.stop="deleteItem(item.id)"></i>
                      </el-tooltip>
                    </el-col>
                    <el-col span="2">
                      <el-tooltip class="item" effect="dark" content="添加" placement="right">
                        <i class="el-icon-right" @click.stop="add(item, 'product')"></i>
                      </el-tooltip>
                    </el-col>
                  </el-row>
                  <el-row>
                    <p style="text-align: left; margin: 0; line-height: 30px;font-size: 14px">{{item.description}}</p>
                  </el-row>
                </el-col>
              </el-row>
            </el-card>
        </el-scrollbar>
        <el-pagination
          layout="prev, pager, next"
          @current-change="currentChange"
          :total="productData.proDeposit.length">
        </el-pagination>
      </div>


      <div class="proContainer">
        <h3 class="barTitle">已选台词组件</h3>
        <el-scrollbar>
          <draggable
            tag="el-collapse"
            class="dragArea list-group"
            :list="chooseList"
            group="comp"
          >
<!--            <el-collapse-->
<!--            class="list-group-item left"-->
<!--            v-for="(item,index) in chooseList"-->
<!--            :key="index"-->
<!--            v-model="activeNames"-->
<!--            @change="handleChange"-->
<!--            >-->
<!--              <el-collapse-item>-->

                <el-card
                  class="list-group-item"
                  v-for="(item,index) in chooseList"
                  :key="index"
                >
                  <el-row v-if="item.type === 'product'">
                    <el-col span="6">
                      <img class="commodityImg" :src="'http://' + item.data.urls">
                      <!--                  <img class="commodityImg" src="@/assets/VirtualWeb/timg.jpg">-->
                    </el-col>
                    <el-col style="padding-left: 10px" span="18">
                      <el-row>
                        <el-col span="22">
                          <span style="font-size: 18px; line-height: 30px">{{item.data.name}}</span>
                        </el-col>
                        <el-col span="2">
                          <el-tooltip class="item" effect="dark" content="移除" placement="top">
                            <i class="el-icon-circle-close" @click.stop="removeItem(index)"></i>
                          </el-tooltip>
                        </el-col>
                      </el-row>
                      <el-row>
                        <p style="text-align: left; margin: 0; line-height: 30px;font-size: 14px">{{item.data.description}}</p>
                      </el-row>
                    </el-col>
                  </el-row>

                  <el-row class="text" v-if="item.type === 'script'">
                    <el-col span="22">
                      {{item.data.value}}
                    </el-col>
                    <el-col span="2" style="padding-left: 10px">
                      <el-tooltip class="item" effect="dark" content="移除" placement="top">
                        <i class="el-icon-circle-close" @click.stop="removeItem(index)"></i>
                      </el-tooltip>
                      <el-tooltip class="item" effect="dark" content="编辑话术" placement="bottom">
                        <i class="el-icon-edit-outline" @click.stop="showEdit(index, item.data.value)"></i>
                      </el-tooltip>

                    </el-col>
                  </el-row>
                </el-card>
          </draggable>
        </el-scrollbar>

      </div>
      <div class="script">
        <h3 class="barTitle">话术列表</h3>
        <div class="inline-input">
<!--          <el-autocomplete-->
<!--          clearable-->
<!--          style="width: 80%"-->
<!--          v-model="search"-->
<!--          :fetch-suggestions="querySearch"-->
<!--          placeholder="请输入内容"-->
<!--          >-->
<!--          </el-autocomplete>-->
        </div>
        <el-collapse accordion>
          <el-collapse-item :title="item.title" v-for="item in this.scriptData">

            <el-card
              class="list-group-item"
              v-for="(item,index) in item.data"
              :key="index"
            >
              <div class="text">
                <el-tooltip class="item" effect="dark" content="添加" placement="top">
                  <i class="el-icon-back" @click.stop="add(item, 'script')"></i>
                </el-tooltip>
                {{item.value}}
              </div>

            </el-card>
          </el-collapse-item>
        </el-collapse>

      </div>
  </div>
  </div>
</template>
<script>
import product from './product'
import scriptItem from './scriptItem'
import draggable from "vuedraggable"
import crudCommodity from '@/views/biz/commodity/commodity-service'
import crudScript from '@/views/biz/script/script-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import storeApi from "@/utils/store";

// let anchorName='W';
// let touristName='LH';
// let deadline=28;
// let restTime=5;
// let startTime=8;
// let price = 200;
export default {
  name: "proDetail",
  components : {
    product,
    scriptItem,
    draggable,
  },
  data() {
    return {
      commodityLoading: false,
      scriptLoading: false,
      imageUrl: '',
      search:'',
      scriptVisible: false,
      productData :{
        dialogVisible: false,
        // 商品库
        proDeposit:[],
      },
      pager : 1,
      productList : [],
      scriptData : [],
      chooseList: [],
      editScript: {
        index : '',
        data : '',
      },
      words : 0,
      duration : 0,
      videoOrder : null,
    }
  },
  created() {
    var videoOrder = storeApi.get({
      name: 'videoOrder'
    });
    var duration = storeApi.get({
      name: 'duration'
    }) || null;
    if (videoOrder === null || videoOrder === undefined || duration === null || duration === undefined) {
      this.$alert('请先选择视频基础需求', {
        confirmButtonText: '确定',
      }).then(
        this.goTo('/addOrder')
      );
    }
    else {
      this.videoOrder = videoOrder;
      this.getScripts()
      this.getCommodityList();
      this.duration = duration || 0;
      // console.log(this.duration);
      if(this.duration === 0 || this.duration === undefined){
        this.$alert('请先选择视频长度！', '警告', {
          confirmButtonText: '确定',
        }).then(
          this.$router.replace('addDetail')
        );
      }
    }
  },
  methods: {

    //获得套词
    getScripts() {
      return new Promise((resolve, reject) => {
        crudScript.list().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.scriptData = res.data.data
          }
        }).catch(error => {
          reject(error)
        })
      })
    },
    //获取商品库
    getCommodityList() {
      this.commodityLoading = true;
      return new Promise((resolve, reject) => {
        crudCommodity.get().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.productData.proDeposit = res.data
            var i = 0;
            for (i; i < this.productData.proDeposit.length / 10; i++)
              this.productList[i] = this.productData.proDeposit.slice(i * 10, i * 10 + 10);
            this.productList[i] = this.productData.proDeposit.slice(i * 10);
            this.commodityLoading = false;
          }
        }).catch(error => {
          this.commodityLoading = false;
          reject(error)
        })
      })
    },

    //修改页面商品数量
    currentChange(page) {
      this.pager = page;
    },
    //删除商品
    deleteItem: function (id) {
      return new Promise((resolve, reject) => {
        crudCommodity.del(id).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            //重新获取商品列表
            this.getCommodityList()
            resolve();
          }
        }).catch(error => {
          reject(error)
        })
      })
    },

    // 添加已有商品到配置项
    add(item, type) {
      var words = this.words;
      type === 'product' ?
        words += item.description.length :
        words += item.value.length;
      if(Math.ceil(words / 200) > this.duration)
      {
        this.$alert('台词配音时长超过视频时长！', '警告', {
            confirmButtonText: '确定',
          });
        return ;
      }
      var data = {type: type, data: item};
      // console.log(JSON.stringify(data));
      this.chooseList.push(JSON.parse(JSON.stringify(data)));
      // 深拷贝
      this.words = words;
    },
    //从组件中移除
    removeItem(index) {
      this.chooseList[index].type === 'product' ?
        this.words -= this.chooseList[index].data.description.length :
        this.words -= this.chooseList[index].data.value.length;
      this.chooseList.splice(index, 1);
    },
    //打开编辑串词框
    showEdit(index, data){
      this.editScript.index = index;
      this.editScript.data = data
      this.scriptVisible = true;
      this.words -= this.chooseList[index].data.value.length;
    },
    //保存修改好的串词
    saveScript(){
      this.chooseList[this.editScript.index].data.value = this.editScript.data;
      this.words += this.editScript.data.length;
      this.scriptVisible = false;
    },
    //强制刷新input
    onInput(){
      this.$forceUpdate();
    },



    next() {
      if(this.chooseList.length === 0){
        this.$alert('尚未选择台词！', '警告', {
          confirmButtonText: '确定',
        });
        return ;
      }
      var dubText = [];
      var words = 0;
      for(var i = 0; i < this.chooseList.length; i++){
        this.chooseList[i].type === 'product' ?
          dubText.push(this.chooseList[i].data.description):
          dubText.push(this.chooseList[i].data.value);
        words += dubText[i].length;
      }
      // 保存台词总数
      storeApi.set({
        name: 'words',
        content: words,
        type: 'session'
      });
      //保存台词
      storeApi.set({
        name: 'textList',
        content: dubText,
        type: 'session'
      });
      // console.log(dubText);
      this.$router.replace('selectAttri')
      // this.$store.commit('NEXT')
    }

  },

}
</script>
<style lang="scss" scoped>
.newProduct{
  width: 1200px;
  //padding: 0 20px;
  margin: auto;
  height:100%;
  .commodityImg{
    //按最短的边等比放大
    object-fit: cover;
    width: 80px;
    height: 80px;
  }
    .directBar{
        width:100%;
        padding:20px 40px;
        display:flex;
        justify-content: flex-end;
        align-items: center;
    }
    .proBar{
        display:flex;
        justify-content: center;
        align-items: flex-start;
        box-sizing: border-box;
        border-radius: 5px;
        .proDeposit{
          .el-icon-right {
            font-size: 13px;
            color:rgba(0,116,232,0.6);
            border: 1.5px solid rgba(0,116,232,0.6);
            border-radius: 10px;
            box-sizing: border-box;
          }
          .el-icon-right:hover {
            color: rgb(0,116,232);
            border: 1.5px solid rgb(0,116,232);
          }
          overflow-y: scroll;
          height: 700px;
          //background-color:rgb(245,247,250);
          border:1px solid #ebeef5;
          border-radius: 5px;
          padding:0 15px 15px 15px;
          width:390px;
          margin-right: 15px;
          //width:600px;
          min-height:500px;
          box-sizing:border-box;
          //margin-right:20px;
          .depositBox{
            position: sticky;
            top: 0;
            background-color: white;
            z-index: 9;
            display:flex;
            justify-content: flex-end;
            align-items: center;
            .barTitle{
              margin-right:120px;
              padding:10px 0;
            }
            .el-icon-plus{
              z-index: 9;
              margin-right:20px;
              // background-color:#ff5000;
              // color:white;
              &:hover{
                cursor: pointer;
                color: #ff5000;
              }
            }
          }
        }
        .proContainer{
          //background-color:rgb(245,247,250);
          //padding:0 15px 15px 15px;
          border:1px solid #ebeef5;
          overflow-y: scroll;
          height: 700px;
          border-radius: 5px;
          padding: 0 15px;
          width:390px;
          box-sizing:border-box;
          margin-right:15px;
          .barTitle{
            margin: 0;
            padding:30px 0;
            position: sticky;
            top: 0;
            background-color: white;
            z-index: 9;
          }

        }
        .list-group {
          display: flex;
          flex-direction: column;
          padding-left: 0;
          border: 0;
          //.list-group-item:first-child {
          //border-top-left-radius: 0.25rem;
          //border-top-right-radius: 0.25rem;
          //}
          //.list-group-item {
          //  //position: relative;
          //  display: block;
          //  //padding: 0;
          //  //margin-bottom: -1px;
          //  background-color: #fff;
          //  box-sizing: border-box;
          //  ::v-deep.el-collapse-item__content{
          //      padding-bottom:0 !important;
          //  }
          //  ::v-deep .el-collapse-item__header{
          //      padding-left:10px !important;
          //  }
          //}
        }
        .script{
          overflow-y: scroll;
          box-sizing: border-box;
          //padding-bottom:30px;
          width:390px;
          padding: 0 15px 15px 15px;
          border:1px solid #ebeef5;
          border-radius: 5px;
          height:700px;
          //background-color:rgb(245,247,250);
          .barTitle{
            padding:30px 0;
            position: sticky;
            top: 0;
            background-color: white;
            z-index: 9;
            margin: 0;
          }
          .inline-input {
            width: 100%;
            position: sticky;
            top: 80px;
            background-color: white;
            z-index: 9;
          }
          .el-autocomplete{
            margin-bottom:20px;
          }
          .el-scrollbar{
            .list-group{
              height:700px;
              overflow-y: auto;
            }
          }
          .itemContainer{
            margin:10px 0;
            .scriptItem{
              display:inline-block;
              width:100%;
              height:100%;
            }
          }
        }
      .el-icon-circle-close {
        color: #c9a2a2;
        font-size: 20px;
      }

      .el-icon-circle-close:hover {
        color: #f40;
      }

      .el-icon-back {
        font-size: 13px;
        color:rgba(0,116,232,0.6);
        border: 1.5px solid rgba(0,116,232,0.6);
        border-radius: 10px;
        box-sizing: border-box;
      }
      .el-icon-back:hover {
        color: rgb(0,116,232);
        border: 1.5px solid rgb(0,116,232);
      }
        .el-collapse{
          width:100%;
          border:0 !important;
          .el-collapse-item__content{
            padding-bottom: 10px !important;
          }
          .el-collapse-item__header {
            border: 0 !important;
            font-size:18px
          }
          .el-collapse-item__wrap {
            border-bottom: 0;
          }
          h3 {
            font-size: 28px;
            margin-bottom: 20px;
          }
        }
        .list-group {
          display: flex;
          flex-direction: column;
          margin-bottom: 0;
          border: 0;
          //padding:0 10px;
          //.list-group-item:first-child {
          //  border-top-left-radius: 0.25rem;
          //  border-top-right-radius: 0.25rem;
          //}
        }

    }
  .text{
    text-align: left !important;
    font-size: 13px;
    line-height: 1.769230769230769;
  }
  .list-group-item {
    overflow: inherit;
    position: relative;
    display: block;
    margin-bottom: 20px;
    background-color: #fff;
    box-shadow: unset;
    box-sizing: border-box;
    border-radius: 10px !important;
    border:1px solid #ebeef5 !important;
  }
  .list-group-item:hover{
    box-shadow: 0 2px 12px 0 rgba(0,0,0,.1)
  }
  .el-icon-edit-outline{
    font-size: 18px;
  }
  .el-icon-edit-outline:hover{
    color: rgb(0,116,232);
  }
}






</style>
