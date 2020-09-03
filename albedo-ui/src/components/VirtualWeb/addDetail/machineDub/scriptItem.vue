<template>
<div class="scriptItem">
    <div class="scriptContent">{{item.content}}</div>
</div>

</template>
<script>
export default {
    props:['item'],
    data(){
        return{
      
        }
    },
    mounted(){
    }

}
</script>

<style lang="scss" scoped>
.scriptItem{
    border:2px dashed #ccc;
    border-radius: 10px;
    width:100%;
    height:30px;
    display:inline-block;
    .scriptContent{
        padding:10px;
    }
}
    
</style>