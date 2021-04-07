<template>
  <div class="document-edit" v-if="form">
    <div class="document-edit-header">
      <div class="header-left">
        <el-input v-model="form.name" />
      </div>
      <div class="header-right">
        <el-button type="primary" size="small" icon="el-icon-edit" @click="togglePreview">预览</el-button>
      </div>
    </div>
    <div class="document-edit-content">
      <c-mavon-editor
        v-model="form.text"
        :text.sync="form.content"
        style="width: 100%;height: 100%;"/>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProjectDocumentEdit',
  props: {
    preview: Boolean,
    document: Object
  },
  data () {
    return {
      form: null
    }
  },
  methods: {
    togglePreview () {
      // 此时应该先保存下，然后再预览
      this.$http({
        name: 'UpdateProjectDocument',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('update:preview', !this.preview)
        this.$emit('submit', this.form)
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    this.form = this.document
  }
}
</script>

<style lang="scss">
.document-edit {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: auto;
  .document-edit-header {
    width: 100%;
    height: 61px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
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
      .el-input__inner {
        border: none !important;
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
  .document-edit-content {
    flex: 1 1 auto;
    min-height: 500px;
    background: red;
    .markdown-body {
      border-width: 1px 0 1px 0 !important;
    }
  }
}
</style>
