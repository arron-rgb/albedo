<template>
  <div>
    <!--  banner栏-->
    <div class="exhibition_background" :style="{backgroundImage: 'url(' + backgroundImg + ')'}">
      <div class="exhibition">
<!--        <div class="exhibition_title word_container" >虚拟直播企业版</div>-->
<!--        <div class="exhibition_desc word_container">批量下单更优惠，客户服务更到位</div>-->
        <div class="exhibition_link word_container">
          <a class="exhibition_link_login" @click="goTo('/login')">登录企业账户</a>
          <a class="exhibition_link_register" @click="goTo('/login', 'createBusiness')">创建企业账户</a>
        </div>
<!--        <div class="exhibition_phone">咨询电话：0571-28878118</div>-->
      </div>
    </div>

    <div class="exhibition_right">

    </div>

    <div class="container_background">
      <img src="http://static.vlivest.com/3996e0ae9f7ab7725ca29575f0e57162.jpg" style="width: 1200px;">
<!--      <el-row class="word_container">-->
<!--        <el-col :span="12">-->
<!--          <div class="exhibition_block2">-->
<!--            <div class="container_title" style="text-align: left">-->
<!--              企业定制-->
<!--            </div>-->
<!--            <div class="container_title" style="text-align: right">-->
<!--              品牌专享-->
<!--            </div>-->
<!--            <div class="container_text">-->
<!--              虚拟直播直降XXX元-->
<!--            </div>-->
<!--            <div  class="container_text">-->
<!--              赠送改稿权限及配音服务，无忧打造智慧直播间-->
<!--            </div>-->
<!--          </div>-->
<!--        </el-col>-->
<!--        <el-col :span="12">-->
<!--          <div class="exhibition_block">-->
<!--            <div class="container_title" style="text-align: left">-->
<!--              专属商务-->
<!--            </div>-->
<!--            <div class="container_title" style="text-align: right">-->
<!--              快速响应-->
<!--            </div>-->
<!--            <div class="container_text">-->
<!--              7*12h专属客服，采购、售后全程无忧-->
<!--            </div>-->
<!--            <div  class="container_text">-->
<!--              规范商务流程，合同、发票无需等待-->
<!--            </div>-->
<!--          </div>-->
<!--        </el-col>-->
<!--      </el-row>-->
<!--      <el-row class="word_container">-->
<!--        <el-col :span="12">-->
<!--          <div class="exhibition_block">-->
<!--            <div class="container_title" style="text-align: left">-->
<!--              团队协作-->
<!--            </div>-->
<!--            <div class="container_title" style="text-align: right">-->
<!--              方便安全-->
<!--            </div>-->
<!--            <div class="container_text">-->
<!--              支持绑定多个子账户，方便团队协作-->
<!--            </div>-->
<!--            <div  class="container_text">-->
<!--              账号解绑即关闭访问权限，企业信息更安全-->
<!--            </div>-->
<!--          </div>-->
<!--        </el-col>-->
<!--        <el-col :span="12">-->
<!--          <div class="exhibition_block2">-->
<!--            <div class="container_title" style="text-align: left; padding: 5px 0">-->
<!--              更多-->
<!--            </div>-->
<!--            <div class="container_title" style="text-align: center; padding: 5px 0">-->
<!--              更快-->
<!--            </div>-->
<!--            <div class="container_title" style="text-align: right; padding: 5px 0">-->
<!--              更轻松-->
<!--            </div>-->
<!--            <div class="container_text">-->
<!--              存储更多记录，视频云备份，节省本地空间-->
<!--            </div>-->
<!--            <div  class="container_text">-->
<!--              云渲染效率提升，下载更快，省时省力-->
<!--            </div>-->
<!--          </div>-->
<!--        </el-col>-->
<!--      </el-row>-->
    </div>
    <!--套餐展示栏-->
    <div class="price">
<!--        {{this.data}}-->
      <img src="http://static.vlivest.com/495e1465d84fbc724d5f8e621831241d.jpg" style="width: 1200px;margin: 20px auto">

