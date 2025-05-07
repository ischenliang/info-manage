<template>
  <div class="chart-container" :id="id"></div>
</template>

<script>
export default {
  name: 'cChart1',
  props: {
    index: {
      type: Number,
      default: 0
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
          text: '数据种类与数量',
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
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            },
            label: {
              color: '#5ac4d3',
              fontWeight: 'bold',
              formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}G  {per|{d}%}  ',
              backgroundColor: '#F6F8FC',
              borderColor: '#8C8D8E',
              borderWidth: 1,
              borderRadius: 4,
              rich: {
                a: {
                  color: '#6E7079',
                  lineHeight: 22,
                  align: 'center'
                },
                hr: {
                  borderColor: '#8C8D8E',
                  width: '100%',
                  borderWidth: 1,
                  height: 0
                },
                b: {
                  color: '#4C5058',
                  fontSize: 14,
                  fontWeight: 'bold',
                  lineHeight: 33
                },
                per: {
                  color: '#fff',
                  backgroundColor: '#4C5058',
                  padding: [3, 4],
                  borderRadius: 4
                }
              }
            },
            labelLine: {
              lineStyle: {
                color: '#5ac4d3'
              }
            },
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
      // 另一种方式：方式二
      // this.myChart.on('finished', () => {
      //   this.myChart.resize()
      // })

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
