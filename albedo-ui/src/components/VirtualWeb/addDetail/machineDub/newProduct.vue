<template>
<div class="newProduct">
<!--    <div class="directBar">-->
<!--        <el-button  @click="next">下一步</el-button>-->
<!--     </div>-->

<!--  {{this.chooseList}}-->
  <el-dialog
    title="新增商品"
    :visible.sync="productData.dialogVisible"
    width="600px">
    <component v-bind:productData="productData" is="product" ></component>
  </el-dialog>


    <div class="proBar">
      <div class="proDeposit">
        <div class="depositBox">
          <h3 class="barTitle">商品库</h3>
          <i class="el-icon-plus" @click="productData.dialogVisible = !productData.dialogVisible"></i>
        </div>
        <el-scrollbar>
            <el-card
              class="list-group-item"
              v-for="(item,index) in this.productList[pager - 1]"
              :key="index"
            >
              <el-row>
                <el-col span="6">
                  <img class="commodityImg" :src="item.urls">
<!--                  <img class="commodityImg" src="@/assets/VirtualWeb/timg.jpg">-->
                </el-col>
                <el-col style="padding-left: 10px" span="18">
                  <el-row>
                    <el-col span="19">
                      <span style="font-size: 18px; line-height: 30px">{{item.name}}</span>
                    </el-col>
                    <el-col span="3">
                    <i class="el-icon-circle-close" @click.stop="deleteItem(item.id)"></i>
                    </el-col>
                    <el-col span="2">
                      <i class="el-icon-right" @click.stop="add(item, 'product')"></i>
                    </el-col>
                  </el-row>
                  <el-row>
                    <p style="text-align: left; margin: 0; line-height: 30px;font-size: 14px">{{item.description}}</p>
                  </el-row>
                </el-col>
              </el-row>
            </el-card>
        </el-scrollbar>
        <el-pagination
          layout="prev, pager, next"
          @current-change="currentChange"
          :total="productData.proDeposit.length">
        </el-pagination>
      </div>


      <div class="proContainer">
        <h3 class="barTitle">已选台词组件</h3>
        <el-scrollbar>
          <draggable
            tag="el-collapse"
            class="dragArea list-group"
            :list="chooseList"
            group="comp"
            @change="saveConfig"
          >
<!--            <el-collapse-->
<!--            class="list-group-item left"-->
<!--            v-for="(item,index) in chooseList"-->
<!--            :key="index"-->
<!--            v-model="activeNames"-->
<!--            @change="handleChange"-->
<!--            >-->
<!--              <el-collapse-item>-->

                <el-card
                  class="list-group-item"
                  v-for="(item,index) in chooseList"
                  :key="index"
                >
                  <el-row v-if="item.type === 'product'">
                    <el-col span="6">
                      <img class="commodityImg" :src="item.data.urls">
                      <!--                  <img class="commodityImg" src="@/assets/VirtualWeb/timg.jpg">-->
                    </el-col>
                    <el-col style="padding-left: 10px" span="18">
                      <el-row>
                        <el-col span="22">
                          <span style="font-size: 18px; line-height: 30px">{{item.data.name}}</span>
                        </el-col>
                        <el-col span="2">
                          <i class="el-icon-circle-close" @click.stop="removeItem(index)"></i>
                        </el-col>
                      </el-row>
                      <el-row>
                        <p style="text-align: left; margin: 0; line-height: 30px;font-size: 14px">{{item.data.description}}</p>
                      </el-row>
                    </el-col>
                  </el-row>
                </el-card>
<!--                  <template slot="title">-->
<!--                    <span>{{item.name}}</span>-->
<!--                    <i class="el-icon-circle-close" @click.stop="deleteItem(item.name,item.id,1)"></i>-->
<!--                  </template>-->
<!--                  <component :is="item.type" :item="item" @saveData='saveData' ></component>-->
<!--              </el-collapse-item>-->
<!--            </el-collapse>-->
          </draggable>
        </el-scrollbar>

      </div>
      <div class="script">
        <h3 class="barTitle">串词列表</h3>
        <div class="inline-input">
          <el-autocomplete
          clearable
          style="width: 80%"
          v-model="search"
          :fetch-suggestions="querySearch"
          placeholder="请输入内容"
          @change="searchData"
          @select="handleSelect"
          >
          </el-autocomplete>
        </div>
        <el-collapse v-model="this.scriptData" accordion>
          <el-collapse-item :title="item.title" v-for="item in this.scriptData">

            <el-card
              class="list-group-item"
              v-for="(item,index) in item.data"
              :key="index"
            >
