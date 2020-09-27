<template>
<div class="memberCenter">
    <div class="pageTitle">您好，{{data.planName}}会员</div>
      <el-card class="infoCard" shadow="hover">

        <el-row class="infoBar">
          <el-col span="8">
            <span class="infoTitle">
              商品库空间
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoTitle">
              已使用：
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoData">
              {{data.commodity}}
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoTitle">
              总容量：
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoData">
              {{data.allowedCommodity > 9999 ? '无限' : data.allowedCommodity}}
            </span>
          </el-col>
        </el-row>

        <el-row class="infoBar">
          <el-col span="8">
            <span class="infoTitle">
              套餐情况
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoTitle">
              剩余次数：
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoData">
              {{data.times === null ? 0 : data.times}}次
            </span>
          </el-col>
        </el-row>

        <el-row class="infoBar">
          <el-col span="8">
            <span class="infoTitle">
              视频修改
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoTitle">
              剩余次数：
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoData">
              {{data.editTimes === null ? 0 : data.editTimes}}次
            </span>
          </el-col>
        </el-row>

        <el-row class="infoBar">
          <el-col span="8">
            <span class="infoTitle">
              人工配音
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoTitle">
              剩余时长：
            </span>
          </el-col>
          <el-col span="4">
            <span class="infoData">
              {{data.audioTime === null ? 0 : data.audioTime}}分钟
            </span>
          </el-col>
        </el-row>

        <el-row style="margin:0 10px ; padding-top: 20px;">
          <el-col span="12" style="border-right: 1px solid #e6ebf5;">
            <el-row>
              <el-col span="12">
                <span class="infoTitle">
                  存储空间
                </span>
              </el-col>
              <el-col class="infoData" span="12">
                {{data.storage}} / {{data.allowedStorage}}G
              </el-col>
            </el-row>
            <el-row>
              <div id="storageChart" style="width: 400px; height: 250px">
              </div>
            </el-row>
          </el-col>
          <el-col span="12" style="border-right: 1px solid #e6ebf5;">
            <el-row>
              <el-col span="8">
                <span class="infoTitle">
                  子账户
                </span>
              </el-col>
              <el-col class="infoData" span="8">
                {{data.accountAvailable}} / {{data.accountAmount}}
              </el-col>
              <el-col span="8" v-if="this.userType !== '1'">
                <el-button type="primary" >管理</el-button>
              </el-col>
            </el-row>
            <el-row>
              <div id="accountChart" style="width: 400px; height: 250px">
              </div>
            </el-row>
          </el-col>
<!--          <el-col span="12">-->

<!--          </el-col>-->
<!--          <el-col span="8">-->

<!--          </el-col>-->
<!--          <el-col span="4">-->
<!--            <span class="infoTitle">-->
<!--              剩余容量：-->
<!--            </span>-->
<!--          </el-col>-->
<!--          <el-col span="4">-->
<!--            <span class="infoData">-->
<!--              {{data.storage}}G-->
<!--            </span>-->
<!--          </el-col>-->
<!--          <el-col span="4">-->
<!--            <span class="infoTitle">-->
<!--              总容量：-->
<!--            </span>-->
<!--          </el-col>-->
<!--          <el-col span="4">-->
<!--            <span class="infoData">-->
<!--              {{data.allowedStorage}}G-->
<!--            </span>-->
<!--          </el-col>-->
        </el-row>

      </el-card>
  <el-dialog
    :visible.sync="dialogVisible"
    style=""
    title="子账户管理"
    width="600px"
  >
  </el-dialog>
</div>

</template>

<script>
import echarts from 'echarts'
import payOrder from "@/views/VirtualWeb/order/payOrder-server";
import {MSG_TYPE_SUCCESS} from "@/const/common";
import {mapGetters} from "vuex";
//import echarts
export default {
  name: "menmberCenter",
  data() {
    return {
      data: {},
      dialogVisable : true,
    }
  },
  mounted() {
    this.getBalance();
    console.log(this.userType);
    this.buildStorageCharts();
  },
  computed: {
    ...mapGetters([
      'balance',
      'userType',
    ])
  },
  methods : {
    buildStorageCharts(){
      echarts.init(document.getElementById('storageChart')).setOption({
        color: ['#ccc', 'rgba(255,80,0,0.7)'],
        series: {
          type: 'pie',
          radius: ['50%', '70%'],
          avoidLabelOverlap: false,
          hoverAnimation:false,
          label:{
            normal: {
              show: true,
              position: 'center',
              color: '#7D7D7D',
              fontSize: 22,
              fontWeight: 'bold',
              lineHeight: 30,
            }
          },
          labelLine: {
            normal: {
              show: false,
            }
          },
          data: [
            {
              name: '余量',
              value: this.data.storage,
              label:{
                normal : {
                    show: false
                }
              }
            },
            {
              name: '已使用\n' + this.data.storage * 100/this.data.allowedStorage + '%',
              value: this.data.allowedStorage - this.data.storage,
              label:{
                normal : {
                  show: true
                }
              }
            },
          ]
        }
      });
      echarts.init(document.getElementById('accountChart')).setOption({
        color: ['#ccc', 'rgba(255,80,0,0.7)'],
        series: {
          type: 'pie',
          radius: ['50%', '70%'],
          avoidLabelOverlap: false,
          hoverAnimation:false,
          label:{
            normal: {
              show: true,
              position: 'center',
              color: '#7D7D7D',
              fontSize: 22,
              fontWeight: 'bold',
              lineHeight: 30,
            }
          },
          labelLine: {
            normal: {
              show: false,
            }
          },
          data: [
            {
              name: '余量',
              value: this.data.accountAvailable,
              label:{
                normal : {
                  show: false
                }
              }
            },
            {
              name: '已使用\n' + this.data.accountAvailable * 100/this.data.accountAmount + '%',
              value: this.data.accountAmount - this.data.accountAvailable,
              label:{
                normal : {
                  show: true
                }
              }
            },
          ]
        }
      });
    },
    getBalance(){
      // console.log(this.user);
      this.data = this.balance;
    }
  }
}
</script>
<style lang="scss" scoped>
@import '@/common/style.scss';

.memberCenter{
  height: 100%;
  //overflow-y: scroll;
  .pageTitle{
    @include pageTitle
  }
  .infoBar{
    padding: 15px 0;

    border-bottom: 1px solid #e6ebf5;
  }
  .infoCard{
    margin: 10px;
  }
  .infoTitle{
    line-height: 18px;
    color: rgba(0,0,0,0.45);
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 12px;
  }
  .infoData{
    color: #666666;
    font-size: 16px;
  }
}

</style>
