<template>
  <el-card>
    <!-- 标题 -->
    <div slot="header">
      <span class="el-card-title">我参与的会议</span>
    </div>
    <!-- 内容 -->
    <div class="meeting-box">
      <div class="meeting-item">
        <span class="meeting-title"
          >会议标题会议标题会议标题会议标题会议标题会议标题会议</span
        >
        <div class="meeting-item-box">
          <i class="iconfont icon-time-circle"></i>
          <span class="meeting-time">今天 15:30-17:30</span>
          <span class="meeting-long-time">2小时</span>
          <i class="iconfont icon-location"></i>
          <span class="meeting-location">会议室地址</span>
        </div>
      </div>
      <div class="meeting-item">
        <span class="meeting-title"
          >会议标题会议标题会议标题会议标题会议标题会议标题会议</span
        >
        <div class="meeting-item-box">
          <i class="iconfont icon-time-circle"></i>
          <span class="meeting-time">今天 15:30-17:30</span>
          <span class="meeting-long-time">2小时</span>
          <i class="iconfont icon-location"></i>
          <span class="meeting-location">会议室地址</span>
        </div>
      </div>
      <div class="meeting-item">
        <span class="meeting-title"
          >会议标题会议标题会议标题会议标题会议标题会议标题会议</span
        >
        <div class="meeting-item-box">
          <i class="iconfont icon-time-circle"></i>
          <span class="meeting-time">今天 15:30-17:30</span>
          <span class="meeting-long-time">2小时</span>
          <i class="iconfont icon-location"></i>
          <span class="meeting-location">会议室地址</span>
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
.meeting-item {
  height: 76px;
  padding: 10px 0;
  border-bottom: 1px solid #ebeef5;
  margin-bottom: 10px;
  cursor: pointer;
  display: grid;
  grid-template-columns: repeat(1, 100%);
}
.meeting-item-box {
  display: grid;
  height: 30px;
  grid-template-columns: auto auto auto auto 4fr;
  margin-top: 5px;
}
.meeting-item-box > * {
  display: flex;
  justify-content: center;
  align-items: center;
}
.meeting-item-box span:nth-child(2) {
  padding: 0 10px;
}
.meeting-item-box span:nth-child(5) {
  display: flex;
  justify-content: flex-start;
}
.icon-location {
  margin: 0 5px 0 20px;
}
.meeting-title {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
.meeting-item-box .meeting-time {
  color: #396aff;
  font-weight: bold;
}
.meeting-item-box .meeting-long-time {
  color: #7682a8;
  font-size: 14px;
}
.meeting-item-box .meeting-location {
  color: #a3b1cc;
  font-size: 14px;
}
.meeting-item-box i {
  color: #7682a8;
}
</style>
