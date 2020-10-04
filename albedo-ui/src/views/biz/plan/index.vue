<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input class="filter-item input-small" v-model="query.name" clearable size="small" placeholder="输入套餐名搜索"
                  @keyup.enter.native="toQuery"/>
        <rrOperation/>
      </div>
<!--      <crudOperation :permission="permission"/>-->
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
        <el-form-item label="套餐价格" prop="price" :rules="[{ validator:validateNumber},]">
          <el-input v-model="form.price" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="可上传的商品数量" prop="goodsQuantity" :rules="[{validator:validateDigits},]">
          <el-input v-model="form.goodsQuantity" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="单条视频最大时长" prop="videoTime" :rules="[{validator:validateDigits},]">
          <el-input v-model="form.videoTime" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="子账户数量" prop="childAccount" :rules="[{validator:validateDigits},]">
          <el-input v-model="form.childAccount" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="人物/场景可修改次数" prop="editTime" :rules="[{validator:validateDigits},]">
          <el-input v-model="form.editTime" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="存储空间，单位GB" prop="storage" :rules="[{validator:validateDigits},]">
          <el-input v-model="form.storage" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="可下单次数" prop="times" :rules="[{validator:validateDigits},]">
          <el-input v-model="form.times" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="备注" prop="description"
                      :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
          <el-input v-model="form.description" class="input-small"></el-input>

        </el-form-item>
        <el-form-item label="套餐名" prop="name" :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符', trigger: 'blur'},]">
          <el-input v-model="form.name" class="input-small"></el-input>

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
      <el-table-column align="center" label="套餐价格" :show-overflow-tooltip="true" prop="price"/>
      <el-table-column align="center" label="可上传的商品数量" :show-overflow-tooltip="true" prop="goodsQuantity"/>
      <el-table-column align="center" label="单条视频最大时长" :show-overflow-tooltip="true" prop="videoTime"/>
      <el-table-column align="center" label="子账户数量" :show-overflow-tooltip="true" prop="childAccount"/>
      <el-table-column align="center" label="存储空间，单位GB" :show-overflow-tooltip="true" prop="storage"/>
      <el-table-column align="center" label="可下单次数" :show-overflow-tooltip="true" prop="times"/>
      <el-table-column align="center" label="套餐名" :show-overflow-tooltip="true" prop="name"/>
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
import crudPlan from '@/views/biz/plan/plan-service'
import CRUD, {crud, form, header, presenter} from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import {mapGetters} from 'vuex'

const defaultForm = {
  price: null,
  goodsQuantity: null,
  videoTime: null,
  childAccount: null,
  editTime: null,
  storage: null,
  history: null,
  times: null,
  description: null,
  name: null,
}
export default {
  name: 'Plan',
  components: {crudOperation, rrOperation, udOperation, pagination},
  cruds() {
    return CRUD({title: '套餐', crudMethod: {...crudPlan}})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    return {
      delFlagOptions: undefined,
      validateNumber: (rule, value, callback) => {
        validate.isNumber(rule, value, callback)
      },
      validateDigits: (rule, value, callback) => {
        validate.isDigits(rule, value, callback)
      },
      permission: {
        edit: 'biz_plan_edit',
        del: 'biz_plan_del'
      }
    }
  },
  computed: {
    ...mapGetters(["permissions", "dicts"])
  },
  created() {
    this.delFlagOptions = this.dicts["sys_flag"]
  },
  methods: {}
};
</script>
