<template>
  <div class="app-page resource-panel">
    <div class="toolbar">
      <c-flex-auto />
      <el-button type="info" @click="toggle" size="medium" icon="el-icon-notebook-2">列表</el-button>
    </div>
    <div class="table">
      <div class="resource-list">
        <div class="resource-item">
          <div class="resource-item-icon"></div>
        </div>
        <div class="resource-item" v-for="(item, index) in 25" :key="index"></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ResourcePanel',
  props: {
    showTable: Boolean
  },
  methods: {
    // 切换模式
    toggle () {
      this.$emit('update:showTable', !this.showTable)
    }
  }
}
</script>

<style lang="scss">
.resource-panel {
  .table {
    background: #f0f2f5 !important;
    border: 1px dashed #d2cdcd;
    padding: 15px 0 0 15px;
  }
  .resource-list {
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    .resource-item {
      width: 100px;
      height: 130px;
      border: 1px solid #99d1ff;
      margin: 0 15px 15px 0;
    }
  }
}
</style>
