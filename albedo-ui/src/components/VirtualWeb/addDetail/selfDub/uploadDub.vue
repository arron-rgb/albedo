<template>
    <div class="uploadDub">
        <div class="directBar">
            <h3>上传音频</h3>
            <el-button  @click="next">下一步</el-button>  
        </div>
        <div class="uploadContainer">
            <div class="uploadCard">
                <!-- <div class="uploadTitle">
                    上传配音
                </div> -->
                <el-upload
                class="upload-demo"
                ref="upload"
                :on-preview="handlePreview"
                :on-remove="handleRemove"
                :file-list="fileList"
                :auto-upload="false"
                drag
                action="https://jsonplaceholder.typicode.com/posts/"
                multiple>
                    <i class="el-icon-upload"></i>
                    <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
                    <div class="el-upload__tip" slot="tip">格式支持：mp3,wav,pcm,m4,mp4,wma,且不超过2GB</div>
                </el-upload>
            </div>
        </div>

    </div>
</template>
<script>
export default {
    data(){
        return{
            fileList:[]
        }
    },
    methods: {
        next(){
            this.$router.replace('selfMark')
            this.$store.commit('dubNext')
        },
        handleRemove(file, fileList) {
            console.log(file, fileList);
        },
        handlePreview(file) {
            console.log(file);
        }
        
    },
}
</script>
<style lang="scss" scoped>
    .uploadDub{
        width:100%;
        .directBar{
            width:100%;
            padding:20px 40px;
            display:flex;
            justify-content: space-between;
            align-items: center;
        }
        .uploadContainer{
            width:100%;
            height:100%;
            display:flex;
            justify-content: space-around;
            align-items: flex-start;
            padding:20px 0;
            .uploadCard{
                display:flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;
                width:1000px;
                .upload-demo{
                    width:100%;
                    margin:0 50px;
                    ::v-deep .el-upload-dragger{
                        width:600px !important;
                    }
                }
            }
        }
    }
</style>