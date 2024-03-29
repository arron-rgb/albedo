<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input class="filter-item input-small" clearable placeholder="输入所属分类搜索" size="small" v-model="query.title"
                  @keyup.enter.native="toQuery"/>
        <el-input @keyup.enter.native="toQuery" class="filter-item input-small" clearable placeholder="输入套词搜索" size="small"
                  v-model="query.value"/>
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
      <el-form ref="form" :inline="true" :model="form" label-width="120px" size="small">
        <el-form-item :rules="[{required: true, min: 1, max: 110, trigger: 'blur', message: '套词内容不能为空且不能超过110字'}]" label="所属分类" prop="title">
          <el-input v-model="form.title" class="input-small"></el-input>
        </el-form-item>
        <el-form-item :rules="[]" label="套词" prop="value">
          <el-input :rows="8"
                    maxlength="110"
                    show-word-limit
                    style="width: 300px"
                    type="textarea" v-model="form.value"></el-input>
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
      :data="crud.data"
      style="width: 100%;"
      @sort-change="crud.sortChange"
      @selection-change="crud.selectionChangeHandler"
    >
      <el-table-column type="selection" width="55"/>
      <el-table-column :show-overflow-tooltip="true" align="center" label="所属分类" prop="title"/>
      <el-table-column align="center" label="字数">
        <template slot-scope="scope">
          {{scope.row.value.length}}
        </template>
      </el-table-column>
      <el-table-column :show-overflow-tooltip="true" align="center" label="套词" prop="value"/>
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
import crudScript from '@/views/biz/script/script-service'
import CRUD, {crud, form, header, presenter} from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import {mapGetters} from 'vuex'

const defaultForm = {
  value: null,
  title: null,
}
export default {
  name: 'Script',
  components: {crudOperation, rrOperation, udOperation, pagination},
  cruds() {
    return CRUD({title: '套词', crudMethod: {...crudScript}})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    return {
      validateNumber: (rule, value, callback) => {
        validate.isNumber(rule, value, callback)
      },
      validateDigits: (rule, value, callback) => {
        validate.isDigits(rule, value, callback)
      },
      permission: {
        edit: 'biz_script_edit',
        del: 'biz_script_del'
      }
    }
  },
  computed: {
    ...mapGetters(["permissions", "dicts"])
  },
  created() {
  },
  methods: {}
};
</script>
