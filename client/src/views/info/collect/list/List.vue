<template>
  <!-- <com-table v-if="showTable" :showTable.sync="showTable" :filter.sync="filter" />
  <com-panel v-else :showTable.sync="showTable" :filter.sync="filter" /> -->
  <div class="app-page collect-list">
    <aside class="collect-list-left">
      <div class="collect-list-types v-scrollbar">
        <div
          v-for="(item, index) in list.types"
          :key="'type-' + index"
          :class="['list-types-item', { active: list.filters.tid === item.id }]"
          :title="item.name"
          @click="handleClick(item)">
          <span>
            <i class="el-icon-collection"></i>
            ({{ item.collects.length }}){{ item.name }}
          </span>
          <div class="add-btn" @click.stop="addItem(item)">新增</div>
        </div>
      </div>
    </aside>
    <div class="collect-list-right v-scrollbar" v-loading="list.loading">
      <el-row class="collect-list-filter">
        <el-col :xl="12" :lg="18" :md="20" :xs="20" :sm="20">
          <el-input placeholder="请输入搜索内容..." v-model="list.filters.search" clearable class="filter-input" @clear="listGet">
            <el-button
              slot="append"
              icon="el-icon-search"
              type="primary"
              @click="listGet">搜索</el-button>
          </el-input>
        </el-col>
      </el-row>
      <el-row>
        <el-col
          v-for="(item, index) in list.data"
          :key="'collect-' + index"
          :xl="8"
          :lg="12">
          <collect-item :item="item">
            <div
              class="collect-action-item"
              v-perms="'system:collect:update'"
              @click="itemEdit(item)">编辑</div>
            <div
              class="collect-action-item"
              v-perms="'system:collect:delete'"
              @click="itemDelete(item)">删除</div>
          </collect-item>
        </el-col>
      </el-row>
    </div>
    <com-dialog v-if="visible" :visible.sync="visible" @submit="listGet" :id.sync="id" :tid="tid" />
  </div>
</template>

<script>
import ComDialog from './Dialog'
import CollectItem from './collect-item.vue'
export default {
  name: 'Collects',
  components: {
    ComDialog,
    CollectItem
  },
  props: {
    showTable: Boolean,
    filter: Object
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
          tid: '',
          sort: 'logo',
          order: 'asc'
        },
        types: [],
        selected: []
      },
      id: '',
      visible: false,
      tid: ''
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
    // 新增
    addItem (item) {
      this.tid = item.id
      this.visible = true
    },
    handleClick (item) {
      this.list.filters.tid = item.id
      this.listGet()
    },
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetCollects',
        requireAuth: true,
        params: {
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
        const collects = res.data.data.data.reduce((total, current, index, arr) => {
          total = [...total, ...current.collects]
          return total
        }, [])
        this.list.types = [{ id: '', name: '全部', collects: collects }, ...res.data.data.data]

      }).catch(error => {
        this.$notify.error(error)
      })
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
      // this.$refs.table.doLayout()
    })
  },
  activated () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.collect-list {
  display: flex;
  flex-direction: row !important;
  // border: 1px solid #EBEFF4;
  .collect-list-left {
    width: 220px;
    border-right: 1px solid #EBEFF4;
    height: 100%;
    padding: 1px;
    flex-shrink: 0;
    .collect-list-types {
      width: 100%;
      height: 100%;
      display: flex;
      flex-direction: column;
      .list-types-item {
        height: 56px;
        flex-shrink: 0;
        padding: 0 8px 0 20px;
        cursor: pointer;
        font-size: 14px;
        color: #303133;
        display: flex;
        justify-content: space-between;
        align-items: center;
        > span {
          text-overflow: ellipsis;
          overflow: hidden;
          white-space: nowrap;
          cursor: pointer;
          i {
            margin-right: 5px;
            width: 24px;
            text-align: center;
            font-size: 18px;
            vertical-align: middle;
          }
        }
        .add-btn {
          padding: 3px 4px;
          border-radius: 4px;
          font-size: 12px;
          flex-shrink: 0;
          background: #409eff;
          color: #fff;
          display: none;
          margin-left: 3px;
        }
        &.active {
          background-color: #ecf5ff;
          color: #409EFF;
        }
        &:hover {
          background: #ecf5ff;
          .add-btn {
            display: block;
          }
        }
      }
    }
  }
  .collect-list-right {
    flex: 1;
    height: 100%;
    padding: 20px 20px;
    overflow: auto;
    .el-col {
      padding: 10px 15px 40px;
    }
    .collect-list-filter {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 40px;
      .el-col {
        padding: 0;
        .filter-input {
          .el-input__inner {
            border: 1px solid #409eff !important;
          }
          .el-button {
            background: #409eff;
            border: 1px solid #409eff;
            color: #fff;
            border-radius: 0 4px 4px 0 !important;
          }
        }
      }
    }
  }
}
</style>
