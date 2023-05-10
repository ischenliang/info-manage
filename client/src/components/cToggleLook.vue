<template>
  <span class="c-toggle-look">
    <el-tooltip
      effect="dark"
      :content="title"
      placement="top">
      <span class="el-icon-view" @click="toggle"></span>
    </el-tooltip>
  </span>
</template>

<script>
export default {
  name: 'cToggleLook',
  props: {
    look: {
      type: Boolean,
      default: false,
      required: true
    }
  },
  computed: {
    title () {
      return this.look ? '查看' : '隐藏'
    }
  },
  methods: {
    toggle () {
      this.$emit('update:look', !this.look)
    }
  }
}
</script>

<style lang="scss">
  .c-toggle-look {
    span {
      padding: 5px 9px;
      border: 1px solid #ddd;
      border-radius: 4px;
      cursor: pointer;
    }
  }
</style>
