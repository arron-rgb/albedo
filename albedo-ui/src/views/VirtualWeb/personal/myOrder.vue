<template>
  <div style="height: 100%; overflow-y: scroll">
    <div class="pageTitle">我的订单</div>
<!--    <el-card class="table-card">-->
      <el-table
        :data="data"
        stripe="true"
      >
        <el-table-column type="expand">
          <template slot-scope="props">
            <el-form label-position="left" inline class="demo-table-expand">
              <el-form-item label="视频属性">
                <el-tag v-for="(item, index) in getJSON(props.row.content).data" :type="typeList[index % 5]" :key="item" class="myTags">
                  {{item.data[0].value}}
                </el-tag>
                <!--              <span>{{ getJSON(props.row.content).data }}</span>-->
              </el-form-item>
              <el-form-item label="视频链接">
                <span v-if="props.row.videoId === null">已失效</span>
                <span v-else>
                  <el-button @click="">点击前往</el-button>
                </span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column
          label="创建时间"
          prop="createdDate">
        </el-table-column>
        <el-table-column
          label="创建人"
          prop="createdBy">
        </el-table-column>
        <el-table-column
          label="订单价格"
          prop="totalAmount">
        </el-table-column>
        <el-table-column
          label="订单状态"
          prop="state">
        </el-table-column>
      </el-table>
<!--    </el-card>-->
  </div>
</template>

