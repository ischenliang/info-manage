<template>
  <div class="c-drag-container" :style="containerStyle">
    <div class="c-drag-bg" :style="progressStyle"></div>
    <div class="c-drag-text">
      <slot name="textBefore"></slot>
      {{ text }}
    </div>
    <div
      class="c-drag-handler"
      ref="handler"
      :style="handlerStyle"
      @mousedown="handleMouseDown($event)">
      <i :class="icon"></i>
    </div>
  </div>
</template>

<script>
/**
 * width：滑动条宽度 类型(Number) 默认值(250)
 * height：滑动条高度 类型(Number) 默认值(40)
 * text：初始文字 类型(String) 默认值('请按住滑块拖动')
 * successText：成功文字 类型(String) 默认值('验证通过')
 * background：滑动条背景色 类型(String) 默认值(#eee)
 * handlerBg：滑动背景色 类型(String) 默认值(#fff)
 * width：滑动条宽度 类型(Number) 默认值(250)
 * width：滑动条宽度 类型(Number) 默认值(250)
 * width：滑动条宽度 类型(Number) 默认值(250)
 * width：滑动条宽度 类型(Number) 默认值(250)
 * width：滑动条宽度 类型(Number) 默认值(250)
 * width：滑动条宽度 类型(Number) 默认值(250)
 * width：滑动条宽度 类型(Number) 默认值(250)
*/
export default {
  name: 'cDragVerify',
  props: {
    width: {
      type: [String, Number],
      default: 250
    },
    height: {
      type: Number,
      default: 40
    },
    background: {
      type: String,
      default: 'black'
    },
    progressBarBg: {
      type: String,
      default: '#76c61d'
    },
    handlerBg: {
      type: String,
      default: '#70b1f3'
    },
    text: {
      type: String,
      default: '请按住滑块拖动'
    },
    successText: {
      type: String,
      default: '验证通过'
    },
    completedBg: {
      type: String,
      default: '验证通过背景色'
    },
    radius: {
      type: String,
      default: '4px'
    },
    icon: {
      type: String,
      default: 'el-icon-d-arrow-right'
    },
    successIcon: {
      type: String,
      default: 'el-icon-circle-check'
    },
    textSize: {
      type: String,
      default: '14px'
    },
    textColor: {
      type: String,
      default: '#fff'
    }
  },
  computed: {
    // 容器样式
    containerStyle () {
      return {
        width: typeof this.width === 'number' ? `${this.width}px` : this.width,
        height: `${this.height}px`,
        lineHeight: `${this.height}px`,
        background: this.background,
        borderRadius: this.radius,
        color: this.textColor
      }
    },
    // 滑块左侧样式
    progressStyle () {
      return {
        height: `${this.height}px`,
        borderRadius: this.radius
      }
    },
    // 滑块样式
    handlerStyle () {
      return {
        background: this.handlerBg,
        height: `${this.height}px`,
        left: '0px'
      }
    },
    // 能滑动的最大距离
    maxWidth () {
      return this.width - 56
    }
  },
  data () {
    return {
      isMove: false, // 是否移动
      x: 0
    }
  },
  methods: {
    /**
     * 鼠标按下回调函数
     * 目的：计算鼠标按下时 x轴 的位置
     * clientX、clientY：点击位置距离当前body可视区域的x，y坐标
     * pageX、pageY：对于整个页面来说，包括了被卷去的body部分的长度
     * screenX、screenY：点击位置距离当前电脑屏幕的x，y坐标
     * offsetX、offsetY：相对于带有定位的父盒子的x，y坐标
     * x、y：和screenX、screenY一样
    */
    handleMouseDown (event) {
      this.isMove = true
      // parseInt: 将 '10px' 转换成 10，如：parseInt('20px', 10) => 20
      this.x = event.pageX - parseInt(this.$refs.handler.style.left, 10)
    },
    /**
     * 鼠标移动回调
     * 鼠标指针在上下文移动时，移动距离在0 - maxWidth，滑块x轴位置等于鼠标移动距离
    */
    handlerMouseMove (event) {
      var _x = event.pageX - this.x
      if (this.isMove) {
        // 鼠标松开时，如果没有达到最大距离位置，滑块就返回初始位置
        // if (_x > 0 && _x < this.maxWidth) {
        //   this.handlerStyle.left = `${_x}px`
        //   this.progressStyle.width = `${_x}px`
        // } else {
        //   this.handlerStyle.left = '0px'
        //   this.progressStyle.width = `${this.width}px`
        // }
        console.log(_x)
      }
    }
  },
  created () {
  },
  mounted () {
    document.onmousemove = (event) => {
      this.handlerMouseMove(event)
    }
  }
}
</script>

<style lang="scss" scoped>
  .c-drag-container{
    position: relative;
    text-align: center;
    overflow: hidden;
    .c-drag-bg{
      position: absolute;
    }
    .c-drag-text{
      position: absolute;
      width: 100%;
    }
    .c-drag-handler{
      position: absolute;
      top: 0px;
      width: 56px;
    }
  }
</style>
