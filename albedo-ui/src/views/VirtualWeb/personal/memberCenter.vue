<template>
<div class="memberCenter">
    <div class="pageTitle">您好，{{data.planName}}会员</div>
  {{this.dialogVisible}}

  <el-dialog
    :visible.sync="manageVisible"
    style=""
    title="子账户管理"

    width="730px"
  >
<!--    {{this.userId}}-->
    <el-table
      :data="accountList"
      :default-sort = "{prop: 'createdDate', order: 'descending'}"
      stripe="true"
      style="height: 500px"
      v-loading="tableLoading"
    >
      <el-table-column
        label="用户名"
        prop="username"
        sortable>
      </el-table-column>
      <el-table-column
        label="创建时间"
        prop="createdDate"
        sortable>
      </el-table-column>
      <el-table-column
        label="电子邮箱"
        prop="email"
        sortable>
      </el-table-column>
      <el-table-column
        label="联系电话"
        prop="phone"
        sortable>
      </el-table-column>
      <el-table-column
        label="操作">
        <template slot-scope="props">
          <el-button :disabled="userId === props.row.id" :loading="delLoading"  @click="deleteAccount(props.row.id)" slot="reference">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

  </el-dialog>

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
                <el-button @click="addVisible = true">新增</el-button>
                <el-button @click="manage" type="primary">管理</el-button>
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
<!--  新增子用户-->
<!--  el-dialog 绑定 visible 不能加this-->
  <el-dialog
    :visible.sync="addVisible"
    title="子账户添加"
    width="600px"
  >
    <el-form :model="form" label-width="86px" ref="form" size="small">
      <el-form-item
        :rules="[
                { required: true, message: '请输入用户名', trigger: 'blur' },
                { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
              ]"
        label="用户名"
        prop="username">
        <el-input v-model="form.username" />
      </el-form-item>
      <el-form-item
        :rules="[
                { required: true, trigger: 'blur', validator: validPhone }
              ]"
        label="电话"
        prop="phone"
      >
        <el-input v-model.number="form.phone" />
      </el-form-item>
      <el-form-item
        :rules="[
                { required: true, message: '请输入邮箱地址', trigger: 'blur' },
                { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
              ]"
        label="邮箱"
        prop="email"
      >
        <el-input v-model="form.email" />
      </el-form-item>
    </el-form>
    <div class="dialog-footer" slot="footer">
<!--      <el-button @click="">取消</el-button>-->
      <el-button :loading="loading" @click="saveAccount" type="primary">确认</el-button>
    </div>
  </el-dialog>


</div>

</template>

<script>
import echarts from 'echarts'
import {MSG_TYPE_SUCCESS} from "@/const/common";
import {mapGetters} from "vuex";
import validate from "@/utils/validate";
import crudUser from '@/views/sys/user/user-service'
import crudDept from '@/views/sys/dept/dept-service'
//import echarts
export default {
  name: "memberCenter",
  data() {
    return {
      tableLoading :false,
      manageVisible : false,
      addVisible : false,
      data: {},
      loading : false,
      delLoading : false,
      accountList : [],
    // {"id":null,"username":"11","email":"willemgavin@foxmail.com",
      // "available":"",
      // "roleIdList":["49dbe45a4e2a06a56730851e0c87f166"],
      // "deptId":"8bc59bc9bffb24dc1be731944021cd71",
      // "phone":17376512206,"description":null}
      form : {
        username : '',
        email : '',
        roleIdList : ['49dbe45a4e2a06a56730851e0c87f166'],
        deptId : '',
        phone : '',
      },
      userId : '',
      validPhone: (rule, value, callback) => {
        if (!value) {
          callback(new Error('请输入电话号码'))
        } else if (!validate.isvalidPhone(value)) {
          callback(new Error('请输入正确的11位手机号码'))
        } else {
          callback()
        }
      },
    }
  },
  mounted() {
    this.getBalance();
    // console.log(this.user);
    if(this.data.times === 0 || this.data.times === '0'){
      this.$alert('套餐余量已不足，请及时购买！', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(
        this.goTo('/enterprise')
      );
    }
    this.userId = this.user.id;
    this.buildStorageCharts();
  },
  computed: {
    ...mapGetters([
      'balance',
      'userType',
      'user'
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
              name: '已使用\n' + (this.data.allowedStorage - this.data.storage).toFixed(4) * 100/this.data.allowedStorage + '%',
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
              name: '已使用\n' + (this.data.accountAvailable * 100/this.data.accountAmount).toFixed(4) + '%',
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
    },
    saveAccount(){
      this.form.deptId = this.user.deptId;
      return new Promise((resolve, reject) => {//保存子账户
        crudUser.save(this.form).then((res) => {
          if(res.code === MSG_TYPE_SUCCESS){//新增的账户默认密码为 ‘123456’
            // this.getAccountList();//更新子账户的list
            this.addVisible = false;
          }
          resolve(res)
        }).catch((err) => {
          reject(err)
        })
      });
    },
    manage(){//打开管理页面的同时查看最新的list
      this.getAccountList();
      this.manageVisible = true;
    },
    getAccountList(){
      // code: 1
      // data: [{id: "8bc59bc9bffb24dc1be731944021cd71", parentId: "-1", children: [], label: "xx科技"}]
      // 0: {id: "8bc59bc9bffb24dc1be731944021cd71", parentId: "-1", children: [], label: "xx科技"}
      // children: []
      // id: "8bc59bc9bffb24dc1be731944021cd71"
      // label: "xx科技"
      // parentId: "-1"
      // message: ""
      this.tableLoading = true;
      var query = {
        deptIds : this.user.deptId
      }
      return new Promise((resolve, reject) => {//删除子账户
        crudUser.page(query).then((res) => {
          if(res.code === MSG_TYPE_SUCCESS){
            this.accountList = res.data.records;
            this.tableLoading = false;
          }
          resolve(res)
        }).catch((err) => {
          this.tableLoading = false;
          reject(err)
        })
      });
    },
    deleteAccount(id){
      this.delLoading = true;
      var data = [id];
      return new Promise((resolve, reject) => {//删除子账户
        crudUser.del(data).then((res) => {
          // if(res.code === MSG_TYPE_SUCCESS){
            this.getAccountList();//更新子账户的list
          // }
          this.delLoading = false;
          resolve(res)
        }).catch((err) => {
          this.delLoading = false;
          reject(err)
        })
      });
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
