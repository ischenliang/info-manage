<template>
  <div class="app-page issues">
    <div class="toolbar">
      <el-input v-model="list.filters.search" @input="listGet" placeholder="请输入内容" suffix-icon="el-icon-search" />
      <c-flex-auto />
      <el-button type="primary" size="medium" @click="drawer = true">新建任务</el-button>
      <el-button type="info" @click="toggle" size="medium">看板模式</el-button>
    </div>
    <div class="table" style="background-color: #f0f2f5;">
      <el-table
        style="width: 100%;"
        height="100%"
        v-loading="list.loading"
        :data="list.data">
        <el-table-column prop="selection" width="60" align="center" label="状态">
          <template v-slot="{ row }">
            <el-dropdown trigger="hover" placement="bottom-start" @command="handleCommand">
              <span class="el-dropdown-link issues-tag">
                <span v-if="row.status === 0" class="my-status el-icon-circle-close"></span>
                <span v-if="row.status === 1" class="my-status el-icon-bangzhu"></span>
                <span v-if="row.status === 2" class="my-status el-icon-video-pause"></span>
                <span v-if="row.status === 3" class="my-status el-icon-circle-check"></span>
              </span>
              <el-dropdown-menu slot="dropdown" class="issues-status-dropdown issues-tag">
                <el-dropdown-item
                  :class="row.status === 1 ? 'active' : ''"
                  :command="() => itemEdit(row, 1)">
                  <i class="el-icon-bangzhu"></i>待办的
                </el-dropdown-item>
                <el-dropdown-item
                  :class="row.status === 2 ? 'active' : ''"
                  :command="() => itemEdit(row, 2)">
                  <i class="el-icon-video-pause"></i>进行中
                </el-dropdown-item>
                <el-dropdown-item
                  :class="row.status === 3 ? 'active' : ''"
                  :command="() => itemEdit(row, 3)">
                  <i class="el-icon-circle-check"></i>已完成
                </el-dropdown-item>
                <el-dropdown-item
                  :class="row.status === 0 ? 'active' : ''"
                  :command="() => itemEdit(row, 0)">
                  <i class="el-icon-circle-close"></i>已拒绝
                </el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </template>
        </el-table-column>
        <el-table-column label="任务名称" prop="name" min-width="100" align="left">
          <template v-slot="{ row }">
            <span :style="setStatus(row.status)" class="issue-name" @click="itemEditDrawer(row)">{{ row.name }}</span>
            <span class="tag" :style="setPriority(row.priority).style">{{ setPriority(row.priority).text }}</span>
            <span
              class="tag tag-other"
              v-for="(item, index) in formatTag(row.tag)"
              :style="{ background: item.style }"
              :key="index">
              {{ item.text }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="创建时间" prop="ctime" width="200" align="left" :formatter="(row) => $moment(row.ctime).format('lll')" />
      </el-table>
    </div>
    <com-issue :drawer.sync="drawer" v-if="drawer" :id="id" :pid="pid" />
  </div>
</template>

<script>
import ComIssue from './Issue.vue'
export default {
  name: 'Table',
  components: {
    ComIssue
  },
  props: {
    showTable: Boolean,
    pid: String
  },
  data () {
    return {
      list: {
        loading: false,
        data: [],
        filters: {
          search: ''
        }
      },
      drawer: false,
      id: ''
    }
  },
  methods: {
    handleCommand (func) {
      func()
    },
    toggle () {
      this.$emit('update:showTable', !this.showTable)
    },
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetProjectIssues',
        requireAuth: true,
        params: {
          pid: this.pid,
          search: this.list.filters.search
        }
      }).then(res => {
        this.list.data = res.data.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 设置状态
    setStatus (status) {
      switch (status) {
        case 0: // 已拒绝
          return {
            color: 'rgb(236, 0, 25)',
            textDecoration: 'line-through'
          }
        case 1: // 代办
          return {
            color: '#8c92a4'
          }
        case 2: // 进行中
          return {
            color: '#005980'
          }
        case 3: // 已完成
          return {
            color: 'rgb(75, 175, 80)'
          }
      }
    },
    // 设置优先级
    setPriority (priority) {
      switch (priority) {
        case 1:
          return {
            style: {
              color: 'rgb(176, 176, 176)',
              borderColor: 'rgb(176, 176, 176)'
            },
            text: '无优先级'
          }
        case 2:
          return {
            style: {
              color: 'rgb(115, 224, 111)',
              borderColor: 'rgb(115, 224, 111)'
            },
            text: '不重要'
          }
        case 3:
          return {
            style: {
              color: 'rgb(0, 138, 255)',
              borderColor: 'rgb(0, 138, 255)'
            },
            text: '次要'
          }
        case 4:
          return {
            style: {
              color: 'rgb(255, 143, 0)',
              borderColor: 'rgb(255, 143, 0)'
            },
            text: '主要'
          }
        case 5:
          return {
            style: {
              color: 'rgb(239, 0, 22)',
              borderColor: 'rgb(239, 0, 22)'
            },
            text: '重要'
          }
      }
    },
    // 格式化标签
    formatTag (tag) {
      const res = []
      tag.split(',').forEach(item => {
        const tmp = { text: item, style: '' }
        switch (item) {
          case 'bug':
            tmp.style = '#DB2828'
            break
          case 'duplicate':
            tmp.style = '#767676'
            break
          case 'enhancement':
            tmp.style = '#F2711C'
            break
          case 'feature':
            tmp.style = '#B5CC18'
            break
          case 'invalid':
            tmp.style = '#1B1C1D'
            break
          case 'question':
            tmp.style = '#00B5AD'
            break
          case 'wontfix':
            tmp.style = '#6435C9'
            break
        }
        res.push(tmp)
      })
      return res
    },
    // 编辑
    itemEdit (row, status) {
      row.status = status
      this.$http({
        name: 'UpdateProjectIssue',
        requireAuth: true,
        data: row
      }).then(res => {
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.listGet()
      })
    },
    itemEditDrawer (row) {
      this.drawer = true
      this.id = row.id
    }
  },
  created () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.issues{
  .tag {
    font-size: 12px;
    font-weight: normal;
    border-radius: 2px;
    padding: 2px 6px;
    border-width: 1px;
    border-style: solid;
    margin-left: 5px;
  }
  .tag-other {
    color: #fff;
    border: none;
  }
  .my-status {
    cursor: pointer;
    font-size: 16px;
  }
  .issue-name {
    cursor: pointer;
  }
}
.issues-status-dropdown {
  margin-top: 0px !important;
  padding: 0 !important;
  .popper__arrow {
    display: none !important;
  }
  .active {
    background: #fef8f2;
  }
  .el-dropdown-menu__item:hover {
    background: #fef8f2;
    color: #606266;
  }
}
.issues-tag {
  .el-icon-circle-close {
    color: rgb(236, 0, 25);
  }
  .el-icon-bangzhu {
    color: rgb(140, 146, 164)
  }
  .el-icon-video-pause {
    color: rgb(0, 89, 128);
  }
  .el-icon-circle-check {
    color: rgb(75, 175, 80);
  }
}
</style>
