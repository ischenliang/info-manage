<template>
  <bytemd-editor
    class="bytemd-editor"
    :value="content"
    :plugins="plugins"
    :placeholder="'请输入内容....'"
    :locale="zhHans"
    @change="handleChange" />
</template>

<script>
import 'bytemd/dist/index.css'
import { Editor } from '@bytemd/vue'
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
  },
  model: {
    prop: 'content',
    event: 'change'
  },
  props: {
    content: String
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
      this.$emit('change', v)
    }
  },
}
</script>

<style lang="scss">
.bytemd-editor {
  width: 100%;
  height: 100%;
  .bytemd {
    height: 100% !important;
  }
}
</style>