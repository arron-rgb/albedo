<template>
</template>

<script>


export default {
  name: 'Dashboard',
  components: {},
  data() {
    return {
      // lineChartData: lineChartData.newVisitis
    }
  },
  methods: {
    // handleSetLineChartData(type) {
    //   this.lineChartData = lineChartData[type]
    // }
  }
}
</script>

<style lang="scss" rel="stylesheet/scss" scoped>
.dashboard-editor-container {
  padding: 32px;
  background-color: rgb(240, 242, 245);
  position: relative;

  .github-corner {
    position: absolute;
    top: 0;
    border: 0;
    right: 0;
  }

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
  }
}

@media (max-width: 1024px) {
  .chart-wrapper {
    padding: 8px;
  }
}
</style>
