<template>
<div class="newProduct">
    <div class="directBar">
        <el-button @click="add">点击创建商品</el-button>
        <el-button  @click="next">下一步</el-button>  
     </div>
    <div class="proBar">
        <div class="proContainer">
          <h3 class="barTitle">组件配置页面展示</h3>
          <el-scrollbar>
            <draggable
              tag="el-collapse"
              class="dragArea list-group"
              :list="chooseList"
              group="comp"
              @change="log"
            >
              <el-collapse
              class="list-group-item left"
              v-for="(item,index) in chooseList"
              :key="index"
              v-model="activeNames"
              @change="handleChange"
              >
                <el-collapse-item>
                    <template slot="title">
                      <span>{{item.name}}</span>
                      <i class="el-icon-circle-close" @click.stop="deleteItem(item.name,item.id)"></i>
                    </template>
                    <div>{{item.content}}</div>
                    <component :is="item.type" :item="item" @saveData='saveData' ></component>
                </el-collapse-item>
              </el-collapse>
            </draggable>
          </el-scrollbar>

        </div>

    <div class="script">
      <h3 class="barTitle">串词列表</h3>
      <el-autocomplete
      clearable
      class="inline-input"
      v-model="search"
      :fetch-suggestions="querySearch"
      placeholder="请输入内容"
      @change="searchData"
      @select="handleSelect"
      >
      </el-autocomplete>
        <el-scrollbar>
          <draggable
            class="dragArea list-group"
            :list="searchData"
            :group="{ name: 'comp', pull: 'clone', put: false }"
            :clone="clone"
            @change="log"
          >
              <div  class="itemContainer" v-for="(item,index) in searchData" :key="index">
                  <scriptItem class='scriptItem' :item="item"></scriptItem> 
              </div>
          </draggable>
       </el-scrollbar>

       
    </div>
  </div>
  </div>
