<template>
  <div style="width: 100%;height: 100%;display:flex;flex-direction: column;justify-content: center;align-items: center;user-select: none;">
    <bytemd-editor
      style="width: 100%;height: 500px;"
      :value="value"
      :plugins="plugins"
      :placeholder="'请输入内容....'"
      :locale="zhHans"
      @change="handleChange" />
    <bytemd-view
      style="width: 1000px;height: 500px;"
      :value="value"
      :plugins="plugins"
      :locale="zhHans" />
  </div>
</template>

<script>
import 'bytemd/dist/index.css'
import { Editor, Viewer } from '@bytemd/vue'
// 显示中文
import zhHans from 'bytemd/locales/zh_Hans.json';
import gfmLocale from '@bytemd/plugin-gfm/locales/zh_Hans.json';
import mathLocale from '@bytemd/plugin-math/locales/zh_Hans.json';
import mermaidLocale from '@bytemd/plugin-mermaid/locales/zh_Hans.json';
// 自动链接文字、删除线、表格、任务列表
import gfm from '@bytemd/plugin-gfm'
import breaks from '@bytemd/plugin-breaks'
import mermaid from '@bytemd/plugin-mermaid'
import frontmatter from '@bytemd/plugin-frontmatter'
import footnotes from '@bytemd/plugin-footnotes'
import gemoji from '@bytemd/plugin-gemoji'
import mediumZoom from '@bytemd/plugin-medium-zoom'
import math from '@bytemd/plugin-math'
import highlight from '@bytemd/plugin-highlight'

export default {
  components: {
    BytemdEditor: Editor,
    BytemdView: Viewer
  },
  data () {
    return {
      zhHans: zhHans,
      value: '',
      plugins: [
        gfm({locale: gfmLocale}),
        breaks(),
        highlight(),
        mermaid({locale: mermaidLocale}),
        math({locale: mathLocale}),
        frontmatter(),
        footnotes(),
        gemoji(),
        mediumZoom()
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
