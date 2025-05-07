<template>
  <el-card>
    <!-- 标签栏 -->
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="待办公文" name="first">
        <div class="document-list-box">
          <div class="document-list-item">
            <span>405001</span>
            <i class="iconfont icon-bell-fill"></i>
            <span>收文-关于国庆节假期规定</span>
            <span class="level-item">普通</span>
            <span>当前步骤：部门会签</span>
            <span class="name-item">王小明</span>
            <span class="time-item">2020-09-10 09:51</span>
          </div>
          <div class="document-list-item">
            <span>405001</span>
            <i class="iconfont icon-bell-fill"></i>
            <span>收文-关于国庆节假期规定</span>
            <span class="level-item">普通</span>
            <span>当前步骤：部门会签</span>
            <span class="name-item">王小明</span>
            <span>2020-09-10 09:51</span>
          </div>
          <div class="document-list-item">
            <span>405001</span>
            <i class="iconfont icon-bell-fill"></i>
            <span>收文-关于国庆节假期规定</span>
            <span class="level-item">普通</span>
            <span>当前步骤：部门会签</span>
            <span class="name-item">王小明</span>
            <span>2020-09-10 09:51</span>
          </div>
          <div class="document-list-item">
            <span>405001</span>
            <i class="iconfont icon-bell-fill"></i>
            <span>收文-关于国庆节假期规定</span>
            <span class="level-item">普通</span>
            <span>当前步骤：部门会签</span>
            <span class="name-item">王小明</span>
            <span>2020-09-10 09:51</span>
          </div>
          <div class="document-list-item">
            <span>405001</span>
            <i class="iconfont icon-bell-fill"></i>
            <span>收文-关于国庆节假期规定</span>
            <span class="level-item">普通</span>
            <span>当前步骤：部门会签</span>
            <span class="name-item">王小明</span>
            <span>2020-09-10 09:51</span>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="待签阅公文" name="second">配置管理</el-tab-pane>
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
.el-card .document-close-icon {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 200;
}
.document-list-box {
  display: grid;
  grid-template-columns: repeat(1, 100%);
}
.document-list-box .document-list-item {
  display: grid;
  grid-template-columns: 1fr 0.5fr 3.5fr 1fr 3fr 1fr 2fr;
  height: 40px;
  cursor: pointer;
  font-size: 14px;
  line-height: 40px;
}
.document-list-item i {
  color: #ff394c;
}
.document-list-item > * {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
</style>
