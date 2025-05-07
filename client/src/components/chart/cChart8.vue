<template>
  <el-card>
    <!-- 标题 -->
    <div slot="header">
      <span class="el-card-title">常用流程</span>
    </div>
    <!-- 流程区域 -->
    <div class="often-apply-box">
      <div class="apply-item">
        <el-avatar class="avatar-icon" :size="50"> user </el-avatar>
        <span class="apply-title">请假流程</span>
      </div>
      <div class="apply-item">
        <el-avatar class="avatar-icon" :size="50"> user </el-avatar>
        <span class="apply-title">测试实施流程</span>
      </div>
      <div class="apply-item">
        <el-avatar class="avatar-icon" :size="50"> user </el-avatar>
        <span class="apply-title">测试实施流程</span>
      </div>
      <div class="apply-item">
        <el-avatar class="avatar-icon" :size="50"> user </el-avatar>
        <span class="apply-title">测试实施流程</span>
      </div>
      <div class="apply-item">
        <el-avatar class="avatar-icon" :size="50"> user </el-avatar>
        <span class="apply-title">测试实施流程</span>
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
.often-apply-box {
  display: grid;
  grid-template-columns: repeat(1, 100%);
}
.often-apply-box .apply-item {
  display: flex;
  align-items: center;
  cursor: pointer;
  margin-bottom: 20px;
}
.apply-item .apply-title {
  margin-left: 10px;
}
.apply-item .avatar-icon {
  background-color: #2f7dcd !important;
}
</style>
