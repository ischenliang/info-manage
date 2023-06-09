<template>
  <div class="app-page" style="padding: 0;">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <el-select v-model="list.filters.tid" clearable filterable @change="handleChange">
        <el-option v-for="(item, index) in list.types" :key="index" :label="item.name" :value="item.id" />
      </el-select>
      <c-flex-auto />
      <el-button type="info" @click="toggle" size="small">看板模式</el-button>
      <el-button
        type="primary"
        size="small"
        v-perms="'system:collect:add'"
        @click="visible = true">
        新增
      </el-button>
      <el-button
        type="danger"
        size="medium"
        v-perms="'system:collect:delete'"
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
        <el-table-column v-if="show[0].value" label="logo" prop="repository" width="100" align="center">
          <template slot-scope="scope">
            <el-image
              :src="scope.row.repository"
              fit="fill"
              style="width: 30px; height: 30px"></el-image>
          </template>
        </el-table-column>
        <el-table-column v-if="show[0].value" label="名称" prop="name" min-width="120" align="center" sortable="custom">
          <template slot-scope="scope">
            <a :href="scope.row.url" target="_blank" style="color: blue;">{{ scope.row.name }}</a>
          </template>
        </el-table-column>
        <el-table-column v-if="show[2].value" label="图标" prop="logo" min-width="100" align="center" sortable="custom">
          <template v-slot="{ row }">
            <img :src="row.logo" alt="">
          </template>
        </el-table-column>
        <el-table-column v-if="show[3].value" label="类别" prop="collect_type" min-width="150" align="center" sortable="custom">
          <template v-slot="{ row }">{{ row.collect_type.name }}</template>
        </el-table-column>
        <el-table-column v-if="show[5].value" label="标签" prop="tag" min-width="100" align="center" sortable="custom"/>
        <el-table-column v-if="show[6].value" label="备注" prop="remark" min-width="200" align="center" sortable="custom"/>
        <el-table-column v-if="show[7].value" label="创建时间" prop="ctime" min-width="160" align="center" sortable="custom"/>
        <el-table-column v-if="show[8].value" label="更新时间" prop="mtime" min-width="160" align="center" sortable="custom"/>
        <el-table-column label="操作" width="220" align="center">
          <template v-slot="{ row }">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              title="编辑"
              v-perms="'system:collect:update'"
              @click="itemEdit(row)" />
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              title="删除"
              v-perms="'system:collect:delete'"
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
  name: 'CollectTable',
  components: {
    ComDialog
  },
  props: {
    showTable: Boolean,
    filter: Object
  },
  data () {
    return {
      show: [
        { label: '名称', disabled: true, value: true },
        { label: '地址', disabled: true, value: true },
        { label: '图标', disabled: false, value: false },
        { label: '类别', disabled: false, value: true },
        { label: '仓库', disabled: false, value: true },
        { label: '标签', disabled: false, value: true },
        { label: '备注', disabled: false, value: true },
        { label: '创建时间', disabled: false, value: false },
        { label: '更新时间', disabled: false, value: true }
      ],
      list: {
        page: 1,
        size: 10,
        total: 0,
        loading: false,
        filters: {
          search: '',
          tid: '',
          sort: '',
          order: ''
        },
        types: [],
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
    handleChange (e) {
      this.listGet()
      this.$emit('update:filter', this.list.types.find(el => el.id === e))
    },
    toggle () {
      this.$emit('update:showTable', !this.showTable)
    },
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetCollects',
        requireAuth: true,
        params: {
          page: this.list.page,
          size: this.list.size,
          search: this.list.filters.search,
          sort: this.list.filters.sort,
          order: this.list.filters.order,
          tid: this.list.filters.tid
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
    getTypes () {
      this.$http({
        name: 'GetCollectTypes',
        requireAuth: true,
        params: {
          page: 1,
          size: 10000,
          status: true
        }
      }).then(res => {
        this.list.types = res.data.data.data
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
    // 更新
    updateRow (row) {
      this.$http({
        name: 'UpdateCollectType',
        requireAuth: true,
        data: row
      }).then(res => {
        this.listGet()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      })
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
          name: 'DeleteCollect',
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
            name: 'DeleteCollect',
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
    setLink (row, index) {
      const tmp = { type: 'default', url: row.url, repository: row.repository }
      switch (index % 6) {
        case 0:
          tmp.type = 'default'
          break
        case 1:
          tmp.type = 'primary'
          break
        case 2:
          tmp.type = 'success'
          break
        case 3:
          tmp.type = 'warning'
          break
        case 4:
          tmp.type = 'danger'
          break
        case 5:
          tmp.type = 'info'
          break
      }
      return tmp
    }
  },
  created () {
    if (this.filter) {
      this.list.filters.tid = this.filter.id
    }
    this.getTypes()
    this.listGet()
  },
  // 解决：el-table抖动问题
  beforeUpdate () {
    this.$nextTick(() => {
      // 在数据加载完，重新渲染表格
      this.$refs.table.doLayout()
    })
  },
  activated () {
    this.listGet()
  }
}
</script>

<style>

</style>
