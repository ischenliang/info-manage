<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
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
        size="small"
        v-perms="'system:memory:add'"
        @click="$router.push({ path: '/info/memory/add' })">
        新增
      </el-button>
      <el-button
        type="danger"
        size="small"
        v-perms="'system:memory:delete'"
        @click="deleteSelected"
        :disabled="deleteDisabled">
        删除
      </el-button>
    </div>
    <div
      class="table v-scrollbar"
      :key="key"
      v-loading="list.loading"
      style="padding-left: 5px;padding-right: 5px;">
      <memory-item v-for="(item, index) in list.data" :key="index" :item="item">
        <template #select>
          <memory-check
            :checked="item.checked"
            @click.native.stop="handleClick(item)">
          </memory-check>
        </template>
        <el-button
          type="text"
          size="mini"
          v-perms="'system:memory:update'"
          @click.stop="itemEdit(item)">
          编辑
        </el-button>
        <el-button
          type="text"
          size="mini"
          v-perms="'system:memory:delete'"
          @click.stop="itemDelete(item)">
          删除
        </el-button>
      </memory-item>
    </div>
    <cPagination
      :total="list.total"
      :page.sync="list.page"
      :size.sync="list.size"
      @change="listGet" />
  </div>
</template>

<script>
import memoryItem from './memory-item.vue'
import memoryCheck from './memory-check.vue'
export default {
  name: 'MemoryList',
  components: {
    memoryItem,
    memoryCheck
  },
  data () {
    return {
      list: {
        page: 1,
        size: 10,
        total: 0,
        loading: false,
        filters: {
          search: '',
          sort: 'mtime',
          order: 'desc',
          start: '',
          end: ''
        },
        selected: []
      },
      key: 0
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
        this.list.total = res.data.data.total
        this.list.data = res.data.data.data.map(el => {
          this.$set(el, 'checked', false)
          return el
        })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 更改
    itemEdit (row) {
      this.$router.push({ path: `/info/memory/edit/${row.id}` })
    },
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteMemory',
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
            name: 'DeleteMemory',
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
    // 点击
    handleClick (item) {
      item.checked = !item.checked
      this.list.selected = this.list.data.filter(item => {
        return item.checked === true
      })
      this.key++
    }
  },
  created () {
    this.listGet()
  },
  // 解决：el-table抖动问题
  beforeUpdate () {
    this.$nextTick(() => {
      // 在数据加载完，重新渲染表格
      // this.$refs.table.doLayout()
    })
  },
  watch: {
    $route (to, from) {
    }
  }
}
</script>

<style>

</style>
