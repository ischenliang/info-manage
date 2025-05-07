<template>
  <div class="app-page" v-loading="loading">
    <div class="table" style="padding: 10px;">
      <div class="card-box">
        <el-card>
          <div slot="header" class="clearfix">
            <span>Node信息</span>
          </div>
          <div class="card-item card-item-header">
            <div>属性</div>
            <div>值</div>
          </div>
          <div class="card-item">
            <div>系统名称</div>
            <div>个人信息管理系统</div>
          </div>
          <div class="card-item">
            <div>名称</div>
            <div v-if="system.name">{{ system.name }}</div>
          </div>
          <div class="card-item">
            <div>Node版本</div>
            <div v-if="system.version">{{ system.version }}</div>
          </div>
          <div class="card-item">
            <div>进程ID</div>
            <div v-if="system.pid">{{ system.pid }}</div>
          </div>
          <div class="card-item">
            <div>Debug测试端口</div>
            <div v-if="system.port">{{ system.port }}</div>
          </div>
          <div class="card-item">
            <div>运行时长</div>
            <div v-if="system.runTime">{{ system.runTime | timeFormat }}</div>
          </div>
          <div class="card-item">
            <div>安装路径</div>
            <div v-if="system.home">{{ system.home }}</div>
          </div>
          <div class="card-item">
            <div>项目路径</div>
            <div v-if="system.dir">{{ system.dir }}</div>
          </div>
          <div class="card-item">
            <div>操作系统</div>
            <div v-if="system.platform">{{ system.platform }}</div>
          </div>
          <div class="card-item">
            <div>系统架构</div>
            <div v-if="system.os">{{ system.os }}</div>
          </div>
          <div class="card-item">
            <div>总内存</div>
            <div v-if="system.memoryUsage">{{ system.memoryUsage.heapTotal | sizeFormat }}</div>
          </div>
          <div class="card-item">
            <div>已使用</div>
            <div v-if="system.memoryUsage">{{ system.memoryUsage.heapUsed | sizeFormat }}</div>
          </div>
          <div class="card-item">
            <div>使用率</div>
            <div>{{ rate }}%</div>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MonitorServer',
  data () {
    return {
      system: {},
      loading: false
    }
  },
  computed: {
    rate () {
      if (this.system.memoryUsage) {
        return (this.system.memoryUsage.heapUsed / this.system.memoryUsage.heapTotal).toFixed(2)
      }
      return 0.00
    }
  },
  filters: {
    sizeFormat (val) {
      if (val / (1024 * 1024 * 1024 * 1024 * 1024) > 1) {
        return (val / (1024 * 1024 * 1024 * 1024 * 1024)).toFixed(2) + 'P'
      } else if (val / (1024 * 1024 * 1024 * 1024) > 1) {
        return (val / (1024 * 1024 * 1024 * 1024)).toFixed(2) + 'T'
      } else if (val / (1024 * 1024 * 1024) > 1) {
        return (val / (1024 * 1024 * 1024)).toFixed(2) + 'G'
      } else if (val / (1024 * 1024) > 1) {
        return (val / (1024 * 1024)).toFixed(2) + 'M'
      } else if (val / 1024 > 1) {
        return (val / 1024).toFixed(2) + 'K'
      } else {
        return val + 'byte'
      }
    },
    timeFormat (val) {
      let res = ''
      let second = parseInt(val) // 秒
      let minute = 0 // 分
      let hour = 0 // 时
      let day = 0 // 天
      if (second > 60) {
        minute = parseInt(second / 60)
        second = second % 60
        if (minute > 60) {
          hour = parseInt(minute / 60)
          minute = minute % 60
          if (hour > 24) {
            day = hour / 24
            hour = hour % 24
          }
        }
      }
      if (day > 0) {
        res += (day > 10 ? day : '0' + day) + '天'
      }
      if (hour > 0) {
        res += (hour > 10 ? hour : '0' + hour) + '时'
      }
      if (minute > 0) {
        res += (minute > 10 ? minute : '0' + minute) + '分'
      }
      if (second > 0) {
        res += (second > 10 ? second : '0' + second) + '秒'
      }
      return res
    }
  },
  methods: {
    listGet () {
      this.loading = true
      this.$http({
        name: 'MonitorServer',
        requireAuth: true
      }).then(res => {
        this.system = res.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    }
  },
  created () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.card-box{
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between;
  .el-card {
    flex: 1;
    margin: 10px;
    .card-item {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      height: 44px;
      align-items: center;
      border-bottom: 1px solid #dfe6ec;
      &.card-item-header{
        > div {
          font-weight: bold;
          color: #909399;
        }
      }
      > div {
        flex: 1;
        color: #606266;
      }
    }
  }
}
</style>
