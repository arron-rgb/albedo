<template>
  <div>
    <el-row style="color: #909399; line-height: 30px; padding: 10px 0; text-align: center">
      <el-col span="4">
        您的邀请码：
      </el-col>
      <el-col span="8" style="text-align: c">
        {{this.invitationCode}}
      </el-col>
      <el-col span="4">
        邀请总数：
      </el-col>
      <el-col span="8" style="text-align: left">
        {{this.invitationList.length}}
      </el-col>
    </el-row>

    <el-table
      ref="table"
      v-loading="loading"
      :data="invitationList"
      style="width: 100%;"
    >
      <el-table-column align="center" label="注册时间" :show-overflow-tooltip="true" prop="createdDate"/>
      <el-table-column align="center" label="用户ID" :show-overflow-tooltip="true" prop="id"/>
      <el-table-column align="center" label="用户名" :show-overflow-tooltip="true" prop="username"/>
      <el-table-column align="center" label="联系方式" :show-overflow-tooltip="true" prop="phone"/>
      <el-table-column align="center" label="邮箱" :show-overflow-tooltip="true" prop="email"/>
    </el-table>
  </div>
</template>

<script>
import crudInvitation from '@/views/biz/invitation/invitation-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";
export default {
  name: "invitation",
  data (){
    return {
      invitationCode : '',
      invitationList :[],
      loading : false,
    }
  },
  created() {
    this.getInvitationCode();
    this.getInvitationList();
  },
  methods : {
    getInvitationCode(){//获取邀请码
      return new Promise( (resolve, reject) => {
        crudInvitation.generate().then(res => {
          if(res.code === MSG_TYPE_SUCCESS){
            this.invitationCode = res.data
          }
          resolve(res);
        }).catch( err => {
          reject(err)
        })
      })
    },
    getInvitationList(){//获取已邀请的用户list
      this.loading = true;
      return new Promise( (resolve, reject) => {
        crudInvitation.list().then(res => {
          if(res.code === MSG_TYPE_SUCCESS){
            this.invitationList = res.data
          }
          resolve(res);
        }).catch( err => {
          reject(err)
        });
        this.loading = false;
      })
    }
  }
}
</script>

<style scoped>

</style>
