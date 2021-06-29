<template>
  <div class="app-page" style="padding: 0;">
    <div class="table center" style="padding: 10px;">
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
        style="100%">
        <!-- :style="{ width: layout.width + 'px' }" -->
          <grid-item
            v-for="(item, index) in layout.layout"
            :key="index"
            :static="item.static"
            :x="item.x"
            :y="item.y"
            :w="item.w"
            :h="item.h"
            :i="item.i">
              <iframe
                v-if="item.url.url"
                :src="item.url.type === 1 ? `${baseUrl}${item.url.url}?baseUrl=${item.url.query.baseUrl}&${item.url.query.data}&token=${$Cookies.get('token')}` : item.url.url"
                style="border-radius: 0 4px 0 4px;"
                scrolling="yes"
                frameborder="0"></iframe>
          </grid-item>
      </grid-layout>
    </div>
  </div>
</template>

<script>
import { GridLayout, GridItem } from 'vue-grid-layout'
export default {
  name: 'Home',
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
        layout: [
          { x: 0, y: 0, w: 16, h: 4, i: 0, className: '', url: { type: 1, url: '', query: { baseUrl: '', data: '' } } },
          { x: 16, y: 0, w: 16, h: 2, i: 1, className: '', url: { type: 2, url: '', query: { baseUrl: '', data: '' } } },
          { x: 32, y: 0, w: 16, h: 2, i: 2, className: '', url: { type: 1, url: '', query: { baseUrl: '', data: '' } } },
          { x: 16, y: 2, w: 16, h: 2, i: 3, className: '', url: { type: 1, url: '', query: { baseUrl: '', data: '' } } },
          { x: 32, y: 2, w: 16, h: 2, i: 4, className: '', url: { type: 1, url: '', query: { baseUrl: '', data: '' } } }
        ]
      },
      baseUrl: ''
    }
  },
  methods: {
    getIp () {
      this.baseUrl = localStorage.getItem('baseUrl')
    },
    listGet () {
      this.$http({
        name: 'GetDashByIdentify',
        requireAuth: true,
        params: {
          identify: 'account'
        }
      }).then(res => {
        this.layout = JSON.parse(res.data.data.layout)
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    this.getIp()
    this.listGet()
  }
}
</script>

<style lang="scss">
.app-page {
  .center {
    flex: 1 1 auto;
    height: 100%;
    background-color: #f0f2f5 !important;
    overflow: auto;
    position: relative;
    .vue-grid-layout {
      height: 100% !important;
      overflow: hidden auto;
      flex-shrink: 0;
      &::-webkit-scrollbar {
        display: none;
      }
      .vue-grid-item{
        background: #fff;
        box-shadow: 4px 4px 40px rgb(0 0 0 / 5%);
        iframe {
          width: 100%;
          height: 100%;
        }
      }
    }
  }
}
</style>
