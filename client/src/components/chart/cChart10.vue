<template>
  <el-card>
    <div slot="header">
      <span class="el-card-title">待办事项</span>
    </div>
    <div class="wait-matter-box">
      <div class="grid-item item-1">
        <span class="wait-matter-title">待办公文</span>
        <span class="wait-matter-total">23</span>
        <span class="wait-matter-complete-title"
          >今日已办<span class="wait-matter-complete-num">3</span></span>
      </div>
      <div class="grid-item item-2">
        <span class="wait-matter-title">待办流程</span>
        <span class="wait-matter-total">12</span>
        <span class="wait-matter-complete-title"
          >今日已办<span class="wait-matter-complete-num">3</span></span
        >
      </div>
      <div class="grid-item item-3">
        <span class="wait-matter-title">待办任务</span>
        <span class="wait-matter-total">30</span>
        <span class="wait-matter-complete-title"
          >今日已办
          <span class="wait-matter-complete-num">3</span>
          <span class="wait-matter-complete-update"
            >今日更新
            <span class="wait-matter-complete-update-num">5</span></span
          >
        </span>
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
.wait-matter-box {
  display: grid;
  grid-template-columns: repeat(3, 33.3%);
}
.wait-matter-box .grid-item {
  display: flex;
  flex-direction: column;
}
.grid-item .wait-matter-title,
.wait-matter-complete-title {
  color: rgba(0, 0, 0, 0.45);
  font-size: 14px;
}
.grid-item .wait-matter-total {
  font-size: 1.5em;
  font-weight: bold;
  margin: 10px 0;
}
.grid-item .wait-matter-complete-num {
  margin-left: 10px;
  color: #29c814;
  font-size: 14px;
}
.wait-matter-complete-title .wait-matter-complete-update {
  margin-left: 10px;
}
.wait-matter-complete-update .wait-matter-complete-update-num {
  margin-left: 10px;
  color: #396aff;
  font-size: 14px;
}
</style>
