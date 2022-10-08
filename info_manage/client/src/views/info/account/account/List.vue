<template>
  <div class="app-page" style="padding: 0;">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <el-select v-model="list.filters.type" clearable filterable @change="listGet">
        <el-option label="收入" :value="1" />
        <el-option label="支出" :value="0" />
      </el-select>
      <el-date-picker
        v-model="list.filters.start"
        type="datetime"
        placeholder="开始时间"
        format="yyyy-MM-dd HH:mm:ss"
        value-format="yyyy-MM-dd HH:mm:ss"
        @change="listGet" />
      <el-date-picker
        v-model="list.filters.end"
        type="datetime"
        placeholder="结束时间"
        format="yyyy-MM-dd HH:mm:ss"
        value-format="yyyy-MM-dd HH:mm:ss"
        @change="listGet" />
      <c-flex-auto />
      <el-button
        type="primary"
        size="medium"
        v-perms="'system:account:add'"
        @click="visible = true">
        新增
      </el-button>
      <el-button
        type="danger"
        size="medium"
        v-perms="'system:account:delete'"
        @click="deleteSelected"
        :disabled="deleteDisabled">
        删除
      </el-button>
      <cDropdown :show.sync="show" />
    </div>
    <div class="table">
      <!-- 注意： 如果给el-table设置了height="100%"，那么再使用show-summary是不显示的 -->
      <el-table
        style="width: 100%;"
        stripe
        ref="table"
        border
        show-summary
        size="medium"
        sum-text="总计"
        :summary-method="getSummaries"
        v-loading="list.loading"
        @sort-change="sortChange"
        @selection-change="selectChange"
        :data="list.data">
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="show[0].value" label="金额(元)" prop="money" min-width="100" align="center" sortable="custom">
          <template v-slot="{ row }">
            <span :style="{ color:  row.type === 0 ? '#FF5722' : '#369A04' }">{{ row.money }}</span>
          </template>
        </el-table-column>
        <el-table-column v-if="show[1].value" label="支付方式" prop="pay" min-width="110" align="center" sortable="custom"/>
        <el-table-column v-if="show[2].value" label="付款时间" prop="ptime" min-width="160" align="center" sortable="custom"/>
        <el-table-column v-if="show[3].value" label="标签" prop="tag" min-width="100" align="center" sortable="custom">
          <template v-slot="{ row }">
            <i :class="row.tag.icon" style="font-size: 20px;"></i>
            <span>{{ row.tag.name }}</span>
          </template>
        </el-table-column>
        <el-table-column v-if="show[4].value" label="位置" prop="location" min-width="150" align="center" sortable="custom">
          <template v-slot="{ row }">{{ row.location.city.join('') }}</template>
        </el-table-column>
        <el-table-column v-if="show[5].value" label="类别" prop="type" min-width="80" align="center" sortable="custom">
          <template v-slot="{ row }">
            <el-tag v-if="row.type === 1" type="success">收入</el-tag>
            <el-tag v-else type="danger">支出</el-tag>
          </template>
        </el-table-column>
        <el-table-column v-if="show[6].value" label="备注" prop="remark" min-width="150" align="center" sortable="custom" />
        <el-table-column v-if="show[7].value" label="创建时间" prop="ctime" min-width="160" align="center" sortable="custom" />
        <el-table-column v-if="show[8].value" label="修改时间" prop="mtime" min-width="160" align="center" sortable="custom" />
        <el-table-column label="操作" width="160" align="center">
          <template v-slot="{ row }">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-edit"
              title="编辑"
              v-perms="'system:account:update'"
              @click="itemEdit(row)" />
            <el-button
              type="danger"
              size="mini"
              icon="el-icon-delete"
              title="删除"
              v-perms="'system:account:delete'"
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
  name: 'InfoAccountList',
  components: {
    ComDialog
  },
  data () {
    return {
      show: [
        { label: '金额(元)', disabled: true, value: true },
        { label: '支付方式', disabled: true, value: true },
        { label: '付款时间', disabled: true, value: true },
        { label: '标签', disabled: false, value: true },
        { label: '位置', disabled: false, value: true },
        { label: '类别', disabled: false, value: true },
        { label: '备注', disabled: false, value: false },
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
          type: '',
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
        name: 'GetAccounts',
        requireAuth: true,
        params: {
          page: this.list.page,
          size: this.list.size,
          search: this.list.filters.search,
          sort: this.list.filters.sort,
          order: this.list.filters.order,
          type: this.list.filters.type,
          start: this.list.filters.start,
          end: this.list.filters.end
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
          name: 'DeleteAccount',
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
            name: 'DeleteAccount',
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
    // 获取总价
    getSummaries (param) {
      // columns: 表头
      // data：单元格数据
      const { columns, data } = param
      const sums = []
      columns.forEach((column, index) => {
        if (index === 0) {
          sums[index] = '总价'
          return
        }
        const values = data.map(item => {
          if (item.type === 0 && column.property === 'money') {
            return -Number(item[column.property])
          } else if (column.property === 'type') {
            return Number('哈哈哈哈')
          } else {
            return Number(item[column.property])
          }
        })
        if (!values.every(value => isNaN(value))) {
          sums[index] = values.reduce((prev, curr) => {
            if (!isNaN(parseFloat(curr))) {
              // 排除出现很多小数点，如：200 - 4.5 - 20.18 - 20.18 - 4.53 = 150.60999999999999
              return (Number(prev) + Number(curr)).toFixed(2)
            } else {
              return prev
            }
          }, 0)
          sums[index] += ' 元'
        } else {
          sums[index] = 'N/A'
        }
      })
      return sums
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
