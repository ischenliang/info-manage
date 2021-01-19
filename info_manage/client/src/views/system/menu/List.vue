<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" @input="listGet"></el-input>
      <el-select v-model="list.filters.status" @change="listGet" clearable>
        <el-option :value="true" label="启用" />
        <el-option :value="false" label="禁用" />
      </el-select>
      <div style="flex: auto;"></div>
      <el-button type="primary" size="medium" @click="visible = true">新增</el-button>
      <el-button type="warning" size="medium">导出</el-button>
      <el-button type="danger" size="medium" @click="deleteSelected" :disabled="deleteDisabled">删除</el-button>
      <!-- 考虑做成组件 -->
      <cDropdown :show.sync="show" />
    </div>
    <div class="table">
      <el-table
        style="width: 100%;"
        height="100%"
        stripe
        ref="table"
        v-loading="list.loading"
        @sort-change="sortChange"
        row-key="id"
        :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
        @selection-change="selectChange"
        :data="list.data">
        <!-- 不好做:选择时将子代数据全选操作 -->
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="show[0].value" prop="name" label="菜单名称" width="200" align="left" sortable="custom" :show-overflow-tooltip="true" />
        <el-table-column v-if="show[1].value" prop="icon" label="图标" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[2].value" prop="component" label="组件路径" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[3].value" prop="path" label="路由地址" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[4].value" prop="order" label="显示顺序" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[5].value" prop="is_frame" label="是否外链" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[6].value" prop="type" label="类型" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[7].value" prop="status" label="状态" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-switch v-model="row.status" @change="updateRow(row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column v-if="show[8].value" prop="ctime" label="创建时间" min-width="170" align="center" sortable="custom" />
        <el-table-column v-if="show[9].value" prop="mtime" label="修改时间" min-width="170" align="center" sortable="custom" />
        <el-table-column v-if="show[10].value" prop="remark" label="备注" min-width="200" align="center" sortable="custom" />
        <el-table-column label="操作" width="220" align="center">
          <template v-slot="{ row }">
            <el-button type="primary" size="mini" icon="el-icon-edit" title="编辑" @click="itemEdit(row)" />
            <el-button type="danger" size="mini" icon="el-icon-delete" title="删除" @click="itemDelete(row)" />
          </template>
        </el-table-column>
      </el-table>
    </div>
    <cPagination
      :total="list.total"
      :page.sync="list.page"
      :size.sync="list.size"
      @change="listGet" />
    <com-dialog v-if="visible" :visible.sync="visible" @submit="listGet" :id.sync="id" />
  </div>
</template>

<script>
import ComDialog from './Dialog'
export default {
  components: {
    ComDialog
  },
  name: 'SystemMenu',
  data () {
    return {
      // 用于dropdown的循环和动态切换el-table-column的显示
      show: [],
      list: {
        total: 0,
        size: 10,
        page: 1,
        loading: false,
        data: [],
        filters: {
          search: '',
          status: '',
          sort: '',
          order: ''
        },
        selected: []
      },
      visible: false,
      id: ''
    }
  },
  computed: {
    deleteDisabled: function () {
      if (this.list.selected.length > 0) {
        return false
      } else {
        return true
      }
    }
  },
  methods: {
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetMenus',
        params: {
          status: this.list.filters.status,
          page: this.list.page,
          size: this.list.size,
          search: this.list.filters.search,
          sort: this.list.filters.sort,
          order: this.list.filters.order
        },
        requireAuth: true
      }).then(res => {
        this.list.total = res.data.total
        this.list.data = res.data.data
      }).catch(error => {
        this.$notify.error(error.message)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 设置动态显示el-table-column想
    setShow () {
      this.show = [
        { label: '角色名称', disabled: true, value: true },
        { label: '图标', disabled: true, value: true },
        { label: '组件路径', disabled: true, value: true },
        { label: '路由地址', disabled: true, value: true },
        { label: '显示顺序', disabled: false, value: false },
        { label: '是否外链', disabled: false, value: false },
        { label: '类型', disabled: false, value: false },
        { label: '状态', disabled: false, value: true },
        { label: '创建时间', disabled: false, value: true },
        { label: '修改时间', disabled: false, value: true },
        { label: '备注', disabled: false, value: false }
      ]
    },
    // 更新role
    updateRow (row) {
      this.$http({
        name: 'UpdateMenu',
        requireAuth: true,
        data: row
      }).then(res => {
        this.$notify.success(res.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.listGet()
      })
    },
    // 排序回调
    sortChange (row) {
      if (row.order) {
        this.list.filters.sort = row.prop
        this.list.filters.order = row.order.replace(/ending$/, '')
      } else {
        this.list.filters.sort = ''
        this.list.filters.order = ''
      }
      this.listGet()
    },
    // 选择回调
    selectChange (rows) {
      this.list.selected = rows.map(item => item.id)
    },
    // 编辑
    itemEdit (row) {
      this.id = row.id
      this.visible = true
    },
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteMenu',
          requireAuth: true,
          paths: [row.id]
        }).then(res => {
          this.$notify.success()
        }).catch(error => {
          this.$notify.error(error)
        }).finally(() => {
          this.listGet()
        })
      }).catch(() => {})
    },
    deleteSelected () {}
  },
  created () {
    this.setShow()
    this.listGet()
  },
  // 解决：el-table抖动问题
  beforeUpdate () {
    this.$nextTick(() => {
      // 在数据加载完，重新渲染表格
      this.$refs.table.doLayout()
    })
  }
}
</script>

<style>

</style>
