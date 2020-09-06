
    const state={
        // 保存需求详情的进度条状态
        active:0,
        dubActive:0,
        idGlobal : 0,
        productid : 0,
        scriptid:0,
        productData:[],
        // 保存商品和串词列表
        configData:[],
    }
    const mutations = {
        NEXT(state){
            if (state.active++ > 1) 
                state.active = 0;
        },
        BACK(state){
            if (state.active-- < 0) 
                state.active = 0;
        },
        DUB_NEXT(state){
            if(state.dubActive++>1)
                state.dubActive = 0;
        },
        DUB_BACK(state){
            if(state.dubActive-- < 0)
                state.dubActive = 0
        },
        ADD_PRODUCT(state,item){
            let ifAdd = 1;
            state.productData.filter(i=>{
                if(item.name===i.name&&item.id===i.id){
                    ifAdd = 0;
                }
            })
            if(ifAdd===1){
                item.profileList=[],
                state.productData.push(item)
            }
            ifAdd=1
            state.productData.filter((i,id)=>{
                if(item.globalid-1===id && item.ifModify){
                    item.ifModify = 0;
                    state.productData[id]=item
                }
            })
            localStorage.setItem('productData',JSON.stringify(state.productData))
        },
        DELETE_PRODUCT(state,data){
            state.productData.filter((item,index)=>{
                console.log("DELETE_PRODUCT!")
                if(item.id===data.item_id){
                    state.productData.splice(index,1)
                    
                }
            })
            // if(state.productid>0){
            //     --state.productid
            // }
            // state.productData.filter((item,id)=>{
            //     item.id=id+1
            //     item.name=`${item.id}号商品`
            // })
            localStorage.setItem('productData',JSON.stringify(state.productData))
            this.commit('DELETE_DATA',data)     

        },
        // 修改中间配置
        ADD_CONFIG_DATA(state,list){
            state.configData = list
            localStorage.setItem('configData',JSON.stringify(state.configData))
        },
        ADD_SCRIPT(state,list){
            state.configData = list
            localStorage.setItem('configData',JSON.stringify(state.configData))           
        },
        // 删除中间配置
        DELETE_DATA(state,data){
            let deleteNum=0
            state.configData.filter((item,index)=>{
                if(item.name===data.name && item.id===data.item_id){
                    console.log("count:",item.id,"item:",item)
                    deleteNum++
                }
             })
             console.log("deleteNum:",deleteNum)
             for(let i = 0;i < deleteNum;i++)
             {
                state.configData.filter((item,index)=>{
                    if(item.name===data.name && item.id===data.item_id){
                        console.log("DEL:",data.item_id)
                        state.configData.splice(index,1)
                        if(data.name==="商品" && index==0){
                            state.configData.forEach(item=>{
                                // if(item.name==="商品"&&item.id>data.item_id)
                                // {
                                //     item.id--
                                // }
                            })
                        }
                        else{
                            --state.scriptid
                            // state.configData.forEach(item=>{
                            //     if(item.name!=="商品"&&item.id>data.item_id)
                            //     {
                            //         item.id--
                            //     }
                            // })
                        }
                    }
                  })
             }
            

            localStorage.setItem('configData',JSON.stringify(state.configData))
        },
        SUBMIT_DATA(state){

        }
 
    }

    const actions={

    }

export default {
    state,
    mutations,
    actions

}