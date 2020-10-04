<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input class="filter-item input-small" v-model="query.code" clearable size="small" placeholder="输入优惠码编号搜索"
                  @keyup.enter.native="toQuery"/>
        <el-input class="filter-item input-small" v-model="query.status" clearable size="small" placeholder="输入可用状态搜索"
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
      <el-form ref="form" :inline="true" :model="form" label-width="120px" size="small">
        <el-form-item label="折扣" prop="discount">
          <el-input v-model="form.discount" class="input-small"></el-input>
        </el-form-item>
        <el-form-item label="备注" prop="description"
                      :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
          <el-input v-model="form.description" class="input-small"></el-input>
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
      <el-table-column align="center" label="优惠码编号" :show-overflow-tooltip="true" prop="code"/>
      <el-table-column align="center" label="使用状态" :show-overflow-tooltip="true" prop="status">
        <template slot-scope="scope">
          <span>{{ scope.row.status === '1' ? "未使用" : "已使用" }}</span>
        </template>

      </el-table-column>
      <el-table-column align="center" label="折扣" :show-overflow-tooltip="true" prop="discount"/>
      <el-table-column align="center" label="使用的订单id" :show-overflow-tooltip="true" prop="orderId"/>
      <el-table-column align="center" label="使用者" :show-overflow-tooltip="true" prop="userId"/>
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
import crudCoupon from '@/views/biz/coupon/coupon-service'
import CRUD, {crud, form, header, presenter} from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import {mapGetters} from 'vuex'

const defaultForm = {
  code: null,
  status: null,
  userId: null,
  description: null,
  discount: null
}
export default {
  name: 'Coupon',
  components: {crudOperation, rrOperation, udOperation, pagination},
  cruds() {
    return CRUD({title: '优惠券', crudMethod: {...crudCoupon}})
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
        edit: 'biz_coupon_edit',
        del: 'biz_coupon_del'
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
