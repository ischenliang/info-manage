<template>
  <el-card>
    <!-- 标题 -->
    <div slot="header">
      <span class="el-card-title">快捷操作</span>
    </div>
    <!-- 新建按钮 -->
    <div class="often-control-box">
      <div class="often-control-item">
        <i class="iconfont icon-calendar-check"></i>
        <span>新建日志</span>
      </div>
      <div class="often-control-item">
        <i class="iconfont icon-snippets"></i>
        <span>新建任务</span>
      </div>
      <div class="often-control-item">
        <i class="iconfont icon-meeting"></i>
        <span>新建会议</span>
      </div>
      <div class="often-control-item">
        <i class="iconfont icon-bell"></i>
        <span>新建公告</span>
      </div>
      <div class="often-control-item">
        <i class="iconfont icon-textin"></i>
        <span>新建收文</span>
      </div>
      <div class="often-control-item">
        <i class="iconfont icon-textout"></i>
        <span>新建发文</span>
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
.often-control-box {
  display: grid;
  grid-template-columns: repeat(2, 50%);
}
.often-control-box .often-control-item {
  height: 50px;
  display: flex;
  align-items: center;
  cursor: pointer;
  color: #424e5c;
}
.often-control-item > i {
  color: #396aff;
  margin-right: 10px;
  font-size: 1.5em;
}
</style>
