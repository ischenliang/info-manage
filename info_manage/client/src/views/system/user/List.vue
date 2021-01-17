<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" @input="listGet"></el-input>
      <el-select v-model="list.filters.status" @change="listGet" clearable>
        <el-option :value="true" label="启用" />
        <el-option :value="false" label="禁用" />
      </el-select>
      <div style="flex: auto;"></div>
      <el-button type="primary" size="medium">新增</el-button>
      <el-button type="warning" size="medium">导出</el-button>
      <el-button type="danger" size="medium">删除</el-button>
      <!-- 考虑做成组件 -->
      <cDropdown :show.sync="show" />
    </div>
    <div class="table">
      <el-table
        style="width: 100%;"
        height="100%"
        stripe
        border
        ref="table"
        v-loading="list.loading"
        @sort-change="sortChange"
        :data="list.data">
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="show[0].value" prop="username" label="用户名称" width="200" align="center" sortable="custom" />
        <el-table-column v-if="show[1].value" prop="avatar" label="用户头像" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-avatar :src="row.avatar" size="medium"></el-avatar>
          </template>
        </el-table-column>
        <el-table-column v-if="show[2].value" prop="nickname" label="用户昵称" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[3].value" prop="status" label="状态" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-switch v-model="row.status" @change="updateRow(row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column v-if="show[4].value" prop="ur" label="用户角色" min-width="170" align="center" sortable="custom">
          <template v-slot="{ row }">
            {{ formatRole(row.ur) }}
          </template>
        </el-table-column>
        <el-table-column v-if="show[5].value" prop="ctime" label="创建时间" min-width="170" align="center" sortable="custom" />
        <el-table-column v-if="show[6].value" prop="remark" label="备注" min-width="200" align="center" sortable="custom" />
        <el-table-column label="操作" width="220" align="center">
          <template>
            <el-button type="primary" size="mini" icon="el-icon-edit" title="编辑" />
            <el-button type="danger" size="mini" icon="el-icon-delete" title="删除" />
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
  name: 'SystemUser',
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
        }
      }
    }
  },
  methods: {
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetUsers',
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
        this.$notify({
          title: '错误',
          message: error,
          type: 'error',
          duration: 1000,
          position: 'top-right'
        })
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 设置动态显示el-table-column想
    setShow () {
      this.show = [
        { label: '用户名称', disabled: true, value: true },
        { label: '用户头像', disabled: true, value: true },
        { label: '用户昵称', disabled: true, value: true },
        { label: '用户状态', disabled: true, value: true },
        { label: '用户角色', disabled: false, value: true },
        { label: '创建时间', disabled: false, value: true },
        { label: '用户备注', disabled: false, value: false }
      ]
    },
    // 更新role
    updateRow (row) {
      this.$http({
        name: 'UpdateRole',
        requireAuth: true,
        data: row
      }).then(res => {
        this.listGet()
        this.$notify({
          title: '成功',
          message: '更新成功',
          type: 'success',
          duration: 1000,
          position: 'top-right'
        })
      }).catch(error => {
        this.$notify({
          title: '错误',
          message: error,
          type: 'error',
          duration: 1000,
          position: 'top-right'
        })
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
    formatRole (roles) {
      const roleNames = []
      roles.forEach(item => {
        roleNames.push(item.name)
      })
      return roleNames.join('、')
    }
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
