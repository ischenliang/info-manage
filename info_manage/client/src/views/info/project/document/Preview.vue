<template>
  <div class="document-preview" v-if="document">
    <div class="document-preview-header">
      <div class="header-left">{{ document.name }}</div>
      <div class="header-right">
        <el-button type="primary" size="small" icon="el-icon-edit" @click="togglePreview">编辑</el-button>
      </div>
    </div>
    <div class="document-preview-content">
      <div v-html="document.content"></div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProjectDocumentPreview',
  props: {
    preview: Boolean,
    document: Object
  },
  methods: {
    togglePreview () {
      this.$emit('update:preview', !this.preview)
    }
  }
}
</script>

<style lang="scss">
.document-preview {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: auto;
  .document-preview-header {
    width: 100%;
    height: 61px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    border-bottom: 1px solid #e3e9ed;
    .header-left {
      flex: 1 1 auto;
      height: 100%;
      display: flex;
      align-items: center;
      font-size: 18px;
      text-overflow: ellipsis;
      overflow: hidden;
      white-space: nowrap;
      font-weight: bold;
      color: #40485b;
      padding: 0 14px;
    }
    .header-right{
      width: 125px;
      height: 100%;
      flex-shrink: 0;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }
  .document-preview-content {
    flex: 1 1 auto;
    padding: 20px;
    .markdown-body {
      border-width: 1px 0 1px 0 !important;
    }
  }
}
</style>
