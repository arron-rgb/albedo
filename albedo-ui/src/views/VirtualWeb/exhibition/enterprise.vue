<template>
  <div>
    <!--  banner栏-->
    <div class="exhibition_background" :style="{backgroundImage: 'url(' + backgroundImg + ')'}">
      <div class="exhibition">
        <div class="exhibition_title word_container" >虚拟直播企业版</div>
        <div class="exhibition_desc word_container">批量下单更优惠，客户服务更到位</div>
        <div class="exhibition_link word_container">
          <a class="exhibition_link_login">登录企业账户</a>
          <a class="exhibition_link_register">创建企业账户</a>
        </div>
        <div class="exhibition_phone">咨询电话：0571-88888888</div>
      </div>
    </div>

    <!--    <div class="container_background">-->
    <!--      <el-container class="container">-->
    <!--        <el-aside style="padding-top: 73px" width="252px">-->
    <!--          <div class="container_title" style="text-align: left">-->
    <!--            企业定制-->
    <!--          </div>-->
    <!--          <div class="container_title" style="text-align: right">-->
    <!--            品牌专享-->
    <!--          </div>-->
    <!--          <div class="container_text">-->
    <!--            虚拟直播直降XXX元-->
    <!--          </div>-->
    <!--          <div  class="container_text">-->
    <!--            赠送改稿权限及配音服务，无忧打造智慧直播间-->
    <!--          </div>-->
    <!--        </el-aside>-->
    <!--        <el-main style="margin-left: 145px;  padding: 0;">-->
    <!--          <img src="@/assets/timg.jpg" class="container_img">-->
    <!--        </el-main>-->
    <!--      </el-container>-->
    <!--    </div>-->

    <div class="exhibition_right">

    </div>

    <div class="container_background">
      <el-row class="word_container">
        <el-col :span="12">
          <div class="exhibition_block2">
            <div class="container_title" style="text-align: left">
              企业定制
            </div>
            <div class="container_title" style="text-align: right">
              品牌专享
            </div>
            <div class="container_text">
              虚拟直播直降XXX元
            </div>
            <div  class="container_text">
              赠送改稿权限及配音服务，无忧打造智慧直播间
            </div>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="exhibition_block">
            <div class="container_title" style="text-align: left">
              专属商务
            </div>
            <div class="container_title" style="text-align: right">
              快速响应
            </div>
            <div class="container_text">
              7*12h专属客服，采购、售后全程无忧
            </div>
            <div  class="container_text">
              规范商务流程，合同、发票无需等待
            </div>
          </div>
        </el-col>
      </el-row>
      <el-row class="word_container">
        <el-col :span="12">
          <div class="exhibition_block">
            <div class="container_title" style="text-align: left">
              团队协作
            </div>
            <div class="container_title" style="text-align: right">
              方便安全
            </div>
            <div class="container_text">
              支持绑定多个子账户，方便团队协作
            </div>
            <div  class="container_text">
              账号解绑即关闭访问权限，企业信息更安全
            </div>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="exhibition_block2">
            <div class="container_title" style="text-align: left; padding: 5px 0">
              更多
            </div>
            <div class="container_title" style="text-align: center; padding: 5px 0">
              更快
            </div>
            <div class="container_title" style="text-align: right; padding: 5px 0">
              更轻松
            </div>
            <div class="container_text">
              存储更多记录，视频云备份，节省本地空间
            </div>
            <div  class="container_text">
              云渲染效率提升，下载更快，省时省力
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
    <!--套餐展示栏-->
    <div class="price">
      <div class="price_title">套餐资费</div>
      <div class="box-card">
        <table rules=none>
          <tr>
            <th style="line-height: 60px;">{{list.title}}</th>
            <th v-for="item in priceData" :key="item">
              <p style="line-height: 60px;" >{{item.title}}</p>
              <el-button style="margin-bottom: 5px" round size="small">￥{{item.price}}&emsp;立即抢购</el-button>
            </th>
          </tr>
          <td class="col">
            <tr v-for="(i) in list.contain" :key="i">
              <p style="width: 240px; line-height: 50px; font-size: 14px">{{i}}</p>
            </tr>
          </td>
          <td class="data" v-for="(item) in priceData" :key="item">
            <tr v-for="(i) in item.contain" :key="i">
              <p style="width: 240px; line-height: 50px; font-size: 14px">{{i}}</p>
            </tr>
          </td>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "exhibition",
  data(){
    return{
      backgroundImg : require('@/assets/VirtualWeb/enterprise/create.jpg'),
      list:        {title :"功能权限", contain : ["调用虚拟人物（标准版）", "调用虚拟场景（标准版）",
          "调用虚拟人物（定制版）","调用虚拟场景（定制版）", "人物/场景修改次数", "上传商品数量",
          "调用话术模板","系统智能配音", "人工专属配音", "视频时长上限","专属商务服务", "子账号数量",
          "在线制作协议", "在线发票服务","账号存储空间", "保留历史版本", "制作渲染效率",
          "授权类型", "授权期限", "授权协议"]},
      priceData: [
        {title : "标准版", price : "999", contain : ["3", "3", "/", "/", "/", "100", "无限",
            "无限", "/", "2h/条","有", "3","有", "有","1G",
            "1条", "高","商用", "30天", "有"]},
        {title : "升级版", price : "xxx", contain : ["6", "6", "/", "/", "/", "200", "无限",
            "无限", "/", "2h/条","有", "3","有", "有","3G",
            "1-3条", "高","商用", "30天", "有"]},
        {title : "旗舰版", price : "xxx", contain : ["12", "12", "1", "1", "1", "无限", "无限",
            "无限", "30min", "4h/条","有", "5","有", "有","6G",
            "3-6条", "极高","商用", "60天", "有"]},
        {title : "大客户专属定制版", price : "xxx", contain : ["3", "3", "1", "1", "3", "无限", "无限",
            "无限", "60min", "无限","有", "5","有", "有","无限",
            "无限", "极高","商用", "无限", "有"]},
        // {name : "功能权限", baseContain : ["调用虚拟人物（标准版）",
        //     "调用虚拟场景（标准版）","上传商品数量","调用话术模板", "使用系统智能配音",
        //     "视频时长上限"], enterpriseContain :["专属商务服务","子号数量",
        //     "在线制作协议", "在线发票服务"], cloudPower:["账号存储空间", "保留历史版本",
        //     "制作渲染效率"], copyright: ["授权类型", "授权期限", "授权协议"]},
        // {name : "标准版", price : "xxx", baseContain : ["调用虚拟人物（标准版） *3",
        //   "调用虚拟场景（标准版） *3","上传商品数量 *100","调用话术模板：无限", "使用系统智能配音：无限",
        //   "视频时长上限 2h/条"], enterpriseContain :["专属商务服务","子号数量 *3",
        //   "在线制作协议", "在线发票服务"], cloudPower:["账号存储空间 1G", "保留历史版本 1条",
        //   "制作渲染效率 高"], copyright: ["授权类型：商用", "授权期限：30天", "含授权协议"]},
        // {name : "升级版", price : "xxx", baseContain : ["调用虚拟人物（标准版） *6",
        //     "调用虚拟场景（标准版） *6","上传商品数量 *200","调用话术模板：无限", "使用系统智能配音：无限",
        //     "视频时长上限 2h/条"], enterpriseContain :["专属商务服务","子号数量 *3",
        //     "在线制作协议", "在线发票服务"], cloudPower:["账号存储空间 3G", "保留历史版本 1-3条",
        //     "制作渲染效率 高"], copyright: ["授权类型：商用", "授权期限：30天", "含授权协议"]},
        // {name : "旗舰版", price : "xxx", baseContain : ["调用虚拟人物（标准版） *12",
        //     "调用虚拟场景（标准版） *12","调用虚拟人物（定制版） *1",
        //     "调用虚拟场景（定制版） *1","人物/场景修改次数 *1","上传商品数量：无限","调用话术模板：无限", "使用系统智能配音：无限",
        //     "人工专属配音：30min","视频时长上限 4h/条"], enterpriseContain :["专属商务服务","子号数量 *5",
        //     "在线制作协议", "在线发票服务"], cloudPower:["账号存储空间 6G", "保留历史版本 3-6条",
        //     "制作渲染效率：极高"], copyright: ["授权类型：商用", "授权期限：60天", "含授权协议"]},
        // {name : "旗舰版", price : "xxx", baseContain : ["调用虚拟人物（标准版）：无限",
        //     "调用虚拟场景（标准版）：无限","调用虚拟人物（定制版） *1",
        //     "调用虚拟场景（定制版） *1","人物/场景修改次数 *3","上传商品数量：无限","调用话术模板：无限", "使用系统智能配音：无限",
        //     "人工专属配音：60min","视频时长上限：无限"], enterpriseContain :["专属商务服务","子号数量 *5",
        //     "在线制作协议", "在线发票服务"], cloudPower:["账号存储空间：无限", "保留历史版本 3-6条",
        //     "制作渲染效率：极高"], copyright: ["授权类型：商用", "授权期限：无限", "含授权协议"]}
      ]
    }
  },
  methods:{

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
.exhibition_title{
  padding-top: 100px;
  font-size: 40px;
  line-height: 46px;
}
.exhibition_desc{
  padding-top: 16px;
  font-size: 24px;
  line-height: 27px;
}
.exhibition_link{
  padding-top: 32px;
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
.exhibition_phone{
  width: 1200px;
  margin: auto;
  margin-top: 18px;
  font-size: 14px;
  line-height: 20px;
  color: rgba(255, 255, 255, 0.7);
}

.container_background{
  height: 800px;
  /*padding: 72px 0 82px;*/
  background-color: #f8fafd;
}
.container{
  width: 1200px;
  margin: 0 auto;
  padding: 0 136px 0 113px;
  box-sizing: border-box;
}
.container_title{
  font-size: 36px;
  font-weight: bold;
  line-height: 41px;
  padding: 10px 0;
}
.container_text{
  font-size: 18px;
  line-height: 15px;
  margin-top: 20px;
  text-align: left;
}
.container_img{
  width: 100%;
}

.exhibition_block{
  margin: 50px;
  width: 500px;
  height: 300px;
  color: white;
  background-color: rgba(255, 80, 0, 0.7);
  border-radius: 10px;
  padding: 30px 50px;
  box-shadow: 10px 16px 16px 0 rgba(137, 151, 181, 0.11);
}

.exhibition_block2{
  margin: 50px;
  width: 500px;
  height: 300px;
  color: rgba(255, 80, 0, 0.8);
  background-color: white;
  border-radius: 10px;
  box-shadow: 10px 16px 16px 0 rgba(137, 151, 181, 0.11);
  padding: 30px 50px;
}


.price{
  /*background-color: rgba(66, 133, 246, 0.08);*/
  padding: 50px;
  width: 1300px;
  margin: auto;
}
.price_title{
  text-align: center;
  font-size: 28px;
  color: #0D203E;
  line-height: 40px;
  padding: 10px 0 40px 0;
}
.box-card{
  margin: auto;
  /*float: left;*/
  border: 1px solid #EBEEF5;
  background-color:#FFF;
  border-radius: 4px;
  color: #303133;
  height: 1700px;
  transition: .3s;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
}

.col{
  background: rgba(255,80,0,0.1);
}
table th{
  background: rgba(255,80,0,0.1);
}
.data tr:nth-child(even)
{
  background: #f7fafc;
}
.price-num{
  line-height: 30px;
  font-size: 14px;
  font-weight: lighter;
  color: #ff5000;
}
</style>
