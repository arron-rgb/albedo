<template>
    <div class="selfMark">
        <div class="directBar">
            <h3>添加贴片和水印</h3>
            <div class="directBtn">
                <el-button  @click="back">上一步</el-button>
                <el-button  @click="submit">提交</el-button> 
            </div> 
        </div>
        <div class="markContainer">
            <div class="addLogo">
                <h3 class="barTitle">
                    添加贴片
                </h3>
                <!-- :class="{disabled:uploadDisabled}" -->
                <el-upload
                class='upload'
                :on-success="handleAvatarSuccess"
                :on-change="handleChange"
                :on-remove="handleRemove"
                action="#"
                limit=1
                list-type="picture-card"
                :auto-upload="false">
                    <i slot="default" class="el-icon-plus"></i>
                    <div slot="file" slot-scope="{file}">
                        <img
                        class="el-upload-list__item-thumbnail"
                        :src="file.url" alt=""
                        >
                        <span class="el-upload-list__item-actions">
                        <span
                            class="el-upload-list__item-preview"
                            @click="handlePictureCardPreview(file)"
                        >
                            <i class="el-icon-zoom-in"></i>
                        </span>
                        <span
                            v-if="!disabled"
                            class="el-upload-list__item-delete"
                            @click="handleDownload(file)"
                        >
                            <i class="el-icon-download"></i>
                        </span>
                        <span
                            v-if="!disabled"
                            class="el-upload-list__item-delete"
                            @click="handleRemove(file)"
                        >
                            <i class="el-icon-delete"></i>
                        </span>
                        </span>
                    </div>
                </el-upload>
                <el-dialog :visible.sync="dialogVisible">
                    <img width="100%" :src="dialogImageUrl" alt="">
                </el-dialog>
            </div>
            <div class="addmark">
                <h3 class="barTitle">
                    添加水印
                </h3>
                <el-upload
                class="upload"
                :on-success="handleAvatarSuccess"
                :on-change="handleChange"
                :on-remove="handleRemove"
                action="#"
                limit=1
                list-type="picture-card"
                :auto-upload="false">
                    <i slot="default" class="el-icon-plus"></i>
                    <div slot="file" slot-scope="{file}">
                        <img
                        class="el-upload-list__item-thumbnail"
                        :src="file.url" alt=""
                        >
                        <span class="el-upload-list__item-actions">
                        <span
                            class="el-upload-list__item-preview"
                            @click="handlePictureCardPreview(file)"
                        >
                            <i class="el-icon-zoom-in"></i>
                        </span>
                        <span
                            v-if="!disabled"
                            class="el-upload-list__item-delete"
                            @click="handleDownload(file)"
                        >
                            <i class="el-icon-download"></i>
                        </span>
                        <span
                            v-if="!disabled"
                            class="el-upload-list__item-delete"
                            @click="handleRemove(file)"
                        >
                            <i class="el-icon-delete"></i>
                        </span>
                        </span>
                    </div>
                </el-upload>
                <el-dialog :visible.sync="dialogVisible">
                    <img width="100%" :src="dialogImageUrl" alt="">
                </el-dialog>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    methods:{
       submit(){
            this.$router.replace('/')
            this.$store.commit('next')
        },
        back(){
            this.$router.replace('uploadDub')
            this.$store.commit('dubBack')
        }
    }
}
</script>
<style lang="scss" scoped>
.selfMark{
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
            .upload{
                display:flex;
                justify-content: flex-start;
                padding:0 10px;
            }
        }
        .addmark{
            width:500px;
            min-height:200px;
            padding-bottom:20px;
            background-color: rgb(245,247,250);
            display:flex;
            flex-direction: column;
            justify-content: center;
            .barTitle{
                width:100%;
                padding:10px;
                text-align: left;
            }
            .upload{
                padding:0 10px;
                background-color: rgb(245,247,250);
                display:flex;
                justify-content: flex-start;
            }
        }
        
    }
}


</style>