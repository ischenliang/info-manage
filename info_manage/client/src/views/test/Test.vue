<template>
  <div style="width: 100%;height: 100%;display:flex;flex-direction: column;justify-content: center;align-items: center;user-select: none;">
    <grid-layout
      :layout="layout.layout"
      :col-num="layout.colNum"
      :row-height="layout.rowHeight"
      :margin="layout.margin"
      :is-draggable="false"
      :is-resizable="false"
      :is-mirrored="layout.isMirrored"
      :vertical-compact="true"
      :use-style-cursor="false"
      :use-css-transforms="false"
      style="width: 100%;"
      v-if="layout.layout">
        <grid-item
          v-for="(item, index) in layout.layout"
          :key="index"
          :static="item.static"
          :x="item.x"
          :y="item.y"
          :w="item.w"
          :h="item.h"
          :i="item.i">
            <!-- <iframe
              v-if="item.url.url"
              :src="item.url.type === 1 ? `${baseUrl}${item.url.url}?baseUrl=${item.url.query.baseUrl}&${item.url.query.data}&token=${$Cookies.get('token')}` : item.url.url"
              style="border-radius: 0 4px 0 4px;"
              scrolling="yes"
              frameborder="0"></iframe> -->
              <component :is="'cChart1'" :key="index"></component>
        </grid-item>
    </grid-layout>
  </div>
</template>

<script>
import { GridLayout, GridItem } from 'vue-grid-layout'
export default {
  components: {
    GridLayout,
    GridItem
  },
  data () {
    return {
      layout: {
        width: 1680,
        draggable: true, // 拖拽
        resizable: true, // 调整大小
        colNum: 48, // 栅格系统的列数
        rowHeight: 50, // 每行的高度(px)
        margin: [10, 10], // 栅格中的元素边距
        isMirrored: false, // 标识栅格中的元素是否可镜像反转
        layout: []
      }
    }
  },
  methods: {
    listGet () {
      this.$http({
        name: 'GetDashByIdentify',
        requireAuth: true,
        params: {
          identify: 'home'
        }
      }).then(res => {
        this.layout = JSON.parse(res.data.data.layout)
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  mounted () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.vue-grid-layout {
  width: 100%;
  &::-webkit-scrollbar {
    display: none;
  }
  .vue-grid-item{
    background: #fff;
    box-shadow: 4px 4px 40px rgb(0 0 0 / 5%);
    // div,iframe {
    //   width: 100%;
    //   height: 100%;
    // }
  }
}
</style>
