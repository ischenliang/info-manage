<template>
  <div style="width: 100%;height: 100%;display:flex;flex-direction: column;justify-content: center;align-items: center;user-select: none;">
    <!-- <div style="width: 400px;">
      <c-tags-input
        v-model="list"
        :repeat="false"
        :type="'success'"
        :theme="'dark'"
        :placeholder="'按enter键创建'" />
    </div>
    <div style="width: 500px;height: 300px;position: relative;background: #ccc;margin-top: 10px;">
      <c-fork-me
        :href="'https://element.eleme.cn/#/zh-CN/component/tag'"
        :fill-color="'red'"
        :color="'#ccc'" />
    </div> -->
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
        <el-button type="primary" size="medium" @click="upload">上传</el-button>
      </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      list: ['vue'],
      fileList: [] // 文件列表
    }
  },
  methods: {
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
          pid: 'd624b995-8967-48e8-bcb3-1879aec83bbe'
        },
        headers: {
          'Content-Type': 'multipart/form-data'
        },
        data: formData
      }).then(() => {
        console.log('上传成功')
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  }
}
</script>

<style lang="scss">
</style>