<!--              <div>-->
                  <i class="el-icon-right" @click.stop="add(item, 'product')"></i>
<!--              </div>-->
              {{item.value}}
            </el-card>
          </el-collapse-item>
        </el-collapse>
<!--          <el-scrollbar>-->
<!--            <draggable-->
<!--              class="dragArea list-group"-->
<!--              :list="searchData"-->
<!--              :group="{ name: 'comp', pull: 'clone', put: false }"-->
<!--              :clone="clone"-->
<!--              @change="log"-->
<!--            >-->
<!--                <div  class="itemContainer" v-for="(item,index) in searchData" :key="index">-->
<!--                    <scriptItem class='scriptItem' :item="item"></scriptItem>-->
<!--                </div>-->
<!--            </draggable>-->
<!--        </el-scrollbar>-->


      </div>
  </div>
  </div>
<!-- </div> -->
</template>
<script>
import product from './product'
import scriptItem from './scriptItem'
import draggable from "vuedraggable"
import crudCommodity from '@/views/biz/commodity/commodity-service'
import crudScript from '@/views/biz/script/script-service'
import {MSG_TYPE_SUCCESS} from "@/const/common";

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
      productData :{
        dialogVisible: false,
        // 商品库
        proDeposit:[],
      },
      pager : 1,
      productList : [],
      scriptData : [ { "title": "追单词", "data": [ { "id": "16cd3c09c0494217cce63b8c1e623f6f", "value": "购买抢福利的名额限量前20位，先到先得！目前还剩5个名额！快点击屏幕链接抢先购买哦！卖完就真的再也没有了！", "title": "追单词" }, { "id": "1e1914abc4dd9f0dfa1199b5c3eadb46", "value": "活动已经告一段落，感谢大家的参与。喜欢我们可以关注直播间，以后有类似活动会第一时间通知大家。", "title": "追单词" }, { "id": "2363cf752e73874c23503158d4b02097", "value": "这次货品折扣仅限本次活动进行时间，错过了我们就无法再给您这个价格了，敬请谅解，看中的宝宝抓紧时间拍下哦！", "title": "追单词" }, { "id": "2a94fc17ee580599157a3bb85d7296b1", "value": "数量有限，看中的要及时下单了，机会难得，我们的货品已经即将售窑，之后短时间内可能都没有这样的优惠了哦。", "title": "追单词" }, { "id": "2cec16d1326495190379ace4acc3947b", "value": "先付先得、最后${restTime}分钟！最后${restTime}分钟！", "title": "追单词" }, { "id": "3d25945e927b87213c7d244b44249e85", "value": "小仙女，喜欢的话可以直接下单哦，宝贝数量有限，喜欢要趁早，越早下单宝贝就能越早到亲手上哦", "title": "追单词" }, { "id": "7217e94bb9a1391b853dfffe0dab08fc", "value": "小仙女今天不买它，你今晚回去睡不下，心里总会想着它！早买早享受", "title": "追单词" }, { "id": "84b7bb98067bf879b088c66274667d83", "value": "这次活动的力度真的很大，之前这款产品的价格是${price}，很划算，错过真的很可惜。", "title": "追单词" }, { "id": "cba8ac86b472b8032d676c6500f6dd4e", "value": "这个价格只有在我们直播间才能拿到，我们还有${restTime}分钟就下播了，没拍的宝宝可以去拍哦！", "title": "追单词" }, { "id": "cfb94eb73abcc75add7fc8bb0f6f4e56", "value": "抢到就是赚到、秒杀单品数量有限！", "title": "追单词" }, { "id": "f5b05492522c30be4403a4982bcaed3b", "value": "各位宝宝，线上抢购的人数多，我们的活动到${deadline}号就结束了，请大家看中了抓紧时间下单哈！没抢到的宝宝请谅解哦。", "title": "追单词" }, { "id": "f688fa8e5a0bbcb44def00c1b8780774", "value": "刚错过的小可爱们，现在下单还来得及啊！特地为你们开了一辆末班车，下手要快，错过真没了", "title": "追单词" } ] }, { "title": "感谢词", "data": [ { "id": "7e6bc25a4367c9145abf5d57b32da66e", "value": "感谢${name}的关注，是我们的产品让忍不住你出手了吧，肯定是不接受任何反驳。", "title": "感谢词" }, { "id": "9933e853fe25b41a4935d801f872dadb", "value": "首先感谢今天所有进入我直播间的观众们，谢谢你们的关注。虽然有一部分人没有陪到我下播的时候。但百忙之中抽时间过来，实属难得。感谢所有进直播间的各位。另外很多人从我一开播就来了，一直陪着我下播。比如某某，某某。陪伴是最长情的告白，你们的爱意我收到了，咱们下次再见。", "title": "感谢词" }, { "id": "a3c4be2ad1d331aa19714ffceb2b00b3", "value": "感谢${name}来我的直播间，你们有什么问题都可以问我哦，主播都会认真为大家解答的。", "title": "感谢词" }, { "id": "d86cdd4ba5a68df4d078a9135def8197", "value": "非常感谢关注了我们的宝宝们，谢谢大家对我们直播间的支持和喜欢！明天直播间还会抽出一名幸运免单用户，一定要记得关注主播哦，我们不定时会有惊喜福利！", "title": "感谢词" } ] }, { "title": "欢迎词", "data": [ { "id": "07c5e9f86a2c6d72f3940f7a45cf94cd", "value": "直播间的宝宝们注意喽！我们开始倒计时啦，5！4！3！2！1！让我们看看是哪位幸运的包包可以获得我们的直播间大奖呢！", "title": "欢迎词" }, { "id": "1c698446cfd8453087a23c7b330fd91c", "value": "哦！没有抽中的宝宝也不要走开，之后最后我们会抽一位幸运儿送出我们的免单大奖哦！", "title": "欢迎词" }, { "id": "2d7dbb5b0a3d0c1544e7bba6841c3059", "value": "各位宝宝注意了！今天直播抽奖的奖品真的超级丰厚哦！机不可失失不再来，一定要参与啊！", "title": "欢迎词" }, { "id": "32bd44066610964aa6ae45e9d37e84de", "value": "恭喜${name}宝宝中奖啦！太幸运了吧！我都有些羡慕了！赶紧点击左下角链接私信客服，联系客服小姐姐领取奖品", "title": "欢迎词" }, { "id": "48dbd29e6bd74b23a7f95158fb96066c", "value": "再过5分钟就要开始抽奖啦！大家千万不要走开，快拉你的老公一起来刷屏，中奖概率double！", "title": "欢迎词" }, { "id": "5e29216c66463a26a0793255911a216c", "value": "欢迎宝宝们来到直播间，关注主播不迷路，优惠活动早知道!", "title": "欢迎词" }, { "id": "6f5f4334e0cae75e7b9e81a3b3eb7e86", "value": "有钱的捧个钱场，没钱的捧个人场，空闲的捧个留场，喜欢的捧个情场，最重要的，给你们一个笑场！", "title": "欢迎词" }, { "id": "785c554c5c3366779583007808e86790", "value": "欢迎来到${anchorName}直播间，主播带你了解更多优惠福利，喜欢主播的记得关注哦，爱你们！", "title": "欢迎词" }, { "id": "7adf5ed3e248e4b542eacb7521d547ec", "value": "欢迎宝宝们来到我的直播间，希望宝宝们能多多支持，多多捧场哦。", "title": "欢迎词" }, { "id": "a429e3ea4ceb76e9584095aad5e99c0d", "value": "欢迎${touristName}来到我的直播间，喜欢主播的点个关注哦！", "title": "欢迎词" }, { "id": "b83ecf0a9098dd6384ecaa9d3a47a785", "value": "欢迎新来的朋友不要着急马上走，人间自有真情在，点点红心都是爱，天若有情6天亦老，来波关注好不好。", "title": "欢迎词" }, { "id": "d877390169a2b5296ab3ada1396b239c", "value": "感谢${name}的关注，还没关注的宝宝们抓紧关注哦，我们每场直播都会给大家带来不同的惊喜福利呢！", "title": "欢迎词" }, { "id": "dd4674fbd5b31aa5eb0757919069f1f4", "value": "非常感谢关注了的宝宝们，谢谢大家对我们的支持和喜欢！我们一定为帮大家争取更多的福利哦！", "title": "欢迎词" }, { "id": "de848a57ea3b9e2e50df0b1018e50967", "value": "月亮不睡你不睡，都是我的小宝贝！千山万水总是情，点个关注行不行！", "title": "欢迎词" }, { "id": "e376f7a8aa642059c0b6cc539ffc45ee", "value": "话不多说，咱们先来一波抽奖，点赞关注主播，弹幕扣666，截图最上面的宝宝，稍后会有客服私信你哦~", "title": "欢迎词" } ] }, { "title": "结束词", "data": [ { "id": "1214fc29968fb2b65fa2dde6646b1e2b", "value": "明天${startTime}点准时开播，欢迎大家再来哦，大家拜拜~", "title": "结束词" }, { "id": "18fa5c339078460a5f7698fb176bd039", "value": "今天的直播接近尾声了，我们要下播喽，希望大家睡个好觉做个好梦，明天新的一天好好工作。", "title": "结束词" }, { "id": "33951fd271d139b1f9dcd56b106002d7", "value": "各位奔走相告吧，明天休息一天，大家放假了，后天正常开播。", "title": "结束词" }, { "id": "7f851d3e179e2b7151718dfaa1d58fcc", "value": "同样时间开播，明天会提早一点不？", "title": "结束词" }, { "id": "9d86587b1c80f7838d47bbf10fccec58", "value": "今天的直播接近尾声了，明天晚上几点到几点？", "title": "结束词" } ] }, { "title": "开场白", "data": [ { "id": "648713505c665281c721558042c63a0c", "value": "哈喽，宝宝们，大家好，欢迎来到${anchorName}的直播间，我是本场的主播${anchorName}", "title": "开场白" }, { "id": "a761c986b04af157761c1800b1588f21", "value": "hello大家好，欢迎各位帅哥美女们来到我的直播间，进来直播间的是美女还是帅哥呢？刷刷弹幕让我看到你哦~", "title": "开场白" }, { "id": "bfd9d3b1a344aa557ec09379cfd04126", "value": "欢迎各位小伙伴们来到我的直播间，主播人美歌甜性格好，关注就像捡到宝，小伙伴们走过路过不要错过，喜欢的宝宝在哪里？", "title": "开场白" }, { "id": "d41376b96e4336e21144253860869a3f", "value": "感谢刚进来的小伙伴哦，每天晚上8点，主播为你分享化妆小技巧，不要错过哦！", "title": "开场白" } ] } ],
      scriptList: [
        [
            {content:`哈喽，宝宝们，大家好，欢迎来到${anchorName}的直播间，我是本场的主播${anchorName}`,type:"scriptItem"},
            {content:"hello大家好，欢迎各位帅哥美女们来到我的直播间，进来直播间的是美女还是帅哥呢？刷刷弹幕让我看到你哦~",type:"scriptItem"},
            {content:"欢迎各位小伙伴们来到我的直播间，主播人美歌甜性格好，关注就像捡到宝，小伙伴们走过路过不要错过，喜欢的宝宝在哪里？",type:"scriptItem"},
            {content:"感谢刚进来的小伙伴哦，每天晚上8点，主播为你分享化妆小技巧，不要错过哦！",type:"scriptItem"}
        ],
        [
            {content:`欢迎${name}来到我的直播间，喜欢主播的点个关注哦！`,type:"scriptItem"},
            {content:"欢迎宝宝们来到直播间，关注主播不迷路，优惠活动早知道!",type:"scriptItem"},
            {content:`欢迎来到${name}直播间，主播带你了解更多优惠福利，喜欢主播的记得关注哦，爱你们！`,type:"scriptItem"},
            {content:"欢迎宝宝们来到我的直播间，希望宝宝们能多多支持，多多捧场哦。",type:"scriptItem"},
            {content:"欢迎新来的朋友不要着急马上走，人间自有真情在，点点红心都是爱，天若有情6天亦老，来波关注好不好。",type:"scriptItem"},
            {content:"有钱的捧个钱场，没钱的捧个人场，空闲的捧个留场，喜欢的捧个情场，最重要的，给你们一个笑场！",type:"scriptItem"},
            {content:"月亮不睡你不睡，都是我的小宝贝！千山万水总是情，点个关注行不行！",type:"scriptItem"},
            {content:`感谢${name}的关注，还没关注的宝宝们抓紧关注哦，我们每场直播都会给大家带来不同的惊喜福利呢！`,type:"scriptItem"},
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
    }
  },
  created() {
    // this.getScripts()
    this.getCommodityList();
  },
  methods: {

    //获得套词
    getScripts(){
      return new Promise((resolve, reject) => {
        crudScript.list().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.scriptData = res.data.data
          }
        }).catch(error => {
          reject(error)
        })
      })
    },
    //获取商品库
    getCommodityList(){
      return new Promise((resolve, reject) => {
        crudCommodity.get().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            // console.log(res)
            this.productData.proDeposit = res.data
            var i = 0;
            for(i; i < this.productData.proDeposit.length / 10 ; i++)
              this.productList[i] = this.productData.proDeposit.slice(i * 10, i * 10 + 10);
            this.productList[i] = this.productData.proDeposit.slice(i * 10);
          }
        }).catch(error => {
          reject(error)
        })
      })
    },

    //修改页面商品数量
    currentChange(page){
      this.pager = page;
    },
    //删除商品
    deleteItem: function(id) {
      return new Promise((resolve, reject) => {
        crudCommodity.del(id).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            //重新获取商品列表
            this.getCommodityList()
            resolve();
          }
        }).catch(error => {
          reject(error)
        })
      })
    },

    // 添加已有商品到配置项
    add(item, type){
      if(type === 'product')
            this.chooseList.push({type : type, data : item})
    },
    removeItem(index){
      this.chooseList.splice(index,1);
    },




    next(){
        this.$router.replace('addMark')
        this.$store.commit('NEXT')
    },
    log: function(evt) {
      window.console.log("evt:",evt);
    },
    clone({content,type}) {
      let tmp=content;
      let kind=type;
      ++this.$store.state.dub.idGlobal
      return {
        id: ++this.$store.state.dub.scriptid,
        name: `${this.$store.state.dub.scriptid}号串词-${this.scriptName}`,
        content:tmp,
        type:kind
      };
    },



    // 保存中间配置数据
    saveConfig(){
      // this.$store.commit('ADD_CONFIG_DATA',this.chooseList)
    },
    // 保存商品数据
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



    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    }
  },
  mounted() {
    this.typeList = this.loadAll();
    // this.chooseList = JSON.parse(localStorage.getItem('configData')||'[]')
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
        this.scriptName=this.typeList[0].value
        return this.scriptList[0]
      }


   }
  },
  watch: {
     chooseList: {
         handler: function() {
            // this.$store.commit('ADD_SCRIPT',this.chooseList)
         },
         deep: true
     },
    // proDeposit :{
    //   handler:function(){
    //     this.proDeposit = this.$store.state.dub.productData
    //   },
    //   deep: true
    // }

  }

}
</script>
<style lang="scss" scoped>
.newProduct{
  width: 1200px;
  //padding: 0 20px;
  margin: auto;
  height:100%;
  .commodityImg{
    //按最短的边等比放大
    object-fit: cover;
    width: 80px;
    height: 80px;
  }
    .directBar{
        width:100%;
        padding:20px 40px;
        display:flex;
        justify-content: flex-end;
        align-items: center;
    }
    .proBar{
        display:flex;
        justify-content: center;
        align-items: flex-start;
        box-sizing: border-box;
        border-radius: 5px;
        .proDeposit{
          overflow-y: scroll;
          height: 700px;
          //background-color:rgb(245,247,250);
          border:1px solid #ebeef5;
          border-radius: 5px;
          padding:0 15px 15px 15px;
          width:390px;
          margin-right: 15px;
          //width:600px;
          min-height:500px;
          box-sizing:border-box;
          //margin-right:20px;
          .depositBox{
            position: sticky;
            top: 0;
            background-color: white;
            z-index: 9;
            display:flex;
            justify-content: flex-end;
            align-items: center;
            .barTitle{
              margin-right:120px;
              padding:10px 0;
            }
            .el-icon-plus{
              z-index: 9;
              margin-right:20px;
              // background-color:#ff5000;
              // color:white;
              &:hover{
                cursor: pointer;
                color: #ff5000;
              }
            }
          }
        }
        .proContainer{
          //background-color:rgb(245,247,250);
          //padding:0 15px 15px 15px;
          border:1px solid #ebeef5;
          overflow-y: scroll;
          height: 700px;
          border-radius: 5px;
          padding: 0 15px;
          width:390px;
          min-height:500px;
          box-sizing:border-box;
          margin-right:15px;
          .barTitle{
            margin: 0;
            padding:30px 0;
            position: sticky;
            top: 0;
            background-color: white;
            z-index: 9;
          }

        }
        .list-group {
          max-height:400px;
          display: flex;
          flex-direction: column;
          padding-left: 0;
          border: 0;
          //.list-group-item:first-child {
          //border-top-left-radius: 0.25rem;
          //border-top-right-radius: 0.25rem;
          //}
          .list-group-item {
            position: relative;
            display: block;
            //padding: 0;
            //margin-bottom: -1px;
            background-color: #fff;
            box-sizing: border-box;
            ::v-deep.el-collapse-item__content{
                padding-bottom:0 !important;
            }
            ::v-deep .el-collapse-item__header{
                padding-left:10px !important;
            }
          }
        }
        .script{
          overflow-y: scroll;
          box-sizing: border-box;
          //padding-bottom:30px;
          width:390px;
          padding: 0 15px 15px 15px;
          border:1px solid #ebeef5;
          border-radius: 5px;
          height:700px;
          //background-color:rgb(245,247,250);
          .barTitle{
            padding:30px 0;
            position: sticky;
            top: 0;
            background-color: white;
            z-index: 9;
            margin: 0;
          }
          .inline-input {
            width: 100%;
            position: sticky;
            top: 80px;
            background-color: white;
            z-index: 9;
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
      .el-icon-circle-close {
        color: #c9a2a2;
        font-size: 20px;
      }

      .el-icon-circle-close:hover {
        color: #f40;
      }

      .el-icon-right {
        font-size: 13px;
        color:rgba(0,116,232,0.6);
        border: 1.5px solid rgba(0,116,232,0.6);
        border-radius: 10px;
        box-sizing: border-box;
      }
      .el-icon-right:hover {
        color: rgb(0,116,232);
        border: 1.5px solid rgb(0,116,232);
      }
        .el-collapse{
          width:100%;
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
          h3 {
            font-size: 28px;
            margin-bottom: 20px;
          }
        }
        .list-group {
          display: flex;
          flex-direction: column;
          margin-bottom: 0;
          border: 0;
          //padding:0 10px;
          //.list-group-item:first-child {
          //  border-top-left-radius: 0.25rem;
          //  border-top-right-radius: 0.25rem;
          //}
        }

    }
  .list-group-item {
    position: relative;
    display: block;
    margin-bottom: 20px;
    background-color: #fff;
    box-shadow: unset;
    box-sizing: border-box;
    border-radius: 10px !important;
    border:1px solid #ebeef5 !important;
  }
  .list-group-item:hover{
    box-shadow: 0 2px 12px 0 rgba(0,0,0,.1)
  }
}






</style>