<!--      <div class="price_title">套餐资费</div>-->
      <div class="box-card">
        <table rules=none>
          <tr>
            <th style="line-height: 60px;">{{list.title}}</th>
            <th :key="item" v-for="(item) in priceData">
              <p style="line-height: 60px;font-size: 16px;" >{{item.title}}</p>
              <span style="font-weight: 100; text-decoration:line-through;" v-if="item.title !== '大客户专属定制版'">￥{{item.oldPrice}}</span>
              <span style="color: #ff5000"  v-if="item.title !== '大客户专属定制版'">￥{{item.price}}</span>
              <span style="color: #ff5000"  v-if="item.title === '大客户专属定制版'">{{item.price}}</span>
              <el-button @click="toPurchase(item)" round style="margin-bottom: 5px" >立即抢购</el-button>
            </th>
          </tr>
          <td class="col" style="padding: 0; margin: 0">
            <tr  v-for="(i) in list.contain" :key="i">
              <p style="width: 239px; padding:40px 0 20px 0; margin:5px 0 0 0; height: 73px;text-align: center; font-size: 16px; font-weight: bold">{{i}}</p>
            </tr>
          </td>
          <td class="data" v-for="(item) in priceData" :key="item">
            <tr v-for="(i) in item.contain" :key="i">
              <p style="width: 238px; line-height: 50px; font-size: 14px">{{i}}</p>
            </tr>
          </td>
        </table>
      </div>
    </div>


<!--    购买页对话框-->
    <el-dialog
      :visible.sync="dialogVisible"
      style="padding-bottom: 200px"
      title="套餐订单"
      width="600px"
      >
      <table rules=none style="overflow-y: scroll;">
        <tr style="font-size: 16px">
          <th style="line-height: 60px;">套餐名称</th>
          <th>
            {{this.selectedPlan.title}}
          </th>
        </tr>
        <td class="data" style="padding: 0">
          <tr :key="i" style="margin: auto; height: 54px;" v-for="(i) in list.contain">
            <p style="margin: 20px 0">{{i}}</p>
          </tr>
          <tr>
            <p class="tableText">价格</p>
          </tr>
        </td>
        <td class="data">
          <tr :key="o" style="margin: auto; height: 54px;" v-for="(o) in selectedPlan.contain">
            <p style="margin: 20px 0">{{o}}</p>
          </tr>
          <tr>
            <p class="tableText">{{ selectedPlan.price }}</p>
          </tr>
        </td>
      </table>
      <el-form  style="margin-left: 90px; margin-top: 10px; margin-bottom: 10px">
        <el-form-item label="优惠券" prop="verifyCode">
          <el-row>
            <el-col span="12">
              <el-input
                :length="6"
                v-model="discountCode">
              </el-input>
            </el-col>
            <el-col span="4">
              <el-button  @click="verifyDiscount">
                验证
              </el-button>
            </el-col>
          </el-row>
        </el-form-item>
      </el-form>
      <div style="margin: 10px 0 30px 0">
        <span style="font-size: 14px; color: #909399;">
          tips：套餐中”标准版视频制作次数“仅为单人主播，双人主播每单需另支付￥1000元！
        </span>
      </div>
      <el-row>
        <el-col span="16">
          总计￥<span style="font-size: 26px; color: #ff8249; margin: 0 10px">
<!--              原价<span style=" text-decoration:line-through">{{this.totalAmount + 400}}</span> -->
              {{this.totalAmount}}</span>元（已优惠{{this.selectedPlan.price - this.totalAmount}}元）
        </el-col>
        <el-col span="8">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button @click="beforePay(selectedPlan.title)" type="primary">支  付</el-button>
        </el-col>
      </el-row>
    </el-dialog>

  </div>
</template>