<script>
export default {
  name: "myOrder",
  data(){
    return {
      data : [
        {
          "createdBy": "1",
          "createdDate": "2020-09-07 16:49:17",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-07 16:49:17",
          "version": 0,
          "description": null,
          "id": "0e234567a0cbd9e891555b9baa4054d4",
          "userId": "1",
          "state": 0,
          "type": "0",
          "videoId": null,
          "staffId": null,
          "totalAmount": "999.00",
          "content": "{\"data\":[{\"data\":[{\"name\":\"label\",\"value\":\"美妆护肤\"}],\"title\":\"请选择label\"},{\"data\":[{\"id\":6,\"name\":\"anchorNum\",\"value\":\"单人主播\"}],\"title\":\"anchorNum\"},{\"data\":[{\"id\":8,\"name\":\"seat\",\"value\":\"站姿\"},{\"id\":9,\"name\":\"seat\",\"value\":\"坐姿\"}],\"title\":\"请选择seat\"},{\"data\":[{\"id\":10,\"name\":\"anchorType\",\"value\":\"活力青春型\"},{\"id\":11,\"name\":\"anchorType\",\"value\":\"成熟稳重型\"}],\"title\":\"请选择anchorType\"},{\"data\":[{\"id\":13,\"name\":\"style\",\"url\":\"http://www.baidu.com\",\"value\":\"度假\"}],\"title\":\"请选择style\"}]}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-05 01:26:32",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-11 01:54:38",
          "version": 1,
          "description": null,
          "id": "123",
          "userId": "1",
          "state": 2,
          "type": "1",
          "videoId": null,
          "staffId": "1",
          "totalAmount": null,
          "content": "{}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-15 15:20:03",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-15 15:20:03",
          "version": 0,
          "description": null,
          "id": "29c1696fc199fd0f82300e1843815e69",
          "userId": "1",
          "state": 0,
          "type": "0",
          "videoId": null,
          "staffId": null,
          "totalAmount": "999.00",
          "content": "{\"data\":[{\"title\":\"站立姿势\",\"data\":[{\"value\":\"站姿\"}]},{\"title\":\"直播间风格\",\"data\":[{\"value\":\"度假\"}]},{\"title\":\"主播数量\",\"data\":[{\"value\":\"单人主播\"}]},{\"title\":\"标签\",\"data\":[{\"value\":\"美妆护肤\"}]},{\"title\":\"主播风格\",\"data\":[{\"value\":\"活力青春型\"}]}]}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-06 09:56:31",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-06 09:56:31",
          "version": 0,
          "description": null,
          "id": "493f50d0ab45a079602c1c01615fe2dc",
          "userId": "1",
          "state": 0,
          "type": "0",
          "videoId": null,
          "staffId": null,
          "totalAmount": "999.00",
          "content": "{\"data\":[{\"data\":[{\"name\":\"label\",\"value\":\"美妆护肤\"}],\"title\":\"请选择label\"},{\"data\":[{\"id\":6,\"name\":\"anchorNum\",\"value\":\"单人主播\"}],\"title\":\"anchorNum\"},{\"data\":[{\"id\":8,\"name\":\"seat\",\"value\":\"站姿\"},{\"id\":9,\"name\":\"seat\",\"value\":\"坐姿\"}],\"title\":\"请选择seat\"},{\"data\":[{\"id\":10,\"name\":\"anchorType\",\"value\":\"活力青春型\"},{\"id\":11,\"name\":\"anchorType\",\"value\":\"成熟稳重型\"}],\"title\":\"请选择anchorType\"},{\"data\":[{\"id\":13,\"name\":\"style\",\"url\":\"http://www.baidu.com\",\"value\":\"度假\"}],\"title\":\"请选择style\"}]}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-15 15:25:36",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-15 15:25:36",
          "version": 0,
          "description": null,
          "id": "8294acf2f819a3a0abc67f6c6ceabd24",
          "userId": "1",
          "state": 0,
          "type": "0",
          "videoId": null,
          "staffId": null,
          "totalAmount": "999.00",
          "content": "{\"data\":[{\"title\":\"站立姿势\",\"data\":[{\"value\":\"站姿\"}]},{\"title\":\"直播间风格\",\"data\":[{\"value\":\"度假\"}]},{\"title\":\"主播数量\",\"data\":[{\"value\":\"单人主播\"}]},{\"title\":\"标签\",\"data\":[{\"value\":\"美妆护肤\"}]},{\"title\":\"主播风格\",\"data\":[{\"value\":\"活力青春型\"}]}]}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-08 14:20:19",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-08 14:20:19",
          "version": 0,
          "description": null,
          "id": "b26a166c1bc15de1e5b182a87ec199b6",
          "userId": "1",
          "state": 0,
          "type": "0",
          "videoId": null,
          "staffId": null,
          "totalAmount": "999.00",
          "content": "{\"data\":[{\"title\":\"站立姿势\",\"data\":[{\"value\":\"站姿\"}]},{\"title\":\"直播间风格\",\"data\":[{\"value\":\"度假\"}]},{\"title\":\"主播数量\",\"data\":[{\"value\":\"单人主播\"}]},{\"title\":\"标签\",\"data\":[{\"value\":\"美妆护肤\"}]},{\"title\":\"主播风格\",\"data\":[{\"value\":\"活力青春型\"}]}]}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-15 15:22:30",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-15 15:22:30",
          "version": 0,
          "description": null,
          "id": "ba5e220857ad3442d84ba326ce3c78bf",
          "userId": "1",
          "state": 0,
          "type": "0",
          "videoId": null,
          "staffId": null,
          "totalAmount": "999.00",
          "content": "{\"data\":[{\"title\":\"站立姿势\",\"data\":[{\"value\":\"站姿\"}]},{\"title\":\"直播间风格\",\"data\":[{\"value\":\"度假\"}]},{\"title\":\"主播数量\",\"data\":[{\"value\":\"单人主播\"}]},{\"title\":\"标签\",\"data\":[{\"value\":\"美妆护肤\"}]},{\"title\":\"主播风格\",\"data\":[{\"value\":\"活力青春型\"}]}]}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-06 09:43:58",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-06 09:43:58",
          "version": 0,
          "description": null,
          "id": "baea154db5051b9f9e78bb53bd2d250e",
          "userId": "1",
          "state": 0,
          "type": "0",
          "videoId": null,
          "staffId": null,
          "totalAmount": "999.00",
          "content": "{'data':[{'data':[{'name':'label','value':'美妆护肤'}],'title':'请选择label'},{'data':[{'id':6,'name':'anchorNum','value':'单人主播'}],'title':'anchorNum'},{'data':[{'id':8,'name':'seat','value':'站姿'},{'id':9,'name':'seat','value':'坐姿'}],'title':'请选择seat'},{'data':[{'id':10,'name':'anchorType','value':'活力青春型'},{'id':11,'name':'anchorType','value':'成熟稳重型'}],'title':'请选择anchorType'},{'data':[{'id':13,'name':'style','url':'http://www.baidu.com','value':'度假'}],'title':'请选择style'}]}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-07 16:08:38",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-07 16:08:38",
          "version": 0,
          "description": null,
          "id": "c2da8cc828e14323011acee1e0b205a4",
          "userId": "1",
          "state": 0,
          "type": "0",
          "videoId": null,
          "staffId": null,
          "totalAmount": "999.00",
          "content": "{\"data\":[{\"data\":[{\"name\":\"label\",\"value\":\"美妆护肤\"}],\"title\":\"请选择label\"},{\"data\":[{\"id\":6,\"name\":\"anchorNum\",\"value\":\"单人主播\"}],\"title\":\"anchorNum\"},{\"data\":[{\"id\":8,\"name\":\"seat\",\"value\":\"站姿\"},{\"id\":9,\"name\":\"seat\",\"value\":\"坐姿\"}],\"title\":\"请选择seat\"},{\"data\":[{\"id\":10,\"name\":\"anchorType\",\"value\":\"活力青春型\"},{\"id\":11,\"name\":\"anchorType\",\"value\":\"成熟稳重型\"}],\"title\":\"请选择anchorType\"},{\"data\":[{\"id\":13,\"name\":\"style\",\"url\":\"http://www.baidu.com\",\"value\":\"度假\"}],\"title\":\"请选择style\"}]}"
        },
        {
          "createdBy": "1",
          "createdDate": "2020-09-05 22:37:34",
          "lastModifiedBy": "1",
          "lastModifiedDate": "2020-09-06 10:55:28",
          "version": 3,
          "description": null,
          "id": "dd405d8c09438200573a33c88a5add70",
          "userId": "1",
          "state": 3,
          "type": null,
          "videoId": "fd28f0c6846caf7bcdf1fc6a05f3a61a",
          "staffId": "1",
          "totalAmount": "1029.00",
          "content": "{'data':[{'data':[{'name':'label','value':'美妆护肤'}],'title':'请选择label'},{'data':[{'id':6,'name':'anchorNum','value':'单人主播'}],'title':'anchorNum'},{'data':[{'id':8,'name':'seat','value':'站姿'},{'id':9,'name':'seat','value':'坐姿'}],'title':'请选择seat'},{'data':[{'id':10,'name':'anchorType','value':'活力青春型'},{'id':11,'name':'anchorType','value':'成熟稳重型'}],'title':'请选择anchorType'},{'data':[{'id':13,'name':'style','url':'http://www.baidu.com','value':'度假'}],'title':'请选择style'}]}"
        }
      ],
      typeList : ["", "success", "info", "warning", "danger"],
    }
  },
  methods : {
    getJSON(data){
      return  JSON.parse(data)
    }
  },
  created() {
    console.log(JSON.parse(this.data[0].content))
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
