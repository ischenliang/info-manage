<template>
  <div class="app-page" style="padding: 0;">
    <div id="map"></div>
  </div>
</template>

<script>
import '@arcgis/core/assets/esri/themes/light/main.css'
import Map from '@arcgis/core/Map'
import Basemap from '@arcgis/core/Basemap'
import MapView from '@arcgis/core/views/MapView'
import Home from '@arcgis/core/widgets/Home'
import MapImageLayer from '@arcgis/core/layers/MapImageLayer'
// import LayerList from '@arcgis/core/widgets/LayerList'
export default {
  name: 'ToolMap',
  data () {
    return {
      view: null,
      map: null
    }
  },
  methods: {
    renderMap () {
      const mapLayer = new MapImageLayer({
        url: 'https://map.geoq.cn/ArcGIS/rest/services/ChinaOnlineStreetPurplishBlue/MapServer',
        title: '哈哈哈哈哈哈哈',
        visible: true,
        copyright: '北京世纪安图数码科技发展有限责任公司'
      })
      var basemap = new Basemap({
        baseLayers: [mapLayer],
        title: 'Custom Basemap',
        id: 'myBasemap'
      })
      this.map = new Map({
        basemap: basemap
      })
      this.map.addMany([mapLayer])
      // const map = new Map({
      //   // 设置基地图，可以换，这是官方的地图，自己的项目，需要加载自己的地图服务。
      //   basemap: 'osm'
      //   // 还有其他，属性，如layer，ground，用到会再说明
      // })
      this.view = new MapView({
        // 显示在HTML上的区域，也就是哪个div里
        container: 'map',
        map: this.map,
        zoom: 11, // 设置加载地图的缩放等级和中心位置。
        center: [104.072044, 30.663279] // longitude, latitude
      })
      this.view.ui.add(new Home({
        view: this.view
      }), 'top-left')

      // 添加图层
      // this.map.add(mapLayer)
      // this.view.ui.add(new LayerList({
      //   view: this.view
      // }), {
      //   position: 'top-left'
      // })
    }
  },
  mounted () {
    this.renderMap()
  }
}
</script>

<style lang="scss">
#map {
  width: 100%;
  height: 100%;
}
</style>
