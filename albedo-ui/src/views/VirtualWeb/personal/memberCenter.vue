<template>
<div class="memberCenter">
    <div class="pageTitle">会员中心</div>
  <el-row style="margin: 12px 0">
    <el-col span="12">
      <el-card class="infoCard" shadow="hover">
        <el-row class="infoBar">
          <el-col span="12">
            <span class="infoTitle">
              存储空间
            </span>
          </el-col>
          <el-col span="12">
            <span class="infoData">
              2.85/6
            </span>
            <span class="infoTitle">
               G
            </span>
          </el-col>
        </el-row>
        <el-row>
          <div id="storageChart" style="width: 400px; height: 270px">
          </div>
        </el-row>
      </el-card>
    </el-col>
    <el-col span="12">
      <el-card class="infoCard" shadow="hover">

      </el-card>
    </el-col>
  </el-row>
</div>

</template>

<script>
import echarts from 'echarts'//import echarts
export default {
  name: "menmberCenter",
  data() {
    return {
      "data": {
        "accountAvailable": 3,
        "accountAmount": 5,
        "accountIds": [
          "admin"
        ],
        "storage": 2.85,
        "allowedStorage": 6,
        "times": 3,
        "commodity": 2,
        "allowedCommodity": 2147483647,
        "planName": "旗舰版"
      },
    }
  },
  mounted() {
    this.buildStorageCharts();
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
              value: 2.85,
              label:{
                normal : {
                    show: false
                }
              }
            },
            {
              name: '已使用\n' + 2.85 * 100/6 + '%',
              value: 6 - 2.85,
              label:{
                normal : {
                  show: true
                }
              }
            },
          ]
        }
      });
    }
  }
}
</script>
<style lang="scss" scoped>
@import '@/common/style.scss';

.memberCenter{
  .pageTitle{
    @include pageTitle
  }
  .infoBar{
    margin-top: 10px;
  }
  .infoCard{
    margin: 0 10px;
  }
  .infoTitle{
    line-height: 20px;
    color: rgba(0,0,0,0.45);
    font-size: 18px;
    font-weight: 700;
    margin-bottom: 12px;
  }
  .infoData{
    color: #666666;
    font-size: 20px;
  }
}

</style>
