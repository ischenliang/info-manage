<template>
  <div class="app-page task-log">
    <div class="toolbar">
      <el-page-header
        @back="$router.push({ path: '/monitor/job/list' })"
        :content="'定时任务日志'" />
      <c-flex-auto />
      <el-button
        type="danger"
        size="medium"
        @click="$router.push({ path: '/monitor/job/list' })">取消</el-button>
    </div>
    <div class="table">
      <el-card v-loading="loading">
        <div slot="header" class="clearfix">
          <span>任务名称：【{{ name }}】</span>
          <div>
            <el-button type="primary" icon="el-icon-refresh" size="mini" title="刷新日志" @click="listGet" />
          </div>
        </div>
        <div class="line" v-for="(item, index) in logs" :key="index" v-html="item"></div>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MonitorJobLog',
  data () {
    return {
      logs: [],
      loading: false,
      name: ''
    }
  },
  computed: {
    id () {
      return this.$route.params.id === undefined ? '' : this.$route.params.id
    }
  },
  methods: {
    listGet () {
      this.loading = true
      this.$http({
        name: 'GetTaskLog',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.logs = []
        this.name = res.data.data.name
        res.data.data.logs.forEach(item => {
          const reg = /\[(\d{4}-\d{2}-\d{2})\s(\d{2}:\d{2}:\d{2})\]/
          const tmp = reg.exec(item)
          item = item.replace(reg, `<span style="color: #409EFF;">${tmp[0]}</span>&nbsp;`)
          if (/\[INFO\]/.test(item)) {
            item = `<span style="color: #7bc379;">${item}</span>`
          }
          if (/\[ERROR\]/.test(item)) {
            item = `<span style="color: #F56C6C;">${item}</span>`
          }
          this.logs.push(item)
        })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    }
  },
  created () {
    if (this.id) {
      this.listGet()
    }
  }
}
</script>

<style lang="scss">
  .task-log {
    .el-card{
      height: 100%;
      display: flex;
      flex-direction: column;
      .el-card__header {
        flex-shrink: 0;
        .clearfix {
          display: flex;
          flex-direction: row;
          justify-content: space-between;
          align-items: center;
        }
      }
      .el-card__body {
        flex: 1 1 auto;
        overflow-y: auto;
      }
    }
    .line {
      border-top: 1px dashed #dde6e9;
      min-height: 30px;
      line-height: 25px;
      display: flex;
      flex-direction: row;
      align-items: center;
      flex-wrap: wrap;
      font-size: 14px;
      color: #999;
      &:last-child {
        border-bottom: 1px dashed #dde6e9;
      }
    }
  }
</style>
