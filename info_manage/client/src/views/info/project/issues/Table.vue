<template>
  <div class="app-page issues">
    <div class="toolbar">
      <c-flex-auto />
      <el-button type="primary" @click="toggle" size="small">切换</el-button>
    </div>
    <div class="table" style="background-color: #f0f2f5;">
      <el-table
        style="width: 100%;"
        height="100%"
        v-loading="list.loading"
        :data="list.data">
        <el-table-column prop="selection" width="60" align="center" label="状态">
          <template v-slot="{ row }">
            <el-dropdown trigger="hover" placement="bottom-start">
              <span class="el-dropdown-link">
                <span v-if="row.status === 0" class="my-status el-icon-circle-close" style="color: rgb(236, 0, 25);"></span>
                <span v-if="row.status === 1" class="my-status el-icon-bangzhu" style="color: rgb(140, 146, 164)"></span>
                <span v-if="row.status === 2" class="my-status el-icon-video-pause" style="color: rgb(0, 89, 128);"></span>
                <span v-if="row.status === 3" class="my-status el-icon-circle-check" style="color: rgb(75, 175, 80);"></span>
              </span>
              <el-dropdown-menu slot="dropdown" class="issues-status-dropdown">
                <el-dropdown-item icon="el-icon-plus">黄金糕</el-dropdown-item>
                <el-dropdown-item icon="el-icon-circle-plus">狮子头</el-dropdown-item>
                <el-dropdown-item icon="el-icon-circle-plus-outline">螺蛳粉</el-dropdown-item>
                <el-dropdown-item icon="el-icon-check">双皮奶</el-dropdown-item>
                <el-dropdown-item icon="el-icon-circle-check">蚵仔煎</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </template>
        </el-table-column>
        <el-table-column label="任务名称" prop="name" min-width="100" align="left">
          <template v-slot="{ row }">
            <span :style="setStatus(row.status)">{{ row.name }}</span>
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
  </div>
</template>

<script>
export default {
  name: 'Table',
  props: {
    showTable: Boolean,
    pid: String
  },
  data () {
    return {
      list: {
        loading: false,
        data: []
      }
    }
  },
  methods: {
    toggle () {
      this.$emit('update:show', !this.showTable)
    },
    listGet () {
      this.$http({
        name: 'GetProjectIssues',
        requireAuth: true,
        params: {
          pid: this.pid
        }
      }).then(res => {
        this.list.data = res.data.data.data
      }).catch(error => {
        console.log(error)
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
}
.issues-status-dropdown {
  margin-top: 0px !important;
  .popper__arrow {
    display: none !important;
  }
}
</style>
