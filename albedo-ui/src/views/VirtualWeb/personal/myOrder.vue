<template>
  <div style="height: 100%; overflow-y: scroll">
    <div class="pageTitle">我的订单</div>
<!--    <el-card class="table-card">-->
<!--    {{this.data}}-->
      <el-table
        :data="data"
        stripe="true"
        :default-sort = "{prop: 'createdDate', order: 'descending'}"
        v-loading="loading"
      >
<!--        <el-table-column type="expand">-->
<!--          <template slot-scope="scope">-->

<!--            {{scope.row.children}}-->
<!--          </template>-->
<!--        </el-table-column>-->

<!--        <el-table-column type="expand">-->
<!--          <template slot-scope="props">-->
<!--            <el-form label-position="left" inline class="demo-table-expand">-->
<!--              <el-form-item label="视频属性">-->
<!--                <el-tag v-for="(item, index) in JSON.parse(props.row.content).data" :type="typeList[index % 5]" :key="item" class="myTags">-->
<!--                  <p style="line-height: 40px; margin: 0" v-for="o in item.data">{{o.value}}<p/>-->
<!--                </el-tag>-->
<!--                &lt;!&ndash;              <span>{{ getJSON(props.row.content).data }}</span>&ndash;&gt;-->
<!--              </el-form-item>-->
<!--              <el-form-item label="视频链接">-->
<!--                <span v-if="props.row.videoId === null || props.row.videoId === ''">已失效</span>-->
<!--                <span v-else>-->
<!--                  <el-button @click="showDetail(props.row)">点击下载</el-button>-->
<!--                </span>-->
<!--              </el-form-item>-->
<!--            </el-form>-->
<!--          </template>-->
<!--        </el-table-column>-->
        <el-table-column
          label="创建时间"
          sortable
          prop="createdDate">
        </el-table-column>
        <el-table-column label="订单类型">
          <template slot-scope="props">
            <span v-if="props.row.type === '2'">语音订单</span>
            <span v-else >视频订单</span>
          </template>
        </el-table-column>
        <el-table-column
          label="最后修改人"
          prop="lastModifiedBy">
        </el-table-column>
        <el-table-column
          label="订单价格"
          sortable
          prop="totalAmount">
        </el-table-column>
        <el-table-column
          label="订单状态"
        >
          <template slot-scope="props">
            <span v-if="props.row.state === 0">未付款</span>
            <span v-else-if="props.row.state === 1">未接单</span>
            <span v-else-if="props.row.state === 2">制作中</span>
<!--            <span v-if="props.row.state === 3">待完善</span>-->
<!--            <span v-if="props.row.state === 4">配音中</span>-->
            <span v-else-if="props.row.state === 6">已结单</span>
            <span v-else>可配音</span>
          </template>
        </el-table-column>
        <el-table-column
          label="操作">
          <template slot-scope="props" v-if="props.row.type !== '2'">
<!--              配音订单-->
<!--              <el-button size="mini" v-if="props.row.type === '2'" @click="goTo('/waiting')">查看详情</el-button>-->
            <el-tooltip class="item" content="查看订单详情" effect="dark" placement="top">
              <el-button @click="showDetail(props.row, '/endOrder')" type="primary">查看</el-button>
            </el-tooltip>
            <el-tooltip class="item" content="前往配音" effect="dark" placement="top">
              <el-button :disabled="props.row.state < 3 || props.row.state === 6" @click="showDetail(props.row, '/addDetail')">配音</el-button>
            </el-tooltip>
          </template>
          <template slot-scope="props" v-else>
            <el-tooltip class="item" content="查看订单详情" effect="dark" placement="top">
              <el-button @click="showDetail(props.row, '/endOrder')" type="primary">查看</el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
<!--    </el-card>-->
  </div>
</template>

<script>
import crudOrder from "@/views/biz/order/order-service";
import {MSG_TYPE_SUCCESS} from "@/const/common";
import storeApi from "@/utils/store";

export default {
  name: "myOrder",
  data(){
    return {
      data : [],
      typeList : ["", "success", "info", "warning", "danger"],
      loading : false,
    }
  },
  methods : {
    getData(){
      this.loading = true;
      return new Promise((resolve, reject) => {
        crudOrder.list().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            //重新获取商品列表
            // console.log(res);
            this.data = res.data
            this.loading = false;
          }
        }).catch(error => {
          this.loading = false;
          reject(error)
        })
      })
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {data: data}});
    },
    showDetail(data, url){
      storeApi.set({
        name: 'orderDetail',
        content: data,
        type: 'session'
      });
      this.goTo(url);
    },
    // getVideos(row, expandedRows){
      // console.log(row);
      // row.children = row.id + '\'s children';

      // console.log(expandedRows);
    // }
  },
  created() {
    this.getData();
  }

}
</script>

<style lang="scss" scoped>
@import '@/common/style.scss';

  .pageTitle {
  @include pageTitle
  }

.table-card{
  margin: auto;
  margin-top: 10px;
}
.myTags{
  min-width: 80px;
  line-height: 40px;
  text-align: center;
  font-size: 14px;
  min-height: 40px;
  margin: 10px;
}
.demo-table-expand label {
  width: 120px;
  color: #99a9bf;
}
.demo-table-expand {
  margin-right: 0;
  margin-bottom: 0;
}
.el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 100%;
}
</style>
