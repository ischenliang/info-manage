<template>
  <div class="app-page issues">
    <div class="toolbar">
      <el-input v-model="list.filters.search" @input="listGet" placeholder="请输入内容" suffix-icon="el-icon-search" />
      <c-flex-auto />
      <el-button type="primary" size="medium" @click="drawer = true;id = ''">新建任务</el-button>
      <el-button type="info" @click="toggle" size="medium">列表模式</el-button>
    </div>
    <div class="table issues-table c-scrollbar" style="background-color: #f0f2f5;" v-loading="list.loading">
      <el-card class="issue-card" shadow="never" :body-style="{ padding: '10px 15px' }">
        <div slot="header" class="clearfix issues-tag">
          <span><i class="el-icon-bangzhu"></i>待办的</span>
        </div>
        <div
          class="issue-item issue-item-agent"
          v-for="(row, index) in list.data.agent"
          :key="'agent' + index"
          @click="itemEditDrawer(row)">
          <div class="issue-title">{{ row.name }}</div>
          <div class="issue-tags">
            <span class="tag" :style="setPriority(row.priority).style">{{ setPriority(row.priority).text }}</span>
            <span
              class="tag tag-other"
              v-for="(item, index) in formatTag(row.tag)"
              :style="{ background: item.style }"
              :key="index">
              {{ item.text }}
            </span>
          </div>
          <div class="issue-time">
            <span>创建:{{ row.ctime }}</span>
            <span>修改:{{ row.mtime }}</span>
          </div>
        </div>
      </el-card>
      <el-card class="issue-card" shadow="never" :body-style="{ padding: '10px 15px' }">
        <div slot="header" class="clearfix issues-tag">
          <span><i class="el-icon-video-pause"></i>进行中</span>
        </div>
        <div
          class="issue-item issue-item-running"
          v-for="(row, index) in list.data.running"
          :key="'running' + index"
          @click="itemEditDrawer(row)">
          <div class="issue-title">{{ row.name }}</div>
          <div class="issue-tags">
            <span class="tag" :style="setPriority(row.priority).style">{{ setPriority(row.priority).text }}</span>
            <span
              class="tag tag-other"
              v-for="(item, index) in formatTag(row.tag)"
              :style="{ background: item.style }"
              :key="index">
              {{ item.text }}
            </span>
          </div>
          <div class="issue-time">
            <span>创建:{{ row.ctime }}</span>
            <span>修改:{{ row.mtime }}</span>
          </div>
        </div>
      </el-card>
      <el-card class="issue-card" shadow="never" :body-style="{ padding: '10px 15px' }">
        <div slot="header" class="clearfix issues-tag">
          <span><i class="el-icon-circle-check"></i>已完成</span>
        </div>
        <div
          class="issue-item issue-item-completed"
          v-for="(row, index) in list.data.completed"
          :key="'completed' + index"
          @click="itemEditDrawer(row)">
          <div class="issue-title">{{ row.name }}</div>
          <div class="issue-tags">
            <span class="tag" :style="setPriority(row.priority).style">{{ setPriority(row.priority).text }}</span>
            <span
              class="tag tag-other"
              v-for="(item, index) in formatTag(row.tag)"
              :style="{ background: item.style }"
              :key="index">
              {{ item.text }}
            </span>
          </div>
          <div class="issue-time">
            <span>创建:{{ row.ctime }}</span>
            <span>修改:{{ row.mtime }}</span>
          </div>
        </div>
      </el-card>
      <el-card class="issue-card" shadow="never" :body-style="{ padding: '10px 15px' }">
        <div slot="header" class="clearfix issues-tag">
          <span><i class="el-icon-circle-close"></i>已拒绝</span>
        </div>
        <div
          class="issue-item issue-item-rejected"
          v-for="(row, index) in list.data.rejected"
          :key="'rejected' + index"
          @click="itemEditDrawer(row)">
          <div class="issue-title">{{ row.name }}</div>
          <div class="issue-tags">
            <span class="tag" :style="setPriority(row.priority).style">{{ setPriority(row.priority).text }}</span>
            <span
              class="tag tag-other"
              v-for="(item, index) in formatTag(row.tag)"
              :style="{ background: item.style }"
              :key="index">
              {{ item.text }}
            </span>
          </div>
          <div class="issue-time">
            <span>创建:{{ row.ctime }}</span>
            <span>修改:{{ row.mtime }}</span>
          </div>
        </div>
      </el-card>
    </div>
    <com-issue :drawer.sync="drawer" v-if="drawer" :id="id" :pid="pid" @submit="listGet" />
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
        data: {
          agent: [],
          running: [],
          completed: [],
          rejected: []
        },
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
    // 切换模式
    toggle () {
      this.$emit('update:showTable', !this.showTable)
    },
    // 获取列表
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
        this.list.data = {
          agent: [],
          running: [],
          completed: [],
          rejected: []
        }
        res.data.data.data.forEach(item => {
          switch (item.status) {
            case 0:
              this.list.data.rejected.push(item)
              break
            case 1:
              this.list.data.agent.push(item)
              break
            case 2:
              this.list.data.running.push(item)
              break
            case 3:
              this.list.data.completed.push(item)
              break
          }
        })
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
    // 任务编辑
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
    margin-right: 7px;
  }
  .el-icon-bangzhu {
    color: rgb(140, 146, 164);
    margin-right: 7px;
  }
  .el-icon-video-pause {
    color: rgb(0, 89, 128);
    margin-right: 7px;
  }
  .el-icon-circle-check {
    color: rgb(75, 175, 80);
    margin-right: 7px;
  }
}
.issues-table {
  display: flex;
  flex-wrap: nowrap;
  overflow: auto;
  .issue-card {
    width: 360px;
    flex-shrink: 0;
    margin: 0 5px;
    &:first-child {
      margin-left: 0;
    }
    &:last-child {
      margin-right: 0;
    }
    .el-card__header {
      padding: 12px 15px !important;
      font-weight: bold;
    }
    .issue-item {
      width: 100%;
      border-width: 1px 1px 1px 4px;
      border-style: solid;
      padding: 4px 8px;
      margin-bottom: 12px;
      background: #fff;
      border-radius: 4px;
      cursor: pointer;
      &.issue-item-agent {
        border-color: rgb(140, 146, 164);
      }
      &.issue-item-running {
        border-color: rgb(0, 89, 128);
      }
      &.issue-item-completed {
        border-color: rgb(75, 175, 80);
      }
      &.issue-item-rejected {
        border-color: rgb(236, 0, 25);
      }
      .issue-title {
        font-size: 16px;
        color: #40485b;
        font-weight: bold;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }
      .issue-tags {
        margin: 8px 0 7px 0;
        word-break: break-word;
        display: flex;
        flex-wrap: wrap;
        .tag {
          font-size: 12px;
          font-weight: normal;
          border-radius: 2px;
          padding: 2px 6px;
          border-width: 1px;
          border-style: solid;
          margin-right: 5px;
          margin-bottom: 5px;
        }
        .tag-other {
          color: #fff;
          border: 1px solid #fff;
        }
      }
      .issue-time {
        display: flex;
        justify-content: space-between;
        font-size: 12px;
        color: #8c92a4;
      }
    }
  }
}
</style>
