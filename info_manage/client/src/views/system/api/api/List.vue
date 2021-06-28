<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <el-select v-model="list.filters.type" clearable filterable @change="listGet">
        <el-option v-for="(item, index) in list.types" :key="index" :label="item.label" :value="item.value" />
      </el-select>
      <el-select v-model="list.filters.tid" clearable filterable @change="listGet">
        <el-option v-for="(item, index) in list.apiTypes" :key="index" :label="item.name" :value="item.id" />
      </el-select>
      <div style="flex: auto;"></div>
      <el-button
        type="primary"
        size="medium"
        v-perms="'system:api:add'"
        @click="visible = true">
        新增
      </el-button>
      <c-json-excel :name="'GetApis'" :fields="$fields.api" :filename="'api'" style="margin: 0 10px;" />
      <el-button
        type="danger"
        size="medium"
        v-perms="'system:api:delete'"
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
        <el-table-column v-if="show[0].value" label="名称" prop="name" min-width="120" align="center" sortable="custom"/>
        <el-table-column
          v-if="show[1].value"
          label="备注"
          prop="remark"
          min-width="250"
          align="center"
          sortable="custom"
          :show-overflow-tooltip="true">
          <template v-slot="{ row }">{{ row.remark | valueEmpty }}</template>
        </el-table-column>
        <el-table-column v-if="show[2].value" label="地址" prop="path" min-width="160" align="center" sortable="custom"/>
        <el-table-column v-if="show[3].value" label="权限标识" prop="perms" min-width="150" align="center" sortable="custom"/>
        <el-table-column v-if="show[4].value" label="所属模块" prop="tid" min-width="120" align="center" sortable="custom">
          <template v-slot="{ row }">{{ row.api_type.name }}</template>
        </el-table-column>
        <el-table-column v-if="show[5].value" label="类型" prop="type" min-width="100" align="center" sortable="custom">
          <template v-slot="{ row }">
             <el-tag :type="row.type | typeFormat" effect="dark" size="medium" style="width: 68px;">{{ row.type }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column v-if="show[6].value" label="创建时间" prop="ctime" min-width="160" align="center" sortable="custom"/>
        <el-table-column v-if="show[7].value" label="修改时间" prop="mtime" min-width="160" align="center" sortable="custom"/>
        <el-table-column label="操作" width="220" align="center">
          <template v-slot="{ row }">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              title="编辑"
              v-perms="'system:api:update'"
              @click="itemEdit(row)" />
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              title="删除"
              v-perms="'system:api:delete'"
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
  name: 'SystemApiList',
  components: {
    ComDialog
  },
  data () {
    return {
      show: [
        { label: '名称', disabled: true, value: true },
        { label: '备注', disabled: false, value: false },
        { label: '地址', disabled: true, value: true },
        { label: '权限标识', disabled: false, value: true },
        { label: '类别', disabled: true, value: true },
        { label: '类型', disabled: true, value: true },
        { label: '创建时间', disabled: false, value: true },
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
          order: '',
          type: '',
          tid: ''
        },
        selected: [],
        types: [
          { label: 'GET', value: 'GET' },
          { label: 'POST', value: 'POST' },
          { label: 'PUT', value: 'PUT' },
          { label: 'DELETE', value: 'DELETE' }
        ],
        apiTypes: []
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
  filters: {
    typeFormat: function (data) {
      switch (data) {
        case 'GET':
          return 'primary'
        case 'POST':
          return 'success'
        case 'PUT':
          return 'warning'
        case 'DELETE':
          return 'danger'
      }
    }
  },
  methods: {
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetApis',
        requireAuth: true,
        params: {
          page: this.list.page,
          size: this.list.size,
          search: this.list.filters.search,
          sort: this.list.filters.sort,
          order: this.list.filters.order,
          type: this.list.filters.type,
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
    getApis () {
      this.$http({
        name: 'GetApiTypes',
        requireAuth: true,
        params: {
          page: 1,
          size: 10000
        }
      }).then(res => {
        this.list.apiTypes = res.data.data.data
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
    // 更改
    itemEdit (row) {
      this.id = row.id
      this.visible = true
    },
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteApi',
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
            name: 'DeleteApi',
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
    this.getApis()
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