<script>
import crudPlan from '@/views/biz/plan/plan-service'
import accountService from "@/views/VirtualWeb/account/account-service";
import {MSG_TYPE_SUCCESS} from "@/const/common";
import loginService from "@/api/login";
import store from "@/store";
import crudCoupon from '@/views/biz/coupon/coupon-service'
import storeApi from "@/utils/store";
export default {
  name: "exhibition",
  data(){
    return{
      backgroundImg : 'http://static.vlivest.com/3822a330caec55b9c5ac9538ae36d871.png',
      list:        {title :"功能权限", contain : ["调用虚拟人物", "调用虚拟场景","标准版视频制作次数（平台现有人物场景）",
          "定制版视频制作次数（专属定制人物场景）", "人物/场景修改次数", "上传商品数量",
          "调用话术模板","系统智能配音时长", "人工专属配音时长", "视频时长上限","专属商务服务", "子账号数量",
          "在线发票服务","账号存储空间", "制作渲染效率",
           "授权使用期限"]},
      priceData: [
        // {title : "标准版", price : "4299", oldPrice : "5299", contain : ["有", "有", "3", "/", "0", "100", "无限",
        //     "无限", "/", "2h/条","有", "3","有", "有","5G",
        //      "高","商用", "30天", "有"]},
        // {title : "升级版", price : "7699", oldPrice : "9599", contain : ["有", "有", "6", "/", "0", "200", "无限",
        //     "无限", "/", "2h/条","有", "3","有", "有","8G",
        //      "高","商用", "30天", "有"]},
        // {title : "旗舰版", price : "14399", oldPrice : "17999", contain : ["有", "有", "12", "1", "1", "无限", "无限",
        //     "无限", "30min", "4h/条","有", "5","有", "有","10G",
        //      "极高","商用", "60天", "有"]},
        // {title : "大客户专属定制版", price : "咨询客服", oldPrice : "", contain : ["有", "有", "无限", "1", "3", "无限", "无限",
        //     "无限", "60min", "无限","有", "5","有", "有","100G",
        //      "极高","商用", "无限", "有"]},
      ],
      data: [],
      dialogVisible : false,
      selectedPlan : {},
      discountCode : '',//优惠券码
      discount : 1,
      totalAmount : 0,
    }
  },
  created() {
    this.getData();
    var list = storeApi.get({ name: 'staticData' });//获得所有的静态资源list
    var dataIndex = list.findIndex(o => o.label === '企业页面横幅');
    this.backgroundImg = 'https://' + list[dataIndex].value;
  },
  watch:{
    dialogVisible(val){//清空selectedPlan 否则发生复制错误
      if(val === false){
        this.selectedPlan = {};
      }
    },
    discount(val){
      this.discount = val;
      this.totalAmount = this.selectedPlan.price * val;
    }
  },
  methods:{
    getData() {
      //获得视频属性数据
      return new Promise((resolve, reject) => {
        crudPlan.list().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            var planData = [
              {title : "标准版", price : "4299", oldPrice : "5299", contain : ["3个", "3个", "3", "/", "0", "100", "无限",
                  "无限", "/", "2h/条","有", "3", "有","5G",
                  "高", "30天",]},
              {title : "升级版", price : "7699", oldPrice : "9599", contain : ["6个", "6个", "6", "/", "0", "200", "无限",
                  "无限", "/", "2h/条","有", "3", "有","8G",
                  "高", "30天"]},
              {title : "旗舰版", price : "14399", oldPrice : "17999", contain : ["12个", "12个", "12", "1", "1", "无限", "无限",
                  "无限", "30min", "4h/条","有", "5", "有","10G",
                  "极高", "60天"]},
              {title : "大客户专属定制版", price : "咨询客服", oldPrice : "", contain : ["全部人物", "全部人物", "无限", "1", "3", "无限", "无限",
                  "无限", "60min", "无限","有", "5", "有","100G",
                  "极高", "无限"]},
            ];
            for(var i = 0; i < 4; i++ ) {
              if(i !== 3) planData[i].price = res.data[i].price;
              planData[i].title = res.data[i].name;
              res.data[i].times > 9999 ? planData[i].contain[2] = '无限' : planData[i].contain[2] = res.data[i].times;
              res.data[i].customTimes === 0 ? planData[i].contain[3] = '/' : planData[i].contain[3] = res.data[i].customTimes;
              planData[i].contain[4] = res.data[i].editTime;
              res.data[i].goodsQuantity > 9999 ? planData[i].contain[5] = '无限' : planData[i].contain[5] = res.data[i].goodsQuantity;
              res.data[i].audioTime === 0 ? planData[i].contain[8] = '/' : planData[i].contain[8] = res.data[i].audioTime + 'min';
              res.data[i].videoTime > 9999 ? planData[i].contain[9] = '无限' : planData[i].contain[9] = res.data[i].videoTime + 'h/条';
              planData[i].contain[11] = res.data[i].childAccount;
              planData[i].contain[14] = res.data[i].storage + 'G';
            }
            this.priceData = planData;
            this.data = res.data
          }
        }).catch(error => {
          reject(error)
        })
      })
    },
    goTo(url, data){
      //带参数跳转
      // console.log(data)
      this.$router.push({path:url, query : {func: data}});
    },
    toPurchase(item){
      var _this = this;
      // console.log(store.state.user);
      if(item.title === '大客户专属定制版'){
        this.$alert('即将前往客服联系页面！', '提示', {
          confirmButtonText: '确定',
          callback: action => {
            this.goTo('/contactUs');
          }
        });
      }
      else{
        if(store.getters.loginSuccess){//已登录
          if(store.state.user.user.roleNames === '个人用户'){//个人用户购买套餐需补全企业信息
            // console.log('补全信息');
            this.$prompt('请输入企业/店铺名称', '补全企业信息', {
              confirmButtonText: '确定',
              cancelButtonText: '取消',
              inputPattern: /^[\s\S]*.*[^\s][\s\S]*$/,
              inputErrorMessage: '企业名称不能为空'
            }).then(({ value }) => {
              // console.log(value);
              _this.addCompany(value);
            }).catch(() => {
              this.$message({
                type: 'info',
                message: '取消输入'
              });
            });
          }
          else{
            this.dialogVisible = true;
            this.selectedPlan = JSON.parse(JSON.stringify(item));
            this.totalAmount = this.selectedPlan.price * this.discount;
          }
        }
        else{
          this.$alert('请先登录！', '提示', {//未登录则需先登录
            confirmButtonText: '确定',
            callback: action => {
              this.goTo('/login');
            }
          });
        }
      }
    },
    verifyDiscount(){//验证优惠券码
      return new Promise((resolve, reject) => {
          crudCoupon.verify(this.discountCode).then(res => {
            if(res.code === MSG_TYPE_SUCCESS){
              this.discount = res.data.discount;
              resolve(res);
            }
          }).catch(res => {
            reject(res)
          })
      });
    },
    addCompany(companyName){
      // console.log(companyName);
      return new Promise((resolve, reject) => {//补充企业信息
        accountService.add(companyName).then((res) => {
          // console.log(res)
          // store.state.user.user.roleName = '企业管理员'
          this.$alert('已将账户升级为企业版，请重新登录！', '提示', {//未登录则需先登录
            confirmButtonText: '确定',
            callback: action => {// 重新登录
          //     store.state.user.user.roleName = '企业管理员'
              this.$store.dispatch('LogOut').then(() => {
                this.$router.push({path:'/'});
              })
            }
          });
          resolve(res)
        }).catch(error => {
          reject(error)
        })
      })
    },
    beforePay(title){
      var dataIndex = this.data.findIndex(o => o.name === title);
      if(dataIndex === -1){//找不到该套餐
        this.$alert('系统错误，请稍后重试！', '提示', {
          confirmButtonText: '确定',
          callback: action => {
            this.goTo('/');
          }
        });
      }
      else {
        var planId = this.data[dataIndex].id;
        this.getToken(planId);//获取token
      }
      this.dialogVisible = false;
    },
    getToken(planId){//获取token
      return new Promise((resolve, reject) => {
        loginService.token().then((res) => {
          // console.log(res)
          this.toPay(planId, res);
        }).catch(error => {
          reject(error)
        })
      })
    },
    toPay(planId, token){//获取支付链接
      // var data = {
      //   planId : planId,
      //   token : token
      // }
      return new Promise((resolve, reject) => {
        crudPlan.purchase(planId, token).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            window.open(res.message);//前往支付页面
          }
        }).catch(error => {
          reject(error)
        })
      })
    }
  }
}
</script>

