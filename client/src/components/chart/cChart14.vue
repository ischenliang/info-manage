<template>
  <el-card>
    <!-- 标签栏 -->
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="待办流程" name="first">
        <div class="process-box">
          <div class="process-item">
            <el-avatar src="https://picsum.photos/200/200?random=2"></el-avatar>
            <span>王小明</span>
            <span>请假申请</span>
            <span>当前步骤：经理审批</span>
            <span>2020-09-10 09:51</span>
          </div>
        </div>
        <div class="process-box">
          <div class="process-item">
            <el-avatar src="https://picsum.photos/200/200?random=3"></el-avatar>
            <span>王小明</span>
            <span>请假申请</span>
            <span>当前步骤：经理审批</span>
            <span>2020-09-10 09:51</span>
          </div>
        </div>
        <div class="process-box">
          <div class="process-item">
            <el-avatar src="https://picsum.photos/200/200?random=4"></el-avatar>
            <span>王小明</span>
            <span>请假申请</span>
            <span>当前步骤：经理审批</span>
            <span>2020-09-10 09:51</span>
          </div>
        </div>
        <div class="process-box">
          <div class="process-item">
            <el-avatar src="https://picsum.photos/200/200?random=5"></el-avatar>
            <span>王小明</span>
            <span>请假申请</span>
            <span>当前步骤：经理审批</span>
            <span>2020-09-10 09:51</span>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="待签阅流程" name="second">配置管理</el-tab-pane>
    </el-tabs>
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
      activeName: 'first'
    }
  },
  methods: {
    handleClick (tab, event) {
      console.log(tab, event)
    }
  },
  mounted () {
    this.$emit('finished', this.index)
  }
}
</script>

<style>
.el-card {
  height: 100%;
  position: relative;
}
.el-card .process-close-icon {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 200;
}
.process-item {
  display: grid;
  grid-template-columns: 1fr 1fr 2fr 3fr 3fr;
  height: 40px;
  margin-bottom: 20px;
  font-size: 14px;
  cursor: pointer;
  line-height: 40px;
}
.process-item > * {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
</style>
