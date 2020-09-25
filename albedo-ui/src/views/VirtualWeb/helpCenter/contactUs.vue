<template>
    <div class='contactUs'>
       <div class='pageTitle'>联系我们</div>
       <div class="pageDetails">
           <el-row :key='item' class='msg' v-for='item in msgBox'>
             <el-col span="4">
               {{ item.title }}
             </el-col>
             <el-col span="20" v-if="item.title !== '联系客服：'">
               {{ item.data }}
             </el-col>
             <el-col span="20" v-else>
               <img :src="item.data" style="width: 400px">
             </el-col>
           </el-row>
       </div>
    </div>
</template>
<script>
export default {
      data(){
        return{
          msgBox : [{
            title : '公司名称：',
            data : '杭州葳锐信息科技有限公司',
          },
            {
              title : '邮编：',
              data : '310018',
            },
            {
              title : '电子邮件：',
              data : 'veirui@foxmail.com',
            },
            {
              title : '电 话：',
              data : '0571-28878118',
            },
            {
              title : '联系客服：',
              data : 'http://static.vlivest.com/dda55084adb9ad442446035d68a8629b.png',
            }]
            // msgBox:["公司名称： 杭州葳锐信息科技有限公司",
            //   "邮编： 310018",
            //   "电子邮件： veirui@foxmail.com",
            //   "电 话： 0571-28878118"]
        }
    }

}
</script>
<style lang="scss" scoped>
@import '@/common/style.scss';
    .contactUs{
        @include guideStyle;
        .pageDetails{
            margin:20px 0;
            width:100%;
            .msg{
                font-size: 14px;
                padding:10px 0;
                text-align: left;
                color:#7d7d7d
            }
        }
    }
</style>
