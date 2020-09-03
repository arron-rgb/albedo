<template>
    <div class='contactUs'>
       <div class='pageTitle'>联系我们</div>
       <div class="pageDetails">
           <div v-for='i in 4' :key='i' class='msg'>
               {{msgBox[i]}}
           </div>
       </div>
    </div>
</template>
<script>
export default {
      data(){
        return{
            msgBox:["公司地址：xxxxxxxxxxxxxx", "邮政编码：310000", "联系邮箱：xxxxxxxx@xx.com", "服务电话：xxxxxxxxx"]
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