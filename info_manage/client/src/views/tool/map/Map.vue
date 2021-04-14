<template>
  <div class="app-page" style="padding: 0;">
    <div id="map"></div>
  </div>
</template>

<script>
import esriLoader from 'esri-loader'
export default {
  name: 'ToolMap',
  data () {
    return {
      view: null, // 地图视图
      map: null // 地图
    }
  },
  methods: {
    // 初始化地图
    initMap (Basemap, Map, MapImageLayer) {
      this.layers = []
      // this.mapInfo.forEach((item, index) => {
      //   const layer = new MapImageLayer({
      //     url: JSON.parse(item.informations).url,
      //     title: item.name,
      //     visible: true,
      //     copyright: '北京世纪安图数码科技发展有限责任公司'
      //   })
      //   this.layers.push(layer)
      //   // 前往第一个图层的初始位置
      //   if (index === 0) {
      //     layer.when(() => {
      //       this.view.goTo(layer.fullExtent).catch(error => {
      //         console.log(error)
      //       })
      //     })
      //   }
      // })
      var basemap = new Basemap({
        baseLayers: this.layers,
        title: 'Custom Basemap',
        id: 'map'
      })

      this.map = new Map({
        basemap: basemap,
        layers: [this.graphicsLayer]
      })
      this.map.addMany(this.layers)
    },
    // 初始化 MapView
    initView (MapView) {
      this.view = new MapView({
        container: 'map',
        map: this.map,
        zoom: 11,
        center: [125.320847, 43.807021]
      })
      // 区域logo和powered by esri
      // this.view.ui.remove('attribution')
    },
    // 添加图层列表
    addLayerList (LayerList, Expand) {
      const layerList = new LayerList({
        view: this.view,
        listItemCreatedFunction: event => {
          // 判断是否为子图层
          if (this.layersTitle.includes(event.item.title)) {
            event.item.actionsSections = [
              [
                { title: '设置透明度', className: 'esri-icon-environment-settings', id: 'opacity' },
                { title: '前往图层', className: 'esri-icon-zoom-out-fixed', id: 'full-extent' },
                { title: '图层信息', className: 'esri-icon-description', id: 'information' }
              ]
            ]
          } else if (event.item.title === '绘图图层') {
            event.item.actionsSections = []
          } else {
            event.item.actionsSections = [
              [
                { title: '图层信息', className: 'esri-icon-description', id: 'information' }
              ]
            ]
          }
        }
      })
      layerList.on('trigger-action', event => {
        var id = event.action.id
        switch (id) {
          case 'full-extent':
            if (event.item.layer.fullExtent !== null) {
              this.view.goTo(event.item.layer.fullExtent).catch(function (error) {
                console.error(error)
              })
            }
            break
          case 'information':
            window.open(event.item.layer.url, '_blank')
            break
          case 'opacity':
            this.layers.forEach((item, index) => {
              if (event.item.title === item.title) {
                this.active = index
                this.opacity = item.opacity
              }
            })
            this.visible = true
            break
        }
      })
      this.layerListExpand = new Expand({
        view: this.view,
        content: layerList,
        expandTooltip: '图层'
      })
      // 通过监听expanded：从而隐藏绘图图层项
      this.layerListExpand.watch('expanded', val => {
        // $('span[aria-label="绘图图层"]').parent().parent().parent().attr('class')
        // $('span[aria-label="绘图图层"]').parents('li.esri-layer-list__item').attr('class')
        // $('span[aria-label="绘图图层"]').parents('li.esri-layer-list__item').css({
        //   display: 'none'
        // })
        // 将legendExpand 收起来
        if (val) {
          this.legendExpand.collapse()
        }
      })
      this.view.ui.add(this.layerListExpand, 'top-left')
    },
    // 添加图例
    addLegend (Legend, Expand) {
      this.legendExpand = new Expand({
        expandIconClass: 'esri-icon-maps', // 展开icon的class
        collapseIconClass: 'esri-icon-collapse', // 收缩icon的class
        view: this.view,
        content: new Legend({
          view: this.view
        }),
        expanded: false, // 是否默认展开
        expandTooltip: '图例'
      })
      // 监听expanded属性的变化
      this.legendExpand.watch('expanded', val => {
        // 将layerListExpand 收起来
        if (val) {
          this.layerListExpand.collapse()
        }
      })
      this.view.ui.add(this.legendExpand, 'top-left')
    },
    // 添加比例尺
    addScalebar (ScaleBar) {
      const scaleBar = new ScaleBar({
        view: this.view,
        unit: 'metric'
      })
      this.view.ui.add(scaleBar, 'bottom-left')
    },
    // 添加home
    addHome (Home) {
      const home = new Home({
        view: this.view,
        iconClass: 'esri-icon-locate'
      })
      // 替换home的图标
      home.when(() => {
        document
          .querySelector('.esri-home')
          .querySelector('.esri-icon').classList = 'esri-icon esri-icon-locate'
      })
      this.view.ui.add(home, 'top-left')
    },
    // 添加返回
    addRefresh (Expand) {
      const expand = new Expand({
        expandIconClass: 'esri-icon-refresh', // 展开icon的class
        collapseIconClass: 'esri-icon-refresh', // 收缩icon的class
        view: this.view,
        content: '',
        expanded: false, // 是否默认展开
        expandTooltip: '刷新',
        collapseTooltip: '刷新'
      })
      expand.watch('expanded', (val) => {
        this.reviewMap(this.resourceItemId)
      })
      this.view.ui.add(expand, 'top-left')
    },
    // 添加返回
    addReturn (Expand) {
      const expand = new Expand({
        expandIconClass: 'esri-icon-home', // 展开icon的class
        collapseIconClass: 'esri-icon-home', // 收缩icon的class
        view: this.view,
        content: '',
        expanded: false, // 是否默认展开
        expandTooltip: '返回',
        collapseTooltip: '返回'
      })
      expand.watch('expanded', (val) => {
        this.hiddenMap()
      })
      this.view.ui.add(expand, 'top-left')
    },
    // 添加绘图
    addSketch (Sketch) {
      var sketch = new Sketch({
        layer: this.graphicsLayer,
        view: this.view,
        creationMode: 'update',
        availableCreateTools: ['polygon', 'rectangle', 'circle'] // 设置sketch默认显示的形状
      })
      this.view.ui.add(sketch, 'top-right')
      // 监听创建事件
      sketch.on('create', event => {
        if (event.state === 'complete') {
          event.graphic.symbol = this.symbol // 设置颜色和边框
          if (this.graphicsLayer.graphics.items.length > 1) {
            this.graphicsLayer.removeAll()
            this.graphicsLayer.add(event.graphic)
          }
          this.geometry = JSON.stringify(event.graphic.geometry.toJSON())
        }
      })
      // 监听更新事件
      sketch.on('update', event => {
        event.graphics.forEach(item => {
          item.symbol = this.symbol
        })
      })
    },
    // 添加绘图图层
    addGraphics (GraphicsLayer) {
      this.graphicsLayer = new GraphicsLayer({
        title: '绘图图层',
        visible: true,
        copyright: '北京世纪安图数码科技发展有限责任公司'
      })
    },
    // 渲染地图
    renderMap () {
      const options = {
        url: '4.17/init.js',
        css: '../../4.17/esri/themes/light/main.css'
      }
      if (process.env.NODE_ENV === 'production') {
        options.css = '/datax/4.17/esri/themes/light/main.css'
      }
      esriLoader.loadModules([
        'esri/Map',
        'esri/Basemap',
        'esri/views/MapView',
        'esri/layers/MapImageLayer',
        'esri/widgets/LayerList',
        'esri/widgets/Expand',
        'esri/widgets/Legend',
        'esri/widgets/ScaleBar',
        'esri/widgets/Home',
        'esri/widgets/Sketch',
        'esri/layers/GraphicsLayer'
        // 'esri/geometry/Extent',
      ], options)
        .then(([Map, Basemap, MapView, MapImageLayer, LayerList, Expand, Legend, ScaleBar, Home, Sketch, GraphicsLayer]) => {
          this.$nextTick(() => {
            this.addGraphics(GraphicsLayer)
            this.initMap(Basemap, Map, MapImageLayer)
            this.initView(MapView)
            this.addHome(Home)
            this.addScalebar(ScaleBar)
            this.view.when(() => {
              this.addLayerList(LayerList, Expand)
              this.addLegend(Legend, Expand)
              this.addSketch(Sketch)
              // this.addRefresh(Expand)
              this.addReturn(Expand)
              this.$nextTick(() => {
                // this.view.ui.add(this.$refs.resource, 'top-right')
              })
            })
          })
        }).catch(error => {
          console.log(error)
        })
    }
  },
  created () {
    // this.renderMap()
  }
}
</script>

<style lang="scss">
#map {
  width: 100%;
  height: 100%;
}
</style>
