<template>
  <div class="app-page">
    <div class="table">
      <el-table
        style="width: 100%;"
        height="100%"
        border
        stripe
        ref="table"
        size="medium"
        v-loading="list.loading"
        @sort-change="sortChange"
        @selection-change="selectChange"
        :data="list.data">
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="show[0].value" prop="name" label="操作用户" width="200" align="center" sortable="custom" />
        <el-table-column v-if="show[1].value" prop="content" label="操作信息" min-width="200" align="center" sortable="custom" />
        <el-table-column v-if="show[2].value" prop="type" label="操作类型" width="200" align="center" sortable="custom" />
        <el-table-column v-if="show[3].value" prop="address" label="操作来源" width="200" align="center" sortable="custom" />
        <el-table-column v-if="show[4].value" prop="ip" label="访问ip" width="200" align="center" sortable="custom" />
        <el-table-column v-if="show[5].value" prop="ctime" label="操作时间" width="160" align="center" sortable="custom" />
        <el-table-column label="操作" width="220" align="center">
          <template v-slot="{ row }">
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              title="删除"
              v-perms="'system:log:delete'"
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
  name: 'SystemLog',
  computed: {
    deleteDisabled: function () {
      if (this.list.selected.length > 0) {
        return false
      } else {
        return true
      }
    }
  },
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
          sort: '',
          order: ''
        },
        selected: []
      }
    }
  },
  methods: {
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetLogs',
        params: {
          page: this.list.page,
          size: this.list.size,
          sort: this.list.filters.sort,
          order: this.list.filters.order
        },
        requireAuth: true
      }).then(res => {
        this.list.total = res.data.data.total
        this.list.data = res.data.data.data?.map(el => {
          el.address = el.client_info?.province + el.client_info?.city
          el.ip = el.client_info?.ip
          return el
        })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 设置动态显示el-table-column想
    setShow () {
      this.show = [
        { label: '操作用户', disabled: true, value: true },
        { label: '操作信息', disabled: true, value: true },
        { label: '操作类型', disabled: false, value: true },
        { label: '操作来源', disabled: false, value: true },
        { label: '访问ip', disabled: false, value: false },
        { label: '操作时间', disabled: false, value: true }
      ]
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
          name: 'DeleteLog',
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
    deleteSelected () {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.list.selected.forEach((item, index) => {
          this.$http({
            name: 'DeleteLog',
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
    },
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
