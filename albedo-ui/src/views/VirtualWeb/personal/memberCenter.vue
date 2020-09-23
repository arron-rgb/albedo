<template>
<div class="memberCenter">
    <div class="pageTitle">会员中心</div>
  <el-row style="margin: 12px 0">
    <el-col span="12">
      <el-card class="infoCard" shadow="hover">
        <el-row>
          <el-col span="12">
            <span class="infoTitle">
              存储空间
            </span>
          </el-col>
          <el-col span="12">
            <span class="infoData">
              2.85 / 6
            </span>
          </el-col>
        </el-row>
        <el-row>
          <div id="storageChart" style="width: 400px; height: 300px">
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
  created() {
    this.buildStorageCharts();
  },
  methods : {
    buildStorageCharts(){
      echarts.init(document.getElementById('storageChart')).setOption({
        series: {
          type: 'pie',
          data: [
            {name: 'A', value: 1212},
            {name: 'B', value: 2323},
            {name: 'C', value: 1919}
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
  .infoCard{
    margin: 0 10px;
  }
}

</style>
