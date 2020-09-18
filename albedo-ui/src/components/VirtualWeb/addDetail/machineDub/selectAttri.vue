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
                            <el-button style="border:1px solid #ebeef5" v-for="(attri,id) in list.list" :key="id" @click="changeActive(index,id)"
                            :class="{active:attriType[index].active===id,'select-button':attriType[index].active!==id}">
                                {{attri}}
                            </el-button>
                        </div>
                    </div>
                </div>
<!--              机器配音音色-->
              <div class="selectBar" v-if="this.dubType === '2'">
                <div class="attriType" v-for="(list,index) in machineAttri" :key="index">
                  <div class="listType">{{list.listType}}</div>
                  <div class="attriList">
                    <el-button style="border:1px solid #ebeef5" v-for="(attri,id) in list.list" :key="id" @click="backData = attri.value"
                               :class="{active:attriType[index].active===id,'select-button':attriType[index].active!==id}">
                      {{attri.value}}
                    </el-button>
                  </div>
                </div>
              </div>
            </div>
            <div class="showSelected">
              <el-row style="min-height: 100px;">
                <h3 class="barTitle">
                    已选属性
                </h3>
<!--                <div  class="selectedAttri">-->
                <el-tag v-if="this.dubType === '1'" v-for="(item,id) in selectedAttri" :key="item" :type="typeList[id % 5]" class="myTags">{{item}}</el-tag>
                <el-tag v-if="this.dubType === '2' && backData !== ''" :type="typeList[0]" class="myTags">{{backData}}</el-tag>
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
                <el-col span="13">
                  <span style="line-height: 45px">分钟</span>
                </el-col>
              </el-row>
              <el-row style="text-align: left; margin-top: 10px;">
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
                <el-button type="primary" style="width: 300px" @click="payDub">前往支付</el-button>
              </el-row>
            </div>
        </div>
    </div>
</template>
<script>
import storeApi from "@/utils/store";
export default {
  data(){
      return{
          attriType:[
            {listType:'性别',list:['男','女'],active:-1},
            {listType:'声音',list: ['婴儿','儿童','少年','青年','中年'],active:-1},
            {listType:'类型',list:['讲述播报','综艺播报','新闻播报'],active:-1},
            {listType:'标签',list:['大气','活力','浑厚','甜美','激情'],active:-1}
          ],
          machineAttri:[
            {listType:'男声', list:[{value: '亲和男声', id: 1},
                {value: '成熟男声', id: 2},
                {value: '情感男声', id: 6}]},
            {listType:'女声', list:[{value: '亲和女声（默认）', id: 0},
                {value: '温暖女声', id: 4},
                {value: '情感女声', id: 5},
                {value: '客服女声', id: 7},
                {value: '通用女声', id: 1002},]}
          ],
          selectedAttri:[],
          typeList : ["", "success", "info", "warning", "danger"],
          words: 0,
          time : '',
          price : '',
          dubType : '',
          backData :'',
      }
  },
  created() {
    // 向上取整
    this.words = storeApi.get({
      name: 'words'
    }) || 0;
    this.time = Math.ceil(this.words / 200);
    this.price = this.time * 100;
    //获取配音方式
    this.dubType = storeApi.get({
      name: 'dubType'
    }) || null;
    if(this.dubType === null || this.dubType === undefined){
      this.$alert('请先选择配音方式！', '警告', {
        confirmButtonText: '确定',
      }).then(
        this.$router.replace('addDetail')
      );
    }
  },
  methods:{
    changeActive(listid,id){
        let selectedItem = this.attriType[listid].list[id]
        if(this.attriType[listid].active===-1)
        {
            this.attriType[listid].active=id
            this.selectedAttri.push(selectedItem)
        }
        else if(this.attriType[listid].active===id)
        {
            this.attriType[listid].active=-1
            this.selectedAttri.filter((item,i)=>{
                if(item===selectedItem)
                    this.selectedAttri.splice(i,1)
            })
        }
        else{
            let prevAttri = this.attriType[listid].list[this.attriType[listid].active]
            this.selectedAttri.filter((item,i)=>{
                if(item===prevAttri)
                    this.selectedAttri.splice(i,1)
            })
            this.attriType[listid].active=id
            this.selectedAttri.push(selectedItem)
        }
    },
    // next(){
    //     this.$router.replace('paymentPage')
    //     this.$store.commit('NEXT')
    // },
    payDub(){
      if(this.dubType === '1')
      {
        if(this.selectedAttri.length < 4)
        {
          this.$alert('请完整选择音色属性！', '提示', {
            confirmButtonText: '确定',
          });
        }else
        {
          //提交订单
        }
      }
      if(this.dubType === '2')
      {
        if(this.selectedAttri.length < 2)
        {
          this.$alert('请完整选择音色属性！', '提示', {
            confirmButtonText: '确定',
          });
        }else
        {
          //提交订单
        }
      }
    }

  }
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

</style>
