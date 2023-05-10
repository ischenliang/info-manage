<template>
  <span class="c-toggle-copy">
    <el-tooltip
      effect="dark"
      :content="title"
      placement="top">
      <span :class="icon" id="copy" @click="toggle($event)"></span>
    </el-tooltip>
  </span>
</template>

<script>
import Clipboard from 'clipboard'
export default {
  name: 'cToggleCopy',
  props: {
    copy: {
      type: Boolean,
      default: false,
      required: true
    },
    text: {
      type: String,
      required: true
    }
  },
  computed: {
    title () {
      return this.copy ? '已复制' : '复制'
    },
    icon () {
      return this.copy ? 'el-icon-document-checked' : 'el-icon-document-copy'
    }
  },
  methods: {
    toggle () {
      if (!this.copy) {
        const _this = this
        this.$emit('update:copy', true)
        const clipboard = new Clipboard('#copy', {
          text: function () {
            return _this.text
          }
        })
        clipboard.on('success', e => {
          clipboard.destroy()
        })
        clipboard.on('error', e => {
          clipboard.destroy()
        })
      }
    }
  }
}
</script>

<style lang="scss">
  .c-toggle-copy {
    span {
      padding: 5px 9px;
      border: 1px solid #ddd;
      border-radius: 4px;
      cursor: pointer;
    }
  }
</style>