<!-- </div> -->
</template>
<script> 
import product from './product'
import scriptItem from './scriptItem'
import draggable from "vuedraggable"
let anchorName='W';
let touristName='LH';
let followerName='LH';
let deadline=28;
let restTime=5;
let luckyDog='LH';
let startTime=8;
let price = 200;
export default {
  name: "proDetail",
  components : {
    product,
    scriptItem,
    draggable,
  },
  data() {
    return {
      imageUrl: '',
      search:'',
      scriptList: [
        [
            {content:`哈喽，宝宝们，大家好，欢迎来到${anchorName}的直播间，我是本场的主播${anchorName}`,type:"scriptItem"},
            {content:"hello大家好，欢迎各位帅哥美女们来到我的直播间，进来直播间的是美女还是帅哥呢？刷刷弹幕让我看到你哦~",type:"scriptItem"},
            {content:"欢迎各位小伙伴们来到我的直播间，主播人美歌甜性格好，关注就像捡到宝，小伙伴们走过路过不要错过，喜欢的宝宝在哪里？",type:"scriptItem"},
            {content:"感谢刚进来的小伙伴哦，每天晚上8点，主播为你分享化妆小技巧，不要错过哦！",type:"scriptItem"}
        ],
        [
            {content:`欢迎${touristName}来到我的直播间，喜欢主播的点个关注哦！`,type:"scriptItem"},
            {content:"欢迎宝宝们来到直播间，关注主播不迷路，优惠活动早知道!",type:"scriptItem"},
            {content:`欢迎来到${anchorName}直播间，主播带你了解更多优惠福利，喜欢主播的记得关注哦，爱你们！`,type:"scriptItem"},
            {content:"欢迎宝宝们来到我的直播间，希望宝宝们能多多支持，多多捧场哦。",type:"scriptItem"},
            {content:"欢迎新来的朋友不要着急马上走，人间自有真情在，点点红心都是爱，天若有情6天亦老，来波关注好不好。",type:"scriptItem"},
            {content:"有钱的捧个钱场，没钱的捧个人场，空闲的捧个留场，喜欢的捧个情场，最重要的，给你们一个笑场！",type:"scriptItem"},
            {content:"月亮不睡你不睡，都是我的小宝贝！千山万水总是情，点个关注行不行！",type:"scriptItem"},
            {content:`感谢${followerName}的关注，还没关注的宝宝们抓紧关注哦，我们每场直播都会给大家带来不同的惊喜福利呢！`,type:"scriptItem"},
            {content:"非常感谢关注了的宝宝们，谢谢大家对我们的支持和喜欢！我们一定为帮大家争取更多的福利哦！",type:"scriptItem"}
        ],
        [
            {content:"话不多说，咱们先来一波抽奖，点赞关注主播，弹幕扣666，截图最上面的宝宝，稍后会有客服私信你哦~",type:"scriptItem"},
            {content:"各位宝宝注意了！今天直播抽奖的奖品真的超级丰厚哦！机不可失失不再来，一定要参与啊！",type:"scriptItem"},
            {content:`恭喜${luckyDog}宝宝中奖啦！太幸运了吧！我都有些羡慕了！赶紧点击左下角链接私信客服，联系客服小姐姐领取奖品`,type:"scriptItem"},
            {content:"哦！没有抽中的宝宝也不要走开，之后最后我们会抽一位幸运儿送出我们的免单大奖哦！",type:"scriptItem"},
            {content:"直播间的宝宝们注意喽！我们开始倒计时啦，5！4！3！2！1！让我们看看是哪位幸运的包包可以获得我们的直播间大奖呢！",type:"scriptItem"},
            {content:"再过5分钟就要开始抽奖啦！大家千万不要走开，快拉你的老公一起来刷屏，中奖概率double！",type:"scriptItem"}
        ],

        [
            {content:"购买抢福利的名额限量前20位，先到先得！目前还剩5个名额！快点击屏幕链接抢先购买哦！卖完就真的再也没有了！",type:"scriptItem"},
            {content:`各位宝宝，线上抢购的人数多，我们的活动到${deadline}号就结束了，请大家看中了抓紧时间下单哈！没抢到的宝宝请谅解哦。`,type:"scriptItem"},
            {content:"数量有限，看中的要及时下单了，机会难得，我们的货品已经即将售窑，之后短时间内可能都没有这样的优惠了哦。",type:"scriptItem"},
            {content:"这次货品折扣仅限本次活动进行时间，错过了我们就无法再给您这个价格了，敬请谅解，看中的宝宝抓紧时间拍下哦！",type:"scriptItem"},
            {content:`这个价格只有在我们直播间才能拿到，我们还有${restTime}分钟就下播了，没拍的宝宝可以去拍哦！`,type:"scriptItem"},
            {content:"活动已经告一段落，感谢大家的参与。喜欢我们可以关注直播间，以后有类似活动会第一时间通知大家。",type:"scriptItem"},
            {content:`先付先得、最后${restTime}分钟！最后${restTime}分钟！`,type:"scriptItem"},
            {content:`这次活动的力度真的很大，之前这款产品的价格是${price}，很划算，错过真的很可惜。`,type:"scriptItem"},
            {content:"小仙女，喜欢的话可以直接下单哦，宝贝数量有限，喜欢要趁早，越早下单宝贝就能越早到亲手上哦",type:"scriptItem"},
            {content:"抢到就是赚到、秒杀单品数量有限！",type:"scriptItem"},
            {content:"刚错过的小可爱们，现在下单还来得及啊！特地为你们开了一辆末班车，下手要快，错过真没了",type:"scriptItem"},
            {content:"小仙女今天不买它，你今晚回去睡不下，心里总会想着它！早买早享受",type:"scriptItem"}
        ],
        [
            {content:`感谢${touristName}来我的直播间，你们有什么问题都可以问我哦，主播都会认真为大家解答的。`,type:"scriptItem"},
            {content:`感谢${followerName}的关注，是我们的产品让忍不住你出手了吧，肯定是不接受任何反驳。`,type:"scriptItem"},
            {content:"首先感谢今天所有进入我直播间的观众们，谢谢你们的关注。虽然有一部分人没有陪到我下播的时候。但百忙之中抽时间过来，实属难得。感谢所有进直播间的各位。另外很多人从我一开播就来了，一直陪着我下播。比如某某，某某。陪伴是最长情的告白，你们的爱意我收到了，咱们下次再见。",type:"scriptItem"},
            {content:"非常感谢关注了我们的宝宝们，谢谢大家对我们直播间的支持和喜欢！明天直播间还会抽出一名幸运免单用户，一定要记得关注主播哦，我们不定时会有惊喜福利！",type:"scriptItem"}
        ],
        [
            {content:"今天的直播接近尾声了，我们要下播喽，希望大家睡个好觉做个好梦，明天新的一天好好工作。",type:"scriptItem"},
            {content:`明天${startTime}点准时开播，欢迎大家再来哦，大家拜拜~`,type:"scriptItem"},
            {content:"今天的直播接近尾声了，明天晚上几点到几点？",type:"scriptItem"},
            {content:"同样时间开播，明天会提早一点不？",type:"scriptItem"},
            {content:"各位奔走相告吧，明天休息一天，大家放假了，后天正常开播。",type:"scriptItem"}
        ],

      ],
      typeList:[
         { value: "开场白" },
          { value: "欢迎词" },
          { value: "抽奖词" },
          { value: "追单词" },
          { value: "感谢词" },
          { value: "结束词" },
      ],
      // 左边展示栏列表
      chooseList: [],
      activeNames: [],
      count: 0,
      scriptName:'引导词'

    }
  },
  methods: {
    next(){
        this.$router.replace('addMark')
        this.$store.commit('NEXT')
    },
    log: function(evt) {
      window.console.log(evt);
    },
    clone({content}) {
      ++this.$store.state.dub.idGlobal
      return {
        id: ++this.$store.state.dub.scriptid,
        name: this.scriptName,
        content:content
      };
    },
    add(){
      let item =  { name: "商品", id:++this.$store.state.dub.productid ,type:'product',globalid:++this.$store.state.dub.idGlobal}
      this.chooseList.push(item)
      this.$store.commit('ADD_PRODUCT',item)
    },
    saveData(productData){
      this.$store.commit('ADD_PRODUCT',productData)
    },
    querySearch(queryString, cb) {
      var typeList = this.typeList ;
      var results = queryString ? typeList .filter(this.createFilter(queryString)) : typeList ;
      cb(results);
    },
    createFilter(queryString) {
      return (type) => {
        return (type.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
      };
    },
    loadAll(){
       return [
          { value: "开场白" },
          { value: "欢迎词" },
          { value: "抽奖词" },
          { value: "追单词" },
          { value: "感谢词" },
          { value: "结束词" },
        ]
    },
    handleSelect(item) {
      console.log('handleSelect:',item);
    },
    handleChange: function() {},
    deleteItem: function(name,item_id) {
      --this.$store.state.dub.idGlobal
      this.$store.commit('DELETE_DATA',{name,item_id})
      this.chooseList = JSON.parse(localStorage.getItem('configData')||'[]')
    },
  },
  mounted() {
    this.typeList = this.loadAll();
    this.chooseList = JSON.parse(localStorage.getItem('configData')||'[]')
  },
  computed: {
    searchData: function() {
      var search = this.search;
       var listid=-1
      if(search){
        // 直接搜索类别
        this.typeList.filter((item,id)=>{
          if(item.value===search){
            listid=id
             this.scriptName=this.typeList[listid].value
          }
        })
        if (listid!== -1) {
          return this.scriptList[listid]
        }
        else{
          var list=[]
           this.scriptList.filter((list,index) => {
             list.filter(item=>{
              if(item.content.indexOf(search)>=0)
              {
                list.push(item)
                this.scriptName=this.typeList[index].value
               return item
              }
            })
           
          })
          return list;
        }
      }
      else {
        // this.scriptName=this.typeList[0].value
        return this.scriptList[0]
      }
     
    
   }
  },
  watch: {
     chooseList: {
         handler: function() {
            this.$store.commit('ADD_SCRIPT',this.chooseList)
         },
         deep: true
     }
  }

}
</script>
<style lang="scss" scoped>
.newProduct{
  width:100%;
  height:100%;
    .barTitle{
        padding:20px 0;
    }
    .directBar{
        width:100%;
        padding:20px 40px;
        display:flex;
        justify-content: flex-end;
        align-items: center;
    }
    .proBar{
        width:100%;
        display:flex;
        justify-content: center;
        align-items: flex-start;
        box-sizing: border-box;
        .proContainer{
            background-color:rgb(245,247,250);
            padding:0 20px 20px 20px;
            width:700px;
            height:500px;
            box-sizing:border-box;
            margin-right:20px;
            .barTitle{
                padding:10px 0;
            }
            .scriptItem{
                height:40px;
            }
            .list-group {
                max-height:400px;
                display: flex;
                flex-direction: column;
                padding-left: 0;
                border: 0;
                .list-group-item:first-child {
                border-top-left-radius: 0.25rem;
                border-top-right-radius: 0.25rem;
                }
                .list-group-item {
                    position: relative;
                    display: block;
                    padding: 0;
                    margin-bottom: -1px;
                    background-color: #fff;
                    border: 1px solid rgba(0, 0, 0, 0.125);
                    box-sizing: border-box;
                    ::v-deep.el-collapse-item__content{
                        padding-bottom:0px !important;
                    }
                    ::v-deep .el-collapse-item__header{
                        padding-left:10px !important;
                    }
                }
              }
              .saveBar{
                width:100%;
                display:flex;
                justify-content: flex-end;
                align-items: center;
                el-button{
                  margin:0 20px;
                }
              }
          }
      .script{
        box-sizing: border-box;
        padding-bottom:30px;
        width:400px;
        height:500px;
        background-color:rgb(245,247,250);
        .barTitle{
                padding:10px 0;
            }
        .el-autocomplete{
          margin-bottom:20px;
        }
        .el-scrollbar{
         .list-group{
           max-height:400px;     
         }
        }
        .itemContainer{
          margin:10px 0;
          .scriptItem{
            display:inline-block;
            width:100%;
            height:100%;
          }
        }
      }
   .el-collapse{
      width:100%;
      // height:100%;
      border:0 !important;
      .el-collapse-item__content{
        padding-bottom: 10px !important;
      }
      .el-collapse-item__header {
        border: 0 !important;
        font-size:18px
      }
      .el-collapse-item__wrap {
        border-bottom: 0;
      }
      .list-group-item {
        margin:20px 0;
        cursor: move;
        .el-collapse-item:last-child{
          margin-bottom:0px;
        }
      }
      h3 {
        font-size: 28px;
        margin-bottom: 20px;
      }
      .el-icon-circle-close {
        color: #c9a2a2;
        font-size: 20px;
        position: absolute;
        right: 50px;
      }

      .el-icon-circle-close:hover {
        color: #f40;
      }
    }
    .list-group {
      display: flex;
      flex-direction: column;
      padding-left: 0;
      margin-bottom: 0;
      border: 0;
      padding:0 10px;
      .list-group-item:first-child {
        border-top-left-radius: 0.25rem;
        border-top-right-radius: 0.25rem;
      }
      .list-group-item {
        margin:20px 0;
        position: relative;
        display: block;
        padding: 0;
        margin-bottom: -1px;
        background-color: #fff;
        box-sizing: border-box;
        border-radius: 5px;
        border:2px dashed #CCC !important
      }
    }

  }
}

    
</style>