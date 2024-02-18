<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <c-flex-auto />
      <el-button
        type="primary"
        size="small"
        v-perms="'system:dash:add'"
        @click="$router.push({ path: '/system/dash/layout/add' })">
        新增
      </el-button>
      <el-button
        type="danger"
        size="small"
        v-perms="'system:dash:delete'"
        @click="deleteSelected"
        :disabled="deleteDisabled">
        删除
      </el-button>
      <cDropdown :show.sync="show" />
    </div>
    <div class="table">
      <el-table
        style="width: 100%;"
        height="100%"
        stripe
        ref="table"
        border
        size="medium"
        v-loading="list.loading"
        @sort-change="sortChange"
        @selection-change="selectChange"
        :data="list.data">
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="show[0].value" label="名称" prop="name" min-width="150" align="center" sortable="custom"/>
        <el-table-column v-if="show[1].value" label="唯一标识" prop="identify" min-width="150" align="center" sortable="custom"/>
        <el-table-column v-if="show[2].value" label="描述" prop="description" min-width="200" align="center" sortable="custom"/>
        <el-table-column v-if="show[3].value" label="创建时间" prop="ctime" width="160" align="center" sortable="custom"/>
        <el-table-column v-if="show[4].value" label="修改时间" prop="mtime" width="160" align="center" sortable="custom"/>
        <el-table-column label="操作" width="220" align="center">
          <template v-slot="{ row }">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-view"
              title="查看"
              v-perms="'system:dash:detail'"
              @click="$router.push({ path: `/system/dash/layout/${row.id}` })" />
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              title="编辑"
              v-perms="'system:dash:update'"
              @click="$router.push({ path: `/system/dash/layout/${row.id}` })" />
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              title="删除"
              v-perms="'system:dash:delete'"
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
  </div>
</template>

<script>
export default {
  name: 'SystemDashList',
  data () {
    return {
      show: [
        { label: '名称', disabled: true, value: true },
        { label: '唯一标识', disabled: true, value: true },
        { label: '描述', disabled: true, value: true },
        { label: '创建时间', disabled: false, value: false },
        { label: '修改时间', disabled: false, value: false }
      ],
      list: {
        page: 1,
        size: 10,
        total: 0,
        loading: false,
        filters: {
          search: '',
          sort: '',
          order: ''
        },
        selected: []
      }
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
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetDashs',
        requireAuth: true,
        params: {
          page: this.list.page,
          size: this.list.size,
          search: this.list.filters.search,
          sort: this.list.filters.sort,
          order: this.list.filters.order
        }
      }).then(res => {
        this.list.total = res.data.data.total
        this.list.data = res.data.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
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
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteDash',
          requireAuth: true,
          paths: [row.id]
        }).then(res => {
          this.$notify.success(res.data.msg)
        }).catch(error => {
          this.$notify.error(error)
        }).finally(() => {
          this.listGet()
        })
      }).catch(() => {})
    },
    // 批量删除
    deleteSelected () {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.list.selected.forEach((item, index) => {
          this.$http({
            name: 'DeleteDash',
            requireAuth: true,
            paths: [item]
          }).then(res => {
            if (index === this.list.selected.length - 1) {
              this.$notify.success(res.data.msg)
              this.list.selected = []
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

<style>

</style>
