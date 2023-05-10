<template>
  <el-card>
    <!-- 标题 -->
    <div slot="header">
      <span class="el-card-title">公告栏</span>
    </div>
    <!-- 标签栏 -->
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane class="notice-all-box" label="全部" name="first">
        <div class="all-box-1">
          <img src="../../assets/images/notice.png" alt="" />
        </div>
        <!-- 内容列表 -->
        <div class="all-box-2">
          <div class="all-box-2-item">
            <span class="title-item"
              >【通知公告】关于2020年国庆节的放假通知</span
            >
            <span class="name-item">王小明</span>
            <span class="time-item">2020-09-10 09:51</span>
          </div>
          <div class="all-box-2-item">
            <span class="title-item"
              >【通知公告】关于2020年国庆节的放假通知</span
            >
            <span class="name-item">王小明</span>
            <span class="time-item">2020-09-10 09:51</span>
          </div>
          <div class="all-box-2-item">
            <span class="title-item"
              >【通知公告】关于2020年国庆节的放假通知</span
            >
            <span class="name-item">王小明</span>
            <span class="time-item">2020-09-10 09:51</span>
          </div>
          <div class="all-box-2-item">
            <span class="title-item"
              >【通知公告】关于2020年国庆节的放假通知</span
            >
            <span class="name-item">王小明</span>
            <span class="time-item">2020-09-10 09:51</span>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="通知公告" name="second">配置管理</el-tab-pane>
      <el-tab-pane label="OA速递" name="third">角色管理</el-tab-pane>
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
}
.el-icon-close {
  font-size: 1.2em;
  cursor: pointer;
}
.el-card-title {
  font-weight: bold;
}
.notice-all-box {
  display: flex;
}
.all-box-1 {
  flex: 0 0 25%;
}
.all-box-1 img {
  width: 100%;
  height: 150px;
}
.all-box-2 {
  flex: 1;
  font-size: 14px;
  margin-left: 5px;
}
.all-box-2 .all-box-2-item {
  display: grid;
  grid-template-columns: 4fr 1fr 2fr;
  height: 40px;
  line-height: 40px;
  cursor: pointer;
}
.all-box-2-item .name-item {
  text-align: center;
}
.all-box-2-item .title-item,
.time-item,
.name-item {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
</style>
