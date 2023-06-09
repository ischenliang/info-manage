<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" @input="listGet" suffix-icon="el-icon-search"/>
      <el-select v-model="list.filters.status" @change="listGet" clearable>
        <el-option :value="true" label="启用" />
        <el-option :value="false" label="禁用" />
      </el-select>
      <div style="flex: auto;"></div>
      <el-button
        type="primary"
        size="small"
        v-perms="'system:menu:add'"
        @click="visible = true">
        新增
      </el-button>
      <el-button type="warning" size="small">导出</el-button>
      <el-button
        type="danger"
        size="small"
        v-perms="'system:menu:delete'"
        @click="deleteSelected"
        :disabled="deleteDisabled">
        删除
      </el-button>
      <!-- 考虑做成组件 -->
      <cDropdown :show.sync="show" />
    </div>
    <div class="table">
      <el-table
        style="width: 100%;"
        height="100%"
        stripe
        ref="table"
        size="medium"
        v-loading="list.loading"
        @sort-change="sortChange"
        row-key="id"
        :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
        @selection-change="selectChange"
        :data="list.data">
        <!-- 不好做:选择时将子代数据全选操作 -->
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="show[0].value" prop="name" label="菜单名称" width="200" align="left" sortable="custom" :show-overflow-tooltip="true" />
        <el-table-column v-if="show[1].value" prop="icon" label="图标" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            <i :class="row.icon" style="font-size: 22px;"></i>
          </template>
        </el-table-column>
        <el-table-column v-if="show[2].value" prop="component" label="菜单组件" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[3].value" prop="path" label="路由地址" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[4].value" prop="order" label="显示顺序" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[5].value" prop="is_frame" label="是否外链" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-switch v-model="row.is_frame" @change="updateRow(row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column v-if="show[6].value" prop="type" label="类型" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-tag type="default" v-if="row.type === 1">目录</el-tag>
            <el-tag type="success" v-if="row.type === 2">菜单</el-tag>
          </template>
        </el-table-column>
        <el-table-column v-if="show[7].value" prop="status" label="状态" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-switch v-model="row.status" @change="updateRow(row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column v-if="show[8].value" prop="ctime" label="创建时间" min-width="160" align="center" sortable="custom" />
        <el-table-column v-if="show[9].value" prop="mtime" label="修改时间" min-width="160" align="center" sortable="custom" />
        <el-table-column v-if="show[10].value" prop="remark" label="备注" min-width="200" align="center" sortable="custom" />
        <el-table-column label="操作" width="220" align="center">
          <template v-slot="{ row }">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              title="编辑"
              v-perms="'system:menu:update'"
              @click="itemEdit(row)" />
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              title="删除"
              v-perms="'system:menu:delete'"
              @click="itemDelete(row)" />
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
import { mapActions } from 'vuex'
import { parseRoutes, routes, resetRouter } from '@/router/index.js'
import ComDialog from './Dialog'
export default {
  name: 'SystemMenu',
  components: {
    ComDialog
  },
  data () {
    return {
      // 用于dropdown的循环和动态切换el-table-column的显示
      show: [
        { label: '菜单名称', disabled: true, value: true },
        { label: '图标', disabled: true, value: true },
        { label: '组件路径', disabled: true, value: true },
        { label: '路由地址', disabled: true, value: true },
        { label: '显示顺序', disabled: false, value: false },
        { label: '是否外链', disabled: false, value: false },
        { label: '类型', disabled: false, value: true },
        { label: '状态', disabled: false, value: true },
        { label: '创建时间', disabled: false, value: true },
        { label: '修改时间', disabled: false, value: false },
        { label: '备注', disabled: false, value: false }
      ],
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
    ...mapActions({
      setUser: 'user/SET_MENUS'
    }),
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
        this.list.total = res.data.data.total
        this.list.data = res.data.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 更新role
    updateRow (row) {
      this.$http({
        name: 'UpdateMenu',
        requireAuth: true,
        data: row
      }).then(res => {
        this.$notify.success(res.data.msg)
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
        }).then(async res => {
          this.$notify.success(res.data.msg)
          // 重置路由并更新路由
          resetRouter()
          const dynamicRoutes = await this.setUser(routes) // 注意：要将静态路由拼接到menus中
          const routelist = parseRoutes(dynamicRoutes)
          routelist.push({ path: '*', redirect: '/404' })
          this.$router.addRoutes(routes.concat(...routelist))
        }).catch(error => {
          this.$notify.error(error)
        }).finally(() => {
          this.listGet()
        })
      }).catch(() => {})
    },
    // 删除已选
    deleteSelected () {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.list.selected.forEach((item, index) => {
          this.$http({
            name: 'DeleteMenu',
            requireAuth: true,
            paths: [item]
          }).then(async res => {
            if (index === this.list.selected.length - 1) {
              this.$notify.success(res.data.msg)
              this.list.selected = []
              // 重置路由并更新路由
              resetRouter()
              const dynamicRoutes = await this.setUser(routes) // 注意：要将静态路由拼接到menus中
              const routelist = parseRoutes(dynamicRoutes)
              routelist.push({ path: '*', redirect: '/404' })
              this.$router.addRoutes(routes.concat(...routelist))
            }
          }).catch(error => {
            this.$notify.error(error)
          }).finally(() => {
            this.listGet()
          })
        })
      }).catch(() => {})
    }
  },
  created () {
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

<style lang="scss">
</style>
