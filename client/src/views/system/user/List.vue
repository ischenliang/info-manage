<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" @input="listGet"/>
      <el-select v-model="list.filters.status" @change="listGet" clearable>
        <el-option :value="true" label="启用" />
        <el-option :value="false" label="禁用" />
      </el-select>
      <div style="flex: auto;"></div>
      <el-button
        type="primary"
        size="small"
        v-perms="'system:user:add'"
        @click="visible = true">
        新增
      </el-button>
      <c-json-excel :name="'GetUsers'" :fields="$fields.user" :filename="'user'" style="margin: 0 10px;" />
      <el-button
        type="danger"
        size="small"
        v-perms="'system:user:delete'"
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
        border
        size="medium"
        ref="table"
        v-loading="list.loading"
        @sort-change="sortChange"
        @selection-change="selectChange"
        :data="list.data">
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="show[0].value" prop="username" label="用户名称" width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[1].value" prop="avatar" label="用户头像" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-avatar :src="row.avatar" size="small"></el-avatar>
          </template>
        </el-table-column>
        <el-table-column v-if="show[2].value" prop="nickname" label="用户昵称" min-width="120" align="center" sortable="custom" />
        <el-table-column v-if="show[3].value" prop="status" label="状态" min-width="100" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-switch v-model="row.status" @change="updateRow(row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column v-if="show[4].value" prop="ur" label="用户角色" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">
            {{ formatRole(row.ur) }}
          </template>
        </el-table-column>
        <el-table-column v-if="show[5].value" prop="ctime" label="创建时间" min-width="160" align="center" sortable="custom" />
        <el-table-column v-if="show[6].value" prop="remark" label="备注" min-width="200" align="center" sortable="custom" />
        <el-table-column label="操作" width="220" align="center">
          <template v-slot="{ row }">
            <el-button
              type="success"
              size="mini"
              icon="el-icon-key"
              title="重置"
              v-perms="'system:user:update'"
              @click="resetPwd(row)" />
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              title="编辑"
              v-perms="'system:user:update'"
              @click="itemEdit(row)" />
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              title="删除"
              v-perms="'system:user:delete'"
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
import ComDialog from './Dialog'
export default {
  name: 'SystemUser',
  components: {
    ComDialog
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
        this.list.total = res.data.data.total
        this.list.data = res.data.data.data
      }).catch(error => {
        this.$notify.error(error)
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
    // 更新
    updateRow (row) {
      const role = []
      row.ur.forEach(item => role.push(item.id))
      this.$set(row, 'role', role)
      row.password = '' // 不更新密码
      this.$http({
        name: 'UpdateUser',
        requireAuth: true,
        data: row
      }).then(res => {
        this.listGet()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 重置
    resetPwd (row) {
      const role = []
      row.ur.forEach(item => role.push(item.id))
      this.$set(row, 'role', role)
      row.password = '111111'
      this.$http({
        name: 'UpdateUser',
        requireAuth: true,
        data: row
      }).then(res => {
        this.listGet()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
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
    // 格式化角色列表
    formatRole (roles) {
      const roleNames = []
      roles.forEach(item => {
        roleNames.push(item.name)
      })
      return roleNames.join('、')
    },
    // 修改
    itemEdit (row) {
      this.visible = true
      this.id = row.id
    },
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteUser',
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
            name: 'DeleteUser',
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
