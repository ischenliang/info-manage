<template>
  <div class="app-page resource-panel">
    <div class="toolbar">
      <c-flex-auto />
      <el-button type="info" @click="toggle" size="medium" icon="el-icon-notebook-2">列表</el-button>
    </div>
    <div class="table">
      <div class="resource-list">
        <div class="resource-item" v-for="(item, index) in 25" :key="index">
          <div class="resource-item-icon">
            <img src="./icon/folder.png" alt="">
          </div>
          <div class="resource-item-name">文件名称文件名称文件名称文件名称文件名称</div>
        </div>
        <div class="resource-item">
          <div class="resource-item-icon">
            <img src="./icon/7z.png" alt="">
          </div>
          <div class="resource-item-name">文件名称文件名称文件名称文件名称文件名称</div>
        </div>
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
      width: 90px;
      height: 130px;
      // border: 1px solid #99d1ff;
      margin: 0 25px 15px 0;
      cursor: pointer;
      .resource-item-icon {
        width: 100%;
        height: 90px;
        img {
          width: 100%;
          height: 100%;
        }
      }
      .resource-item-name {
        width: 100%;
        height: 36px;
        line-height: 17px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        font-size: 12px;
        padding: 1px 4px;
        word-break: break-all;
      }
    }
  }
}
</style>
