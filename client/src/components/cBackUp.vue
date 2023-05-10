<template>
  <div v-if="flag" class="c-back-up" @click="backUp">
    <i class="el-icon-top"></i>
    <span>顶部</span>
  </div>
</template>

<script>
export default {
  name: 'cBackUp',
  props: {
    container: {
      type: String,
      required: true
    },
    // 滑动超过200时显示按钮
    top: {
      type: Number,
      default: 200
    }
  },
  data () {
    return {
      flag: false
    }
  },
  methods: {
    backUp () {
      document.getElementsByClassName(this.container)[0].scrollTop = 0
    },
    handleScroll () {
      const scrollTop = document.getElementsByClassName(this.container)[0].scrollTop
      if (scrollTop > this.top) {
        this.flag = true
      } else {
        this.flag = false
      }
    }
  },
  mounted () {
    // 注册滚动事件
    window.addEventListener('scroll', this.handleScroll, true)
  },
  destroyed () {
    // 销毁滚动时间
    window.removeEventListener('scroll', this.handleScroll)
  }
}
</script>

<style lang="scss">
.c-back-up{
  width: 48px;
  height: 64px;
  position: fixed;
  right: 20px;
  bottom: 30px;
  background: #fff;
  border: 1px solid #1665B4;
  border-radius: 4px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #1665B4;
  cursor: pointer;
  .el-icon-top{
    font-size: 26px;
  }
  span{
    font-size: 12px;
  }
}
</style>
