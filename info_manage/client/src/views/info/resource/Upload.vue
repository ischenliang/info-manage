<template>
  <div class="app-page">
    <el-page-header @back="goBack" content="文件列表"></el-page-header>
    <div class="table">
      <el-upload
        :multiple="true"
        action=""
        drag
        list-type="text"
        :show-file-list="true"
        :on-change="handleChange"
        :auto-upload="false"
        :file-list="fileList"
        :on-remove="handleRemove">
          <i class="el-icon-upload"></i>
          <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
      </el-upload>
      <div style="margin-top: 10px;">
        <el-button
          type="primary"
          size="medium"
          v-perms="'system:respurce:upload'"
          @click="upload">
          上传
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ResourceUpload',
  data () {
    return {
      fileList: [] // 文件列表
    }
  },
  methods: {
    goBack () {
      this.$router.go(-1)
    },
    // 当选择文件后触发
    handleChange (file, fileList) {
      this.fileList = fileList
    },
    // 文件删除时触发
    handleRemove (file, fileList) {
      this.fileList = fileList
    },
    // 自定义文件上传
    upload () {
      this.loading = true
      const formData = new FormData()
      this.fileList.forEach((file, index) => {
        formData.append('files', file.raw)
      })
      this.$http({
        name: 'UploadResource',
        requireAuth: true,
        params: {
          path: this.$route.query.path
        },
        headers: {
          'Content-Type': 'multipart/form-data'
        },
        data: formData
      }).then(() => {
        this.fileList = []
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  }
}
</script>

<style>

</style>
