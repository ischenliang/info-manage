<template>
  <el-card>
    <!-- 标题 -->
    <div slot="header">
      <span class="el-card-title">待我执行的任务</span>
    </div>
    <!-- 内容 -->
    <div class="mytask-box">
      <div class="mytask-box-item">
        <div class="item-left">
          <el-progress
            class="progress"
            color="#396AFF"
            :show-text="false"
            :percentage="50"
          ></el-progress>
        </div>
        <div class="item-right">
          <div class="right-1">
            <span class="task-tip">督办</span>
            <el-divider direction="vertical"></el-divider>
            <span class="task-title">任务名称任务名称任务</span>
          </div>
          <div class="right-2">
            <i class="iconfont icon-time-circle-fill"></i>
            <span class="task-date">3-16</span>
            <span class="task-time">15:30-17:30</span>
          </div>
        </div>
      </div>
      <div class="mytask-box-item">
        <div class="item-left">
          <el-progress
            class="progress"
            color="#396AFF"
            :show-text="false"
            :percentage="20"
          ></el-progress>
        </div>
        <div class="item-right">
          <div class="right-1">
            <span class="task-tip">督办</span>
            <el-divider direction="vertical"></el-divider>
            <span class="task-title">任务名称任务名称任务</span>
          </div>
          <div class="right-2">
            <i class="iconfont icon-time-circle-fill"></i>
            <span class="task-date">3-16</span>
            <span class="task-time">15:30-17:30</span>
          </div>
        </div>
      </div>
      <div class="mytask-box-item">
        <div class="item-left">
          <el-progress
            class="progress"
            color="#396AFF"
            :show-text="false"
            :percentage="30"
          ></el-progress>
        </div>
        <div class="item-right">
          <div class="right-1">
            <span class="task-tip">督办</span>
            <el-divider direction="vertical"></el-divider>
            <span class="task-title">任务名称任务名称任务</span>
          </div>
          <div class="right-2">
            <i class="iconfont icon-time-circle-fill"></i>
            <span class="task-date">3-16</span>
            <span class="task-time">15:30-17:30</span>
          </div>
        </div>
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
.mytask-box-item {
  display: flex;
  padding: 10px 0;
  border: 1px solid #f2f4f7;
  border-radius: 4px;
  height: 80px;
  margin-bottom: 10px;
  cursor: pointer;
}
.item-left {
  flex: 0 0 15%;
  height: 100%;
  display: flex;
  align-items: center;
}
.progress {
  width: 100%;
  transform: rotate(270deg);
}
.item-right {
  height: 100%;
}
.right-1 {
  display: flex;
  align-items: center;
  flex: 1;
}
.right-1 .task-tip {
  color: #396aff;
}
.right-1 .task-title {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.right-2 {
  margin-top: 15px;
}
.right-2 i {
  color: #ff394c;
}
.right-2 .task-date,
.task-time {
  color: #7682a8;
  font-size: 14px;
}
.right-2 .task-date {
  margin: 0 20px 0 5px;
}
</style>
