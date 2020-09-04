<template>
<div>
  <div class="container">
    <el-card class="box-card" body-style="padding : 0px">
      <div slot="header" class="clearfix">
        <span class="title">需求清单</span>
      </div>
      <el-row class="list" v-for="o in this.list" :key="o">
        <el-col class="label" span="6">{{o.title}}</el-col>
        <el-col class="content" span="18">{{o.data}}</el-col>
      </el-row>
    </el-card>
  </div>
</div>
</template>

<script>
export default {
  name: "payOrder",
  data(){
    return{
      list : []
    }
  },
  created() {
    var list = this.$route.query.data;
    console.log(list)
    if(list === null || list === undefined){
      this.$alert('请先选择视频基础需求', {
        confirmButtonText: '确定',
      }).then(
        this.goTo('/addOrder')
      );
    }
    else{
      this.list = list
    }
  },
  methods:{
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
  }
}
</script>

<style scoped>
.container{
  width: 1200px;
  margin: auto;
  padding: 30px 0;
}
.clearfix{
  text-align: left;
  /*background: rgba(255,80,0,0.1);*/
}
.title{
  width: 100%;
  margin-left: 40px;
  font-size: 26px;
  line-height: 50px;
}

.label{
  font-size: 14px;
  text-align: left;
  color: #303133;
}
.content{
  text-align: left;
  font-size: 14px;
  color: #303133;
}
.box-card{
  height: 100%;
  padding: 0;
}

.list{
  line-height: 50px;
  padding-left: 60px;
}
.list:nth-child(odd){
  background: rgba(255,80,0,0.1);
}
.el-card__body {
  padding: 5px;
}

</style>
