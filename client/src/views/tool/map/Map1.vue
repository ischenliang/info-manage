<template>
  <div class="app-page" style="padding: 0;">
    <div id="map"></div>
  </div>
</template>

<script>
import { loadModules } from 'esri-loader'
export default {
  name: 'ToolMap',
  data () {
    return {
      view: null
    }
  },
  methods: {
    async renderMap () {
      const options = {
        url: '4.17/init.js',
        css: '../../4.17/esri/themes/light/main.css'
      }
      // loadModules([
      //   'esri/Map',
      //   'esri/views/MapView'
      // ], options).then(([Map, MapView]) => {
      //   const map = new Map({
      //     basemap: 'osm'
      //   })
      //   this.view = new MapView({
      //     container: 'map',
      //     map: map,
      //     center: [104.072044, 30.663279],
      //     zoom: 10
      //   })
      // }).catch(err => {
      //   console.error('地图初始化失败', err)
      // })

      // 第二种
      const [Map, MapView] = await loadModules(([
        'esri/Map',
        'esri/views/MapView'
      ]), options)
      const map = new Map({
        basemap: 'osm' // streets-vector,topo-vector
      })
      this.view = new MapView({
        container: 'map',
        map: map,
        center: [104.072044, 30.663279],
        zoom: 10
      })
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
