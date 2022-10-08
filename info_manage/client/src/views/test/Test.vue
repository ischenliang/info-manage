<template>
  <div style="width: 100%;height: 100%;display:flex;flex-direction: column;justify-content: center;align-items: center;user-select: none;">
    <!-- <editor
      style="width: 600px;height: 400px;"
      :value="value"
      :plugins="plugins"
      @change="handleChange" /> -->
  </div>
</template>

<script>
import 'bytemd/dist/index.css'
// import { Editor } from '@bytemd/vue'
// import gfm from '@bytemd/plugin-gfm'
export default {
  components: {
    // Editor
  },
  data () {
    return {
      value: '',
      plugins: [
        // gfm()
      ]
    }
  },
  methods: {
    handleChange (v) {
      this.value = v
    }
  },
  mounted () {
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
