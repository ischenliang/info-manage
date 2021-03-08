<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <el-date-picker v-model="list.filters.start" type="datetime" placeholder="开始时间" format="yyyy-MM-dd HH:mm:ss" @change="timeFormat('start')" />
      <el-date-picker v-model="list.filters.end" type="datetime" placeholder="结束时间" format="yyyy-MM-dd HH:mm:ss" @change="timeFormat('end')" />
      <c-flex-auto />
      <el-button
        type="primary"
        size="medium"
        v-perms="'system:user:add'"
        @click="$router.push({ path: '/info/memory/add' })">
        新增
      </el-button>
      <el-button
        type="danger"
        size="medium"
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
        v-loading="list.loading"
        @sort-change="sortChange"
        @selection-change="selectChange"
        :data="list.data">
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="show[0].value" label="名称" prop="name" min-width="100" align="center" sortable="custom"/>
        <el-table-column v-if="show[1].value" label="标签" prop="tag" min-width="150" align="center" sortable="custom"/>
        <el-table-column v-if="show[2].value" label="内容" prop="content" min-width="200" align="center" sortable="custom">
          <template v-slot="{ row }">
            <div class="over-ellipsis" style="max-height: 42px;line-clamp: 2;">{{ row.content }}</div>
          </template>
        </el-table-column>
        <el-table-column v-if="show[3].value" label="创建时间" prop="ctime" min-width="160" align="center" sortable="custom" />
        <el-table-column v-if="show[4].value" label="修改时间" prop="mtime" min-width="160" align="center" sortable="custom" />
        <el-table-column label="操作" width="220" align="center">
          <template v-slot="{ row }">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              title="编辑"
              @click="itemEdit(row)" />
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              title="删除"
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
    <!-- <com-dialog v-if="visible" :visible.sync="visible" @submit="listGet" :id.sync="id" /> -->
  </div>
</template>

<script>
export default {
  data () {
    return {
      show: [
        { label: '名称', disabled: true, value: true },
        { label: '标签', disabled: true, value: true },
        { label: '内容', disabled: true, value: true },
        { label: '创建时间', disabled: false, value: false },
        { label: '修改时间', disabled: false, value: true }
      ],
      list: {
        page: 1,
        size: 10,
        total: 0,
        loading: false,
        filters: {
          search: '',
          sort: '',
          order: '',
          start: '',
          end: ''
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
        name: 'GetMemories',
        requireAuth: true,
        params: {
          page: this.list.page,
          size: this.list.size,
          search: this.list.filters.search,
          sort: this.list.filters.sort,
          order: this.list.filters.order,
          start: this.list.filters.start,
          end: this.list.filters.end
        }
      }).then(res => {
        this.list.total = res.data.total
        this.list.data = res.data.data
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
          name: 'DeleteMenu',
          requireAuth: true,
          paths: [row.id]
        }).then(res => {
          this.$notify.success(res.msg)
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
            name: 'DeleteMenu',
            requireAuth: true,
            paths: [item]
          }).then(res => {
            if (index === this.list.selected.length - 1) {
              this.$notify.success(res.msg)
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
    // 时间格式化
    timeFormat (type) {
      if (this.list.filters[type]) {
        this.list.filters[type] = this.$moment(this.list.filters[type]).format('yyyy-MM-DD HH:mm:ss')
      } else {
        this.list.filters[type] = ''
      }
      this.listGet()
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