<style scoped>
.exhibition_background{
  /*width: 100%;*/
  /*height: 400px;*/
  /*background-image: url("~@/assets/enterprise/create.jpg");*/
  background-size: cover;
}
.exhibition{
  width: 100%;
  background-color: rgba(255, 80, 0, 0.1);
  height: 400px;
  color: white;
  text-align: center;
}

.word_container{
  width: 1200px;
  margin: auto;
}
/*.exhibition_title{*/
/*  padding-top: 100px;*/
/*  font-size: 40px;*/
/*  line-height: 46px;*/
/*}*/
/*.exhibition_desc{*/
/*  padding-top: 16px;*/
/*  font-size: 24px;*/
/*  line-height: 27px;*/
/*}*/
.exhibition_link{
  position: absolute;
  top: 200px;
  left: 600px;
}
.exhibition_link_login{
  display: inline-block;
  width: 135px;
  font-size: 16px;
  line-height: 38px;
  text-align: center;
  box-sizing: border-box;
  border-radius: 3px;
  border: 1px solid #ff5000;
  color: #fff;
  background-color: #ff5000;
  cursor: pointer;
}
.exhibition_link_register{
  display: inline-block;
  width: 135px;
  font-size: 16px;
  line-height: 38px;
  text-align: center;
  box-sizing: border-box;
  border-radius: 3px;
  border: 1px solid white;
  color: #ff5000;
  background-color: #fff;
  cursor: pointer;
  margin-left: 32px;
}
/*.exhibition_phone{*/
/*  position: absolute;*/
/*  width: 1200px;*/
/*  margin: auto;*/
/*  margin-top: 18px;*/
/*  font-size: 14px;*/
/*  line-height: 20px;*/
/*  color: rgba(255, 255, 255, 0.7);*/
/*}*/

