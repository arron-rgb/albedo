<template>
    <div class="selectAttri">
        <div class="directBar">
            <h3>选择配音属性</h3>
            <div class="directBtn">
                <el-button  @click="next">下一步</el-button>
            </div> 
        </div>
        <div class="markContainer">
            <div class="addLogo">
                <h3 class="barTitle">
                    选择属性
                </h3>
                <div class="selectBar">
                    <div class="attriType" v-for="(list,index) in attriType" :key="index">
                        <div class="listType">{{list.listType}}</div>
                        <div class="attriList">
                            <el-button v-for="(attri,id) in list.list" :key="id" @click="changeActive(index,id)"
                            :class="{active:attriType[index].active===id,'select-button':attriType[index].active!==id}">
                                {{attri}}
                            </el-button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="showSelected">
                <h3 class="barTitle">
                    已选属性
                </h3>
                <div  class="selectedAttri">
                    <el-tag v-for="(item,id) in selectedAttri" :key="id">{{item}}</el-tag>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
  data(){
      return{
          attriType:[
            {listType:'性别',list:['男','女'],active:-1},
            {listType:'声音',list: ['婴儿','儿童','少年','青年','中年'],active:-1},
            {listType:'类型',list:['讲述播报','综艺播报','新闻播报'],active:-1},
            {listType:'标签',list:['大气','活力','浑厚','甜美','激情'],active:-1}
          ],
          selectedAttri:[]
      }
  },
  methods:{
    changeActive(listid,id){
        let selectedItem = this.attriType[listid].list[id]
        if(this.attriType[listid].active===-1)
        {
            this.attriType[listid].active=id
            this.selectedAttri.push(selectedItem)
        }
        else if(this.attriType[listid].active===id)
        {
            this.attriType[listid].active=-1
            this.selectedAttri.filter((item,i)=>{
                if(item===selectedItem)
                    this.selectedAttri.splice(i,1)
            })
        }
        else{
            let prevAttri = this.attriType[listid].list[this.attriType[listid].active]
            this.selectedAttri.filter((item,i)=>{
                if(item===prevAttri)
                    this.selectedAttri.splice(i,1)
            })
            this.attriType[listid].active=id
            this.selectedAttri.push(selectedItem)
        }
    },
    next(){
        this.$router.replace('paymentPage')
        this.$store.commit('NEXT')
    },

  
  }
}
</script>
<style lang="scss" scoped>
.selectAttri{
    width:100%;
    .directBar{
        width:100%;
        padding:20px 50px;
        display:flex;
        justify-content: space-between;
        align-items: center;
    }
    .markContainer{
        width:100%;
        height:100%;
        display:flex;
        justify-content: space-around;
        align-items: flex-start;
        padding:20px 0;
        .addLogo{
            width:500px;
            min-height:200px;
            padding-bottom:20px;
            background-color: rgb(245,247,250);
            .barTitle{
                width:100%;
                padding:10px;
                text-align: left;
            }
            .selectBar{
                width:100%;
                height:300px;
                padding:20px;
                display:flex;
                flex-direction: column;
                justify-content: space-evenly;
                align-items: flex-start;
                .attriType{
                    background-color: whitesmoke;
                    display:flex;
                    justify-content: center;
                    align-items: center;
                    .listType{
                        margin:0 20px;
                    }
                    .attriList{
                        background-color:white;
                        display:flex;
                        align-items: center;
                        .el-button{
                            border:1px solid white;
                            & + .el-button{
                                margin-left:0
                            }
                        }
                       
                    }
                     .select-button{
                        &:hover{
                            background-color: rgba(255, 237, 229, 0.4);
                            color: #ff5000;
                            border-color: #ff5000;
                        }
    
                    }
                     .active{
                        background-color: #ff5000;;
                        color: white;
                        border: 0;
                    }
                }
            }
        }
        .showSelected{
            width:500px;
            min-height:200px;
            padding-bottom:20px;
            background-color: rgb(245,247,250);
            .barTitle{
                width:100%;
                padding:10px;
                text-align: left;
            }
            .selectedAttri{
                padding:10px 40px;
                height:100px;
                display:flex;
                justify-content:flex-start;
                .el-tag{
                    background-color: #fff8e6;
                    border-color: #fff1cc;
                    color: #ffba00;
                    &:hover {
                        color: #ff5000;
                        cursor: pointer;
                    }
                    &:focus {
                    color: #ff5000;
                    cursor: pointer;
                    }
                    &+ .el-tag{
                        margin-left:20px;
                    }
                }
                .el-tag--small{
                    height:30px;
                    line-height:30px;
                    font-size:14px;
                    border-radius:8px;
                }
            }
            
            
                
                
        }
        
    }
}


</style>