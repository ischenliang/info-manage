<template>
  <div class="app-page">
    <div class="toolbar"></div>
    <div class="table">
      <el-button type="primary" @click="toggle" size="medium">列表模式</el-button>
      看板形式展示数据......
    </div>
  </div>
</template>

<script>
export default {
  name: 'Panel',
  props: {
    showTable: Boolean
  },
  methods: {
    toggle () {
      this.$emit('update:showTable', !this.showTable)
    }
  }
}
</script>

<style>

</style>
