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
      view: null
    }
  },
  methods: {
    renderMap () {
      esriLoader.loadModules([
        'esri/Map',
        'esri/Basemap',
        'esri/views/MapView'
      ]).then(([Map, Basemap, MapView]) => {
        const map = new Map({
          // 设置基地图，可以换，这是官方的地图，自己的项目，需要加载自己的地图服务。
          basemap: 'streets'
          // 还有其他，属性，如layer，ground，用到会再说明
        })
        // 新建视图，用的是MapView，是2D的，3D的要用SceneView模块，SceneView方法创建。
        this.view = new MapView({
        // 显示在HTML上的区域，也就是哪个div里
          container: 'map',
          // 将地图服务加载到视图上，这是4.x版本设定，3.x版本可直接创建map时设定，不需要view模块。
          map: map,
          // 设置加载地图的缩放等级和中心位置。
          zoom: 11,
          center: [125.320847, 43.807021] // longitude, latitude
        })
      }).catch(error => {
        console.log(error)
      })
    }
  },
  created () {
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
