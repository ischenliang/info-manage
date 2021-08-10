<template>
  <div class="app-page layout">
    <div class="toolbar" style="padding: 0 10px;flex: 0 0 3rem;">
      <el-button type="primary" size="small" @click="drawer = true;current = null">布局配置</el-button>
      <!-- <el-input-number v-model="layout.width" controls-position="right" class="width-input" :step="50" /> -->
      <div style="flex: auto;"></div>
      <el-button type="primary" size="small" @click="add">新增</el-button>
      <el-button type="danger" size="small" @click="$router.go(-1)">返回</el-button>
      <el-button type="success" size="small" @click="submit">保存</el-button>
    </div>
    <div class="center" ref="center" style="padding: 10px;">
      <grid-layout
        :layout.sync="layout.layout"
        :col-num="layout.colNum"
        :row-height="layout.rowHeight"
        :margin="layout.margin"
        :is-draggable="layout.draggable"
        :is-mirrored="layout.isMirrored"
        :is-resizable="layout.resizable"
        :style="style"
        :use-css-transforms="true"
        :use-style-cursor="false">
          <grid-item
            v-for="(item, index) in layout.layout"
            :key="index"
            :static="item.static"
            :x="item.x"
            :y="item.y"
            :w="item.w"
            :h="item.h"
            :i="item.i"
            :class="item.className">
              <div>
                <span class="allow-drag el-icon-setting" @click.stop="itemClick(item.i, index)"></span>
                <component
                  v-if="item.url.name"
                  :is="item.url.name"
                  :index="index"
                  :params="parseParams(item.url.params)"></component>
                <span class="remove el-icon-close" @click.stop="removeItem(item.i)"></span>
              </div>
          </grid-item>
      </grid-layout>
    </div>
    <!-- 布局配置抽屉 -->
    <el-drawer
      title="我是标题"
      :with-header="false"
      :visible.sync="drawer"
      direction="rtl"
      size="400px"
      :before-close="handleClose">
      <div class="line">
        <div class="line-title">仪表盘名称</div>
        <div class="line-content" style="padding-bottom: 0;">
          <el-input v-model="dashboard.name" placeholder="请输入仪表盘名称"></el-input>
        </div>
        <div class="line-title">仪表盘唯一标识</div>
        <div class="line-content">
          <el-input v-model="dashboard.identify" placeholder="代表该仪表盘展示在何处(唯一)"></el-input>
        </div>
        <div class="line-title">仪表盘描述</div>
        <div class="line-content">
          <el-input type="textarea" v-model="dashboard.description" placeholder="请输入仪表盘描述"></el-input>
        </div>
      </div>
      <div class="line">
        <div class="line-title">布局配置</div>
        <div class="line-content">
          <div>
            <el-checkbox v-model="layout.draggable">拖拽布局</el-checkbox>
            <el-checkbox v-model="layout.resizable">调整大小</el-checkbox>
            <el-checkbox v-model="layout.isMirrored">镜像反转</el-checkbox>
          </div>
          <div style="flex-direction: column;">
            <span class="item-tip">行高(px)</span>
            <el-input-number v-model="layout.rowHeight" style="width: 100%;" />
          </div>
          <div>
            <span class="item-tip">间距(px) 水平-垂直</span>
          </div>
          <div>
            <el-input-number v-model="hMargin" style="margin-right: 5px;" @change="marginChange" />
            <el-input-number v-model="vMargin" @change="marginChange" />
          </div>
        </div>
      </div>
      <div class="line" v-if="current !== null">
        <div class="line-title">图表绑定</div>
        <div class="line-content">
          <el-select
            v-model="layout.layout[current].url.id"
            style="width: 100%;"
            filterable
            clearable
            @change="handleChange">
            <el-option v-for="(item, index) in charts" :key="index" :label="item.name + '-' + item.component" :value="item.id" />
          </el-select>
          <el-input type="textarea" :value="placeholder" readonly v-if="placeholder" />
          <el-input v-model="layout.layout[current].url.params" placeholder="请输入传递参数，如: name=测试&theme=测试" />
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<script>
import Qs from 'qs'
import { GridLayout, GridItem } from 'vue-grid-layout'
export default {
  name: 'SystemDashLayout',
  components: {
    GridLayout,
    GridItem
  },
  computed: {
    id () {
      const id = this.$route.params.id
      if (id === 'add') {
        return 0
      } else {
        return id
      }
    },
    style () {
      return {
        width: '100%', // this.layout.width + 'px'
        border: '1px dashed #81D4FA'
      }
    },
    // 所需填写的参数描述
    placeholder: {
      get () {
        if (this.layout.layout[this.current]) {
          const tmp = this.charts.find(item => item.id === this.layout.layout[this.current].url.id)
          return tmp ? tmp.description : ''
        }
        return ''
      },
      set () {
      }
    }
  },
  data () {
    return {
      drawer: false,
      layout: {
        // width: 1680,
        draggable: true, // 拖拽
        resizable: true, // 调整大小
        colNum: 48, // 栅格系统的列数
        rowHeight: 50, // 每行的高度(px)
        margin: [10, 10], // 栅格中的元素边距
        isMirrored: false, // 标识栅格中的元素是否可镜像反转
        layout: []
      },
      index: 0, // 初始的layout的索引
      current: null, // 当前激活状态的元素
      charts: [], // 所有的chart
      loading: false,
      hMargin: 10,
      vMargin: 10,
      dashboard: {
        name: '',
        identify: '',
        description: ''
      }
    }
  },
  methods: {
    // 新增项
    add () {
      this.$nextTick(() => {
        const length = this.layout.layout.length
        const tmp = {
          x: 0,
          y: length === 0 ? 0 : this.layout.layout[length - 1].y + this.layout.layout[length - 1].h,
          w: 16,
          h: 4,
          i: this.index,
          className: '',
          url: {
            id: '',
            name: '',
            params: ''
          }
        }
        this.layout.layout.push(tmp)
        this.index++
      })
    },
    // 删除项
    removeItem (val) {
      const index = this.layout.layout.map(item => item.i).indexOf(val)
      if (index === this.current) {
        this.current = null
      }
      this.layout.layout.splice(index, 1)
    },
    // 每一项被点击
    itemClick (i, ind) {
      this.layout.layout.forEach((item, index) => {
        this.$set(item, 'className', '')
        if (item.i === i) {
          this.$set(item, 'className', 'active')
          this.current = index
        }
      })
      this.drawer = true
    },
    // 获取图表列表
    getCharts () {
      this.$http({
        name: 'GetCharts',
        requireAuth: true,
        params: {
          sort: 'name',
          order: 'desc',
          page: 1,
          size: 10000
        }
      }).then(res => {
        this.charts = res.data.data.data
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 复选框margin回调
    marginChange () {
      this.layout.margin = [this.hMargin, this.vMargin]
    },
    // 提交
    submit () {
      const layout = JSON.parse(JSON.stringify(this.layout))
      if (this.dashboard.name === '' || this.dashboard.identify === '' || layout.layout.length === 0) {
        this.$notify.error('请输入仪表盘名称或至少创建一个图表')
      } else {
        this.loading = true
        if (this.id === 0) {
          this.$http({
            name: 'AddDash',
            requireAuth: true,
            data: {
              name: this.dashboard.name,
              description: this.dashboard.description,
              identify: this.dashboard.identify,
              layout: JSON.stringify(layout)
            }
          }).then(res => {
            this.$notify.success(res.data.msg)
          }).catch(error => {
            this.$notify.error(error)
          }).finally(() => {
            this.loading = false
          })
        } else {
          this.$http({
            name: 'UpdateDash',
            requireAuth: true,
            data: {
              id: this.dashboard.id,
              name: this.dashboard.name,
              identify: this.dashboard.identify,
              description: this.dashboard.description,
              layout: JSON.stringify(layout)
            }
          }).then(res => {
            this.$notify.success(res.data.msg)
          }).catch(error => {
            this.$notify.error(error)
          }).finally(() => {
            this.loading = false
          })
        }
      }
    },
    // 获取详情
    itemGet () {
      this.$http({
        name: 'GetDash',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.dashboard = {
          id: res.data.data.id,
          name: res.data.data.name,
          identify: res.data.data.identify,
          description: res.data.data.description
        }
        const layout = JSON.parse(res.data.data.layout)
        this.$nextTick(() => {
          this.layout = layout
          this.hMargin = layout.margin[0]
          this.vMargin = layout.margin[1]
          this.index = layout.layout.sort((a, b) => b.i - a.i)[0].i + 1
        })
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 删除回调
    handleClose (done) {
      this.placeholder = ''
      done()
    },
    // 选择图表回调
    handleChange (val) {
      // 动态为该图表设置名称
      this.layout.layout[this.current].url.name = this.charts.find(item => item.id === val).component
    },
    // 格式化参数
    parseParams (params) {
      return Qs.parse(params)
    }
  },
  created () {
    this.getCharts()
    if (this.id) {
      this.itemGet()
    }
  },
  mounted () {
    // window.addEventListener('message', function (event) {
    //   console.log(event)
    //   // 此处执行事件
    // })
  }
}
</script>

<style lang="scss">
.layout {
  padding: 5px 0 0 0!important;
  .width-input {
    .el-input {
      padding: 0 !important;
    }
  }
  .center {
    flex: 1 1 auto;
    height: 100%;
    background-color: #f5f5f5;
    overflow: auto;
    position: relative;
    .vue-grid-layout {
      min-height: 100%; // 这里不能使用height: 100% !important;否则会导致整个仪表盘在拖拽的时候位置有问题的
      overflow: hidden auto;
      flex-shrink: 0;
      position: relative;
      &::-webkit-scrollbar {
        display: none;
      }
      .vue-grid-item{
        border: 1px solid #C0C0C0;
        &.active {
          border-color: #00CED1;
        }
        > div {
          width: 100%;
          height: 100%;
          position: relative;
          .remove {
            width: 30px;
            height: 30px;
            display: none;
            justify-content: center;
            align-items: center;
            position: absolute;
            cursor: pointer;
            top: 0;
            right: 0;
            background: #b1b1b1;
            color: #fff;
            z-index: 999;
          }
          .allow-drag {
            width: 30px;
            height: 30px;
            justify-content: center;
            align-items: center;
            position: absolute;
            cursor: pointer;
            top: 0;
            right: 30px;
            background: #b1b1b1;
            color: #fff;
            display: none;
            border-right: 1px dashed #fff;
            z-index: 999;
          }
          &:hover{
            .allow-drag, .remove {
              display: flex;
            }
          }
        }
      }
      .vue-grid-item.vue-grid-placeholder {
        background: green !important;
      }
    }
  }
  .el-drawer__body {
    padding: 10px;
    overflow: auto;
    .el-tabs__item.is-active {
      color: #2b9939 !important;
    }
    .el-tabs__active-bar {
      background-color: #2b9939 !important;
    }
    .line{
      margin-top: 10px;
      &:first-child{
        margin-top: 0;
      }
      .line-title {
        font-size: 15px;
        font-weight: 700;
        line-height: 18px;
      }
      .line-content {
        width: 100%;
        padding: 10px 10px;
        display: flex;
        flex-direction: column;
        flex-wrap: wrap;
        > div{
          display: flex;
          flex-direction: row;
          margin-bottom: 10px;
          > span.item-tip {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #666;
            flex: 1;
          }
        }
        .resolve-power {
          display: flex;
          flex-direction: row;
          padding: 5px 0;
          span {
            flex: 1;
            cursor: pointer;
            text-align: center;
            font-size: 14px;
            color: #fff;
            margin: 0 5px 0 10px;
            padding: 3px 0;
            background: rgb(129, 212, 250);
            border-radius: 3px;
          }
        }
      }
    }
  }
}
</style>
