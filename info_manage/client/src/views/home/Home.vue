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
        style="100%"
        v-if="layout.layout">
          <grid-item
            v-for="(item, index) in layout.layout"
            :key="index"
            :static="item.static"
            :x="item.x"
            :y="item.y"
            :w="item.w"
            :h="item.h"
            :i="item.i"
            v-loading="loadings[index]">
              <component
                v-if="item.url.name"
                :is="item.url.name"
                :index="index"
                :params="parseParams(item.url.params)"
                @finished="finishedHandler"></component>
          </grid-item>
      </grid-layout>
    </div>
  </div>
</template>

<script>
import Qs from 'qs'
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
        layout: []
      },
      loadings: []
    }
  },
  methods: {
    listGet () {
      this.loadings = []
      this.$http({
        name: 'GetDashByIdentify',
        requireAuth: true,
        params: {
          identify: 'home'
        }
      }).then(res => {
        this.layout = JSON.parse(res.data.data.layout)
        this.layout.layout.forEach((item, index) => {
          this.$set(this.loadings, index, true)
        })
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 渲染完成回调
    finishedHandler (index) {
      this.$set(this.loadings, index, false)
    },
    // 格式化参数
    parseParams (params) {
      return Qs.parse(params)
    }
  },
  created () {
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
        // div,iframe {
        //   width: 100%;
        //   height: 100%;
        // }
      }
    }
  }
}
</style>
