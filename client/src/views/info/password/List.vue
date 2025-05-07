<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <c-flex-auto />
      <el-button
        type="primary"
        size="small"
        v-perms="'system:password:add'"
        @click="visible = true">
        新增
      </el-button>
      <el-button
        type="danger"
        size="small"
        v-perms="'system:password:delete'"
        @click="deleteSelected"
        :disabled="deleteDisabled">
        删除
      </el-button>
    </div>
    <div class="table" v-loading="list.loading">
      <el-row>
        <el-col
          v-for="(item, index) in list.data"
          :xl="6"
          :lg="8"
          :md="12"
          :key="item.id">
          <password-item :item="item">
            <div
              class="password-action-item"
              v-perms="'system:password:update'"
              @click="itemEdit(item)">编辑</div>
            <div
              class="password-action-item"
              v-perms="'system:password:delete'"
              @click="itemDelete(item)">删除</div>
          </password-item>
        </el-col>
      </el-row>
    </div>
    <cPagination
      :total="list.total"
      :page.sync="list.page"
      :size.sync="list.size"
      :sizes="[12, 24, 36, 100]"
      @change="listGet" />
    <com-dialog v-if="visible" :visible.sync="visible" @submit="listGet" :id.sync="id" />
  </div>
</template>

<script>
import ComDialog from './Dialog'
import PasswordItem from './password-item.vue'
export default {
  name: 'PasswordList',
  components: {
    ComDialog,
    PasswordItem
  },
  data () {
    return {
      list: {
        page: 1,
        size: 12,
        total: 0,
        loading: false,
        filters: {
          search: '',
          sort: '',
          order: ''
        },
        selected: []
      },
      id: '',
      visible: false
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
        name: 'GetPasswords',
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
    // 更改
    itemEdit (row) {
      this.id = row.id
      this.visible = true
    },
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeletePassword',
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
            name: 'DeletePassword',
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
  }
}
</script>

<style lang="scss">
.el-table {
  .cell {
    word-break: normal;
  }
}
.el-row {
  padding: 10px 5px;
  .el-col {
    padding: 10px 12px 12px;
  }
}
</style>
