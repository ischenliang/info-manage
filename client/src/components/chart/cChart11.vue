<template>
  <el-card>
    <div slot="header">
      <span class="el-card-title">督办提醒</span>
    </div>
    <div class="remind-box">
      <div id="doughnutChart" class="circle-progress"></div>
      <div
        class="circle-progress-content"
        :style="
          `position:absolute;top: 40%;left:${(circleProgressHeight - 51) /
            2}px;`
        "
      >
        <span class="content-title">督办公文</span>
        <span class="content-num">17</span>
      </div>
      <div class="line-progress-box">
        <div class="line-progress-item">
          <span class="line-progress-title">未超期</span>
          <el-progress
            class="line-progress"
            color="#E4E7ED"
            :show-text="false"
            :percentage="50"
            :stroke-width="8"
          ></el-progress>
          <span class="line-progress-num">8</span>
        </div>
        <div class="line-progress-item">
          <span class="line-progress-title">超期1天</span>
          <el-progress
            class="line-progress"
            color="#396AFF"
            :show-text="false"
            :percentage="30"
            :stroke-width="8"
          ></el-progress>
          <span class="line-progress-num">5</span>
        </div>
        <div class="line-progress-item">
          <span class="line-progress-title">超期2天</span>
          <el-progress
            class="line-progress"
            color="#FFB339"
            :show-text="false"
            :percentage="20"
            :stroke-width="8"
          ></el-progress>
          <span class="line-progress-num">2</span>
        </div>
        <div class="line-progress-item">
          <span class="line-progress-title">超期3天</span>
          <el-progress
            class="line-progress"
            color="#FF394C"
            :show-text="false"
            :percentage="20"
            :stroke-width="8"
          ></el-progress>
          <span class="line-progress-num">2</span>
        </div>
      </div>
    </div>
    <div class="progress-explain-box">
      <div class="explain-item">
        <span class="dot-1"></span>
        <span class="explain-title">未超期</span>
      </div>
      <div class="explain-item">
        <span class="dot-2"></span>
        <span class="explain-title">超期1天</span>
      </div>
      <div class="explain-item">
        <span class="dot-3"></span>
        <span class="explain-title">超期2天</span>
      </div>
      <div class="explain-item">
        <span class="dot-4"></span>
        <span class="explain-title">超期3天</span>
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
      circleProgressHeight: 0
    }
  },
  methods: {
    // acharts饼形图
    doughnut () {
      const myChart = this.$echarts.init(
        document.getElementById('doughnutChart')
      )
      myChart.setOption({
        color: ['#396AFF', '#FFB339', '#FF394C', '#ccc'],
        series: [
          {
            name: '督办提醒',
            type: 'pie',
            radius: ['50%', '70%'],
            hoverAnimation: false,
            legendHoverLink: false,
            label: {
              show: false,
              position: 'center'
            },
            data: [
              { value: 5, name: '超期1天' },
              { value: 2, name: '超期2天' },
              { value: 2, name: '超期3天' },
              { value: 8, name: '未超期' }
            ]
          }
        ]
      })
    }
  },
  mounted () {
    this.doughnut()
    this.circleProgressHeight = document.getElementById(
      'doughnutChart'
    ).clientWidth
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
.remind-box {
  display: flex;
  height: 160px;
  position: relative;
}
.remind-box .circle-progress {
  flex: 0 0 10%;
}
.circle-progress-content {
  /* position: absolute;
  top: 40%;
  left: 65px; */
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  /* transform: translate(-40%,0); */
}
.circle-progress-content .content-title {
  font-size: 0.8em;
  color: rgba(0, 0, 0, 0.45);
}
.circle-progress-content .content-num {
  font-size: 1.4em;
}
.remind-box .line-progress-box {
  flex: 1;
}
.line-progress-item {
  display: grid;
  grid-template-columns: 2fr 4fr 1fr;
  height: 40px;
  line-height: 40px;
}
.line-progress-item .line-progress-title {
  color: rgba(0, 0, 0, 0.45);
  font-size: 14px;
}
.line-progress-item .line-progress-num {
  text-align: center;
}
.line-progress-item .line-progress {
  display: flex;
  align-items: center;
}

/* 类型提示 */
.progress-explain-box {
  margin-top: 20px;
  display: grid;
  grid-template-columns: repeat(4, 25%);
}
.progress-explain-box .explain-item {
  display: flex;
  justify-content: center;
  align-items: center;
}
.explain-item .dot-1,
.dot-2,
.dot-3,
.dot-4 {
  width: 10px;
  height: 10px;
  background: #e4e7ed;
  border-radius: 50%;
  margin-right: 10px;
}
.dot-2 {
  background: #396aff;
}
.dot-3 {
  background: #ffb339;
}
.dot-4 {
  background: #ff394c;
}
.explain-item .explain-title {
  font-size: 12px;
  color: #8c8c8c;
}
</style>
