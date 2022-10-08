<template>
  <div class="document-preview" v-if="document">
    <div class="document-preview-header">
      <div class="header-left">
        <div class="document-name">{{ document.name }}</div>
        <div class="document-time">
          <span>创建时间：{{ document.ctime }}</span>
          <span style="margin-left: 10px;">修改时间：{{ document.mtime }}</span>
        </div>
      </div>
      <div class="header-right">
        <el-button type="primary" size="small" icon="el-icon-edit" @click="togglePreview">编辑</el-button>
      </div>
    </div>
    <div class="document-preview-content markdown-body">
      <!-- <div v-html="document.content"></div> -->
      <c-mavon-preview
        v-model="document.text"
        :boxShadow="false"
        defaultOpen="preview"
        :toolbarsFlag="true"
        v-highlight
        style="width: 100%;height: 100%;border: none;"/>
    </div>
  </div>
</template>

<script>
// jzman simplicity-green
import 'juejin-markdown-themes/dist/vuepress.css'
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
      padding: 0 14px;
      width: 0px;
      flex-direction: column;
      justify-content: center;
      .document-name {
        font-size: 18px;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        font-weight: bold;
        color: #40485b;
      }
      .document-time {
        width: 100%;
        height: 20px;
        line-height: 20px;
        font-size: 12px;
        color: #999;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        margin-top: 5px;
      }
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
    padding: 0;
    overflow: auto;
    .markdown-body {
      border-width: 1px 0 1px 0 !important;
    }
  }
  .v-note-navigation-wrapper {
    background: #ffffff !important;
    border-left: 1px solid #e4e4e4 !important;
    .v-note-navigation-title {
      border-bottom: 1px solid #e4e4e4 !important;
      text-align: center !important;
      font-size: 16px !important;
      line-height: 40px !important;
      height: 40px !important;
      .v-note-navigation-close {
        display: none !important;
      }
    }
    .v-note-navigation-content {
      h1, h2, h3, h4, h5, h6 {
        color: #99a9bf !important;
        font-size: 14px !important;
        &:hover {
          color: #00c4b6 !important;
        }
      }
    }
  }
}
</style>
