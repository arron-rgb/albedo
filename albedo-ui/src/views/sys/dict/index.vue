<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <el-input
          v-model="query.blurry"
          class="filter-item"
          clearable
          placeholder="输入字典名称或者描述搜索"
          size="small"
          style="width: 200px;"
          @keyup.enter.native="crud.toQuery"
        />
        <el-date-picker
          v-model="query.createdDate"
          :default-time="['00:00:00','23:59:59']"
          class="date-item"
          end-placeholder="结束日期"
          range-separator=":"
          size="small"
          start-placeholder="开始日期"
          type="daterange"
          value-format="yyyy-MM-dd HH:mm:ss"
        />
        <el-select
          v-model="query.available"
          class="filter-item"
          clearable
          placeholder="状态"
          size="small"
          style="width: 90px"
          @change="crud.toQuery"
        >
          <el-option v-for="(item,index) in flagOptions" :key="index" :label="item.label" :value="item.value" />
        </el-select>
        <rrOperation />
      </div>
      <crudOperation :permission="permission" />
    </div>
    <!--表单组件-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="500px"
    >
      <el-form ref="form" :model="form" label-width="80px" size="small">
        <el-form-item :rules="[{ required: true, trigger: 'change', message: '请选择上级字典'}]" label="上级字典" prop="parentId">
          <treeselect v-model="form.parentId" :options="dictTreeData" placeholder="选择上级类目" />
        </el-form-item>
        <el-form-item :rules="[{ required: true, trigger: 'blur', message: '请输入字典名称'}]" label="字典名称" prop="name">
          <el-input v-model="form.name" />
        </el-form-item>



        <el-form-item
          v-if="this.form.parentId === '38cd3f8f064c9b59bbfc25be1065330d' && form.code !== 'carouselUrl1' && form.code !== 'carouselUrl2' && form.code !== 'carouselUrl3'"
          label="选择文件"
          prop="val" >
          <el-input v-model="form.val" disabled/>
          <el-upload
            ref="uploadFiles"
            action="/a/file/upload"
            list-type="picture-card"
            :auto-upload="false"
            :on-remove="handleRemove"
            :on-success="handleSuccess"
          >
            <i class="el-icon-plus"></i>
          </el-upload>
          <el-button @click="submitFile">点击上传</el-button>
        </el-form-item>

        <el-form-item v-else label="字典值" prop="val">
          <el-input v-model="form.val" />
        </el-form-item>

        <el-form-item :rules="[{ required: true, trigger: 'blur', message: '请输入字典名称'}]" label="字典编码" prop="code">
          <el-input v-model="form.code" />
        </el-form-item>
        <!--        <el-form-item-->
        <!--          :rules="[{ required: true, message: '请选择是否可用', trigger: 'change' }]"-->
        <!--          label="是否可用"-->
        <!--          prop="available"-->
        <!--        >-->
        <!--          <el-radio-group v-model="form.available" size="mini">-->
        <!--            <el-radio-button v-for="item in flagOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio-button>-->
        <!--          </el-radio-group>-->
        <!--        </el-form-item>-->
        <el-form-item label="菜单排序" prop="sort">
          <el-input-number
            v-model.number="form.sort"
            :max="999"
            :min="0"
            controls-position="right"
          />
        </el-form-item>
        <el-form-item label="备注" prop="description">
          <el-input v-model="form.description" type="textarea" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="text" @click="crud.cancelCU">取消</el-button>
        <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
      </div>
    </el-dialog>
    <!--表格渲染-->
    <el-table
      ref="table"
      v-loading="crud.loading"
      default-expand-all
      :data="crud.data"
      row-key="id"
    >
      <el-table-column :selectable="checkboxT" type="selection" width="55" />
      <el-table-column label="名称" prop="name" />
      <el-table-column label="值" prop="val" :show-overflow-tooltip="true" />
      <el-table-column label="编码" prop="code" />
      <el-table-column label="序号" prop="sort" width="85" />
      <el-table-column align="center" label="是否可用" prop="available" width="85">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.available"
            v-permission="[permission.lock]"
            :active-value="1"
            :inactive-value="0"
            @change="changeAvailable(scope.row)"
          />
          <span v-show="!permissions.includes(permission.lock)">{{ scope.row.availableText }}</span>
        </template>
      </el-table-column>
      <el-table-column label="描述" prop="description" :show-overflow-tooltip="true" />
      <el-table-column label="创建日期" prop="createdDate" width="155">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        v-permission="[permission.edit, permission.del]"
        align="center"
        fixed="right"
        label="操作"
        width="130px"
      >
        <template slot-scope="scope">
          <udOperation
            :data="scope.row"
            :disabled-dle="scope.row.id === 1"
            :permission="permission"
            msg="确定删除吗,如果存在下级节点则不能删除，此操作不能撤销！"
          />
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import crudDict from '@/views/sys/dict/dict-service'
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import {MSG_TYPE_SUCCESS, NO, YES} from '@/const/common'
import { mapGetters } from 'vuex'
import dubOperate from "@/components/VirtualWeb/addDetail/machineDub/dub-service";