.container_background{
  margin: 30px 0;
  height: 800px;
  /*padding: 72px 0 82px;*/
  /*background-color: #f8fafd;*/
}
/*.container{*/
/*  width: 1200px;*/
/*  margin: 0 auto;*/
/*  padding: 0 136px 0 113px;*/
/*  box-sizing: border-box;*/
/*}*/
/*.container_title{*/
/*  font-size: 36px;*/
/*  font-weight: bold;*/
/*  line-height: 41px;*/
/*  padding: 10px 0;*/
/*}*/
/*.container_text{*/
/*  font-size: 18px;*/
/*  line-height: 15px;*/
/*  margin-top: 20px;*/
/*  text-align: left;*/
/*}*/
/*.container_img{*/
/*  width: 100%;*/
/*}*/

/*.exhibition_block{*/
/*  margin: 50px;*/
/*  width: 500px;*/
/*  height: 300px;*/
/*  color: white;*/
/*  background-color: rgba(255, 80, 0, 0.7);*/
/*  border-radius: 10px;*/
/*  padding: 30px 50px;*/
/*  box-shadow: 10px 16px 16px 0 rgba(137, 151, 181, 0.11);*/
/*}*/

/*.exhibition_block2{*/
/*  margin: 50px;*/
/*  width: 500px;*/
/*  height: 300px;*/
/*  color: rgba(255, 80, 0, 0.8);*/
/*  background-color: white;*/
/*  border-radius: 10px;*/
/*  box-shadow: 10px 16px 16px 0 rgba(137, 151, 181, 0.11);*/
/*  padding: 30px 50px;*/
/*}*/


.price{
  /*background-color: rgba(66, 133, 246, 0.08);*/
  padding: 50px;
  width: 1300px;
  margin: auto;
}
/*.price_title{*/
/*  text-align: center;*/
/*  font-size: 28px;*/
/*  color: #0D203E;*/
/*  line-height: 40px;*/
/*  padding: 10px 0 40px 0;*/
/*}*/
.box-card{
  margin: auto;
  /*float: left;*/
  border: 1px solid #EBEEF5;
  background-color:#FFF;
  border-radius: 4px;
  color: #303133;
  height: 1395px;
  transition: .3s;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
}

.col{
  height: 1200px;
  background: rgba(255,80,0,0.1);
}
table th{
  background: rgba(255,80,0,0.1);
}
.data tr:nth-child(even)
{
  background: #f7fafc;
}
/*.price-num{*/
/*  line-height: 30px;*/
/*  font-size: 14px;*/
/*  font-weight: lighter;*/
/*  color: #ff5000;*/
/*}*/

.tableText{
  width: 280px;
  line-height: 30px;
  font-size: 16px;
}

</style>
