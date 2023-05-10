<template>
  <div class="chart-container" :id="id"></div>
</template>

<script>
export default {
  name: 'cChart2',
  props: {
    index: {
      type: Number,
      default: 0
    },
    params: {
      type: Object,
      default: function () {
        return {
          title: '数据种类与数量'
        }
      }
    }
  },
  data () {
    return {
      myChart: null,
      id: `chart${this.index}`
    }
  },
  methods: {
    initChart () {
      this.myChart = this.$echarts.init(document.getElementById(this.id))
      const option = {
        title: {
          text: this.params.title,
          left: 'center',
          textStyle: {
            color: '#5ac4d3'
          }
        },
        grid: {
          left: 10,
          bottom: 10,
          right: 25,
          containLabel: true
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          left: 'left'
        },
        series: [
          {
            name: '数据量',
            type: 'pie',
            radius: '50%',
            data: [
              { value: 1024, name: '工程测绘' },
              { value: 985, name: '电子地图' },
              { value: 1048, name: '地形图' },
              { value: 735, name: '专题数据' },
              { value: 580, name: '影像数据' },
              { value: 580, name: '测绘基准' },
              { value: 484, name: '城市三维模型' },
              { value: 300, name: '数字高程模型' }
            ]
          }
        ]
      }
      this.myChart.setOption(option)
      // 方式一
      this.myChart.resize()
      this.$nextTick(() => {
        this.myChart.resize()
      })
      // 渲染完毕后通知父组件关闭loading效果
      this.myChart.on('finished', () => {
        this.$emit('finished', this.index)
      })
    }
  },
  mounted () {
    this.initChart()
    window.addEventListener('resize', () => {
      this.myChart.resize()
    })
  }
}
</script>

<style lang="scss">
.chart-container {
  width: 100%;
  height: 100%;
  overflow: hidden;
}
</style>