const defaultForm = { id: null, name: null, val: null, code: null, available: null, parentId: -1, description: null }
export default {
  name: 'Dict',
  components: { Treeselect, crudOperation, rrOperation, udOperation },
  cruds() {
    return CRUD({ title: '字典', crudMethod: { ...crudDict }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  data() {
    return {
      dictTreeData: [],
      imageUrl : null,
      permission: {
        edit: 'sys_dict_edit',
        lock: 'sys_dict_lock',
        del: 'sys_dict_del'
      },
      flagOptions: []
    }
  },
  computed: {
    ...mapGetters([
      'dicts', 'permissions'
    ])
  },
  created() {
    this.flagOptions = this.dicts['sys_flag']
  },
  methods: {
    handleSuccess(response, file, fileList){
      // console.log(response, file, fileList);
      var fileUrls = [];
      for(var i = 0; i < fileList.length; i++){
        fileUrls.push(fileList[i].response.data.url);
      }
      this.form.val = fileUrls.toString();
    },
    handleRemove(file, fileList) {
      // console.log(file, fileList);
    },
    submitFile(){
      this.$refs.uploadFiles.submit();
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
      this.uploadImg(file);
    },
    uploadImg(file){
      return new Promise((resolve, reject) => {
        dubOperate.uploadFile(file).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            this.form.url = res.data.url;
          }
        }).catch(error => {
          this.loading = false;
          reject(error)
        })
      });
    },
    // 新增与编辑前做的操作
    [CRUD.HOOK.afterToCU](crud, form) {
      // 获取所有字典
      crudDict.getDicts({ notId: form.id, available: 1 }).then(res => {
        this.dictTreeData = []
        const dict = { id: -1, label: '顶级类目', children: [] }
        dict.children = res.data
        this.dictTreeData.push(dict)
      })
    },
    // 提交前的验证
    [CRUD.HOOK.afterValidateCU]() {
      if (!this.form.parentId && this.form.id !== 1) {
        this.$message({
          message: '上级字典不能为空',
          type: 'warning'
        })
        return false
      }
      return true
    },
    // 改变状态
    changeAvailable(data) {
      const flag = data.available === YES
      this.$confirm('此操作将 "' + (flag ? '启用' : '锁定') + '" ' + data.name + ' 以及下面所有子节点, 是否继续？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        crudDict.lock([data.id]).then(res => {
          this.crud.refresh()
        }).catch(() => {
          data.available = flag ? NO : YES
        })
      }).catch(() => {
        data.available = flag ? NO : YES
      })
    },
    checkboxT(row, rowIndex) {
      return row.id !== 1
    }
  }
}
</script>

<style scoped>
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
