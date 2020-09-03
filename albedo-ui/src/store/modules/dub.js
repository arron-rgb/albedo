
    const state={
        // 保存需求详情的进度条状态
        active:0,
        dubActive:0,
        idGlobal : 0,
        productid : 0,
        scriptid:0,
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
        // 增加商品和保存修改
        ADD_PRODUCT(state,item){
            let ifAdd = 1;
            state.configData.filter(i=>{
                if(item.name===i.name&&item.id===i.id){
                    ifAdd = 0;
                }
            })
            if(ifAdd===1){
                item.profileList=[],
                state.configData.push(item)
            }
            ifAdd=1
            // 保存修改
            state.configData.filter((i,id)=>{
                if(item.globalid-1===id && item.ifModify){
                    item.ifModify = 0;
                    state.configData[id]=item
                }
            })
            localStorage.setItem('configData',JSON.stringify(state.configData))
        },
        ADD_SCRIPT(state,list){
            state.configData = list
            localStorage.setItem('configData',JSON.stringify(state.configData))           
        },
        DELETE_DATA(state,data){
            state.configData.filter((item,index)=>{
                if(item.name===data.name && item.id===data.item_id){
                    state.configData.splice(index,1)
                    if(data.name==="商品"){
                        if(state.productid>0){
                            --state.productid
                        }
                        
                        state.configData.forEach(item=>{
                            if(item.name==="商品"&&item.id>data.item_id)
                            {
                                item.id--
                            }
                        })
                    }
                    else{
                        --state.scriptid
                        state.configData.forEach(item=>{
                            if(item.name!=="商品"&&item.id>data.item_id)
                            {
                                item.id--
                            }
                        })
                    }
                }
              })
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