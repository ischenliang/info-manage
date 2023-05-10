<template>
  <el-card>
    <!-- 标题 -->
    <div slot="header">
      <span class="el-card-title">常用应用</span>
    </div>
    <!-- 主体区域 -->
    <div class="often-app-box">
      <div class="often-app app-1">
        <i class="iconfont icon-solution"></i>
        <span class="app-title">日志</span>
      </div>
      <div class="often-app app-2">
        <i class="iconfont icon-calendar-check"></i>
        <span class="app-title">日程</span>
      </div>
      <div class="often-app app-3">
        <i class="iconfont icon-meeting"></i>
        <span class="app-title">会议</span>
      </div>
      <div class="often-app app-4">
        <i class="iconfont icon-snippets"></i>
        <span class="app-title">任务</span>
      </div>
      <div class="often-app app-5">
        <i class="iconfont icon-cloud-server"></i>
        <span class="app-title">网盘</span>
      </div>
    </div>
  </el-card>
</template>

<script>
export default {
  props: {
    index: {
      type: Number,
      default: 0
    }
  },
  data () {
    return {
    }
  },
  methods: {
  },
  mounted () {
    this.$emit('finished', this.index)
  }
}
</script>

<style>
.el-card {
  height: 100%;
}
.el-icon-close {
  font-size: 1.2em;
  cursor: pointer;
}
.el-card-title {
  font-weight: bold;
}
.often-app-box {
  display: grid;
  grid-template-columns: repeat(4, 25%);
  cursor: pointer;
  justify-items: center;
}
.often-app-box .often-app {
  display: flex;
  flex-direction: column;
  width: 80px;
  justify-content: center;
  align-items: center;
  margin-bottom: 20px;
}
.often-app i {
  color: #fff;
  padding: 10px;
  font-size: 2em;
  border-radius: 4px;
}
.app-1 i {
  background: #29c814;
}
.app-2 i {
  background: #ffb339;
}
.app-3 i {
  background: #ff6b79;
}
.app-4 i {
  background: #00cde9;
}
.app-5 i {
  background: #39a0ff;
}
.app-title {
  margin-top: 10px;
}
</style>
