<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input class="filter-item input-small" v-model="query.name" clearable size="small" placeholder="输入类型搜索"
                  @keyup.enter.native="toQuery"/>
        <el-input class="filter-item input-small" v-model="query.title" clearable size="small" placeholder="输入表单名称搜索"
                  @keyup.enter.native="toQuery"/>
        <rrOperation/>
      </div>
      <crudOperation :permission="permission"/>
    </div>
    <!--Form表单-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="800px"
    >
      <el-form ref="form" :model="form" label-width="120px" size="small">

        <!--前端显示的请选择***的内容-->
        <el-form-item label="配置项类别" prop="title" :rules="[{required: true,min: 0,max: 30,message: '长度在 0 到 30 个字符', trigger: 'blur'},]">
          <el-input v-model="form.title" class="input-small"></el-input>
        </el-form-item>

        <!--中文服务名称-->
        <el-form-item label="具体名称" prop="value"
                      :rules="[{required: true,message: '请输入具体名称', trigger: 'blur'},{min: 0,max: 20,message: '长度在 0 到 20 个字符', trigger: 'blur'},]">
          <el-input v-model="form.value" class="input-small"></el-input>
        </el-form-item>

        <!--填写编码-->
        <el-form-item label="详情描述" prop="name" :rules="[{min: 0,max: 20,message: '长度在 0 到 100 个字符', trigger: 'blur'},]">
          <el-input v-model="form.description" class="input-small"></el-input>
        </el-form-item>

        <!--增值服务填写plusService，非增值服务无需填写，默认为类型同名字段-->
        <el-form-item label="增值服务类型" prop="type"
                      :rules="[{required: true, min: 0,max: 20,message: '长度在 0 到 20 个字符', trigger: 'blur'},]">
          <el-radio v-model="form.type" label="1">是</el-radio>
          <el-radio v-model="form.type" label="0">否</el-radio>
        </el-form-item>

        <!--改为上传图片-->
        <el-form-item label="图片链接" prop="url" :rules="[{min: 0,max: 20,message: '长度在 0 到 20 个字符', trigger: 'blur'},]">
<!--          <el-input v-model="form.url" class="input-small"></el-input>-->
          <el-upload
            ref="upload"
            class="avatar-uploader"
            action="#"
            :http-request="uploadImg"
            accept="image/jpeg,image/png"
            :show-file-list="false"
            :auto-upload="true"
            :multiple="false"
            :on-change="onUploadChange"
          >
            <img v-if="imageUrl" :src="imageUrl" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="crud.cancelCU">取消</el-button>
        <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
      </div>
    </el-dialog>
    <!--表格渲染-->
    <el-table
      ref="table"
      v-loading="crud.loading"
      :data="crud.data"
      style="width: 100%;"
      @sort-change="crud.sortChange"
      @selection-change="crud.selectionChangeHandler"
    >
      <el-table-column type="selection" width="55"/>
      <el-table-column align="center" label="属性名" :show-overflow-tooltip="true" prop="title"/>
      <el-table-column align="center" label="属性值" :show-overflow-tooltip="true" prop="value"/>
      <el-table-column align="center" label="是否为增值服务" :show-overflow-tooltip="true" prop="type">
        <template slot-scope="scope">
          <span>{{ scope.row.type === '0' ? '否' : '是' }}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="图片" :show-overflow-tooltip="true" prop="url"/>
      <el-table-column v-permission="[permission.edit,permission.del]" label="操作" width="120px" fixed="right">
        <template slot-scope="scope">
          <udOperation :data="scope.row" :permission="permission"/>
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination/>
  </div>
</template>

<script>
import crudConfig from '@/views/biz/config/config-service'
import CRUD, {crud, form, header, presenter} from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import {mapGetters} from 'vuex'
import dubOperate from "@/components/VirtualWeb/addDetail/machineDub/dub-service";
import {MSG_TYPE_SUCCESS} from "@/const/common";

const defaultForm = {
  value: null,
  name: null,
  type: null,
  url: null,
  title: null,
}
export default {
  name: 'Config',
  components: {crudOperation, rrOperation, udOperation, pagination},
  cruds() {
    return CRUD({title: '配置项', crudMethod: {...crudConfig}})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    return {
      imageUrl : null,
      validateNumber: (rule, value, callback) => {
        validate.isNumber(rule, value, callback)
      },
      validateDigits: (rule, value, callback) => {
        validate.isDigits(rule, value, callback)
      },
      permission: {
        edit: 'biz_config_edit',
        del: 'biz_config_del'
      }
    }
  },
  computed: {
    ...mapGetters(["permissions", "dicts"])
  },
  created() {
  },
  methods: {
    save(){
      // console.log(this.imageUrl);
      if(this.imageUrl === null){
        crud.submitCU;
      }
      else{


      }
    },
    onUploadChange(file){
      // console.log(file);
      const  isIMAGE = (file.raw.type === 'image/jpeg' || file.raw.type === 'image/png');
      const  isLt1M = file.size / 1024 / 1024 < 1;

      if(!isIMAGE){
        this.$message.error('只能上传jpg/png图片！');
        return  false;
      }
      if(!isLt1M){
        this.$message.error('上传文件大小不能超过1MB！');
        return  false;
      }

      var _this = this;

      var reader = new FileReader();
      reader.readAsDataURL(file.raw)

      reader.onload = function (e){
        //this.result为图片的base64
        // console.log(this.result)
        //将图片路径赋值给url
        _this.imageUrl = e.target.result;
      }

    },
    uploadImg(file){
      return new Promise((resolve, reject) => {
        dubOperate.uploadFile(file).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            form.url = res.data.url;
          }
        }).catch(error => {
          this.loading = false;
          reject(error)
        })
      });
    },
  }
};
</script>

<style lang="scss" scoped>
.avatar-uploader{
  border: 1px dashed #d9d9d9 !important;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  width: 178px;
  height: 178px;
}
.avatar-uploader:hover {
  border-color: #ff5000 !important;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
