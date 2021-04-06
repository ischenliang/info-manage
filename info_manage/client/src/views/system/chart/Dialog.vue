<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <el-form-item label="名称" prop="name">
        <el-input v-model="form.name"></el-input>
      </el-form-item>
      <el-form-item label="描述" prop="description">
        <el-input type="textarea" v-model="form.description"></el-input>
      </el-form-item>
      <el-form-item label="上传" prop="fileList">
        <div class="folder-upload" @click="dispatchUpload">
          <i class="el-icon-upload"></i>
          <p>点击选择文件夹进行上传</p>
          <input ref="uploadFolder" type="file" name="file" multiple="multiple" webkitdirectory @change="folderChange($event)">
        </div>
        <div v-if="form.fileList.length">{{ `已选择${form.fileList.length}个文件` }}</div>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="primary" size="medium" @click="submit" :loading="loading">确定</el-button>
      <el-button type="danger" size="medium" @click="close">取消</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  props: {
    visible: Boolean,
    id: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      form: {
        name: '',
        description: '',
        fileList: []
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
      },
      loading: false
    }
  },
  methods: {
    close () {
      this.$emit('update:visible', false)
      this.$emit('update:id', '')
    },
    // 新增提交
    addSubmit () {
      const formData = new FormData()
      formData.append('name', this.form.name)
      formData.append('description', this.form.description)
      this.form.fileList.forEach(item => {
        formData.append('files', item.raw)
      })
      this.$http({
        name: 'AddChart',
        requireAuth: true,
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 编辑提交
    editSubmit () {
      const formData = new FormData()
      formData.append('id', this.form.id)
      formData.append('name', this.form.name)
      formData.append('description', this.form.description)
      if (this.form.fileList.length) {
        this.form.fileList.forEach(item => {
          formData.append('files', item.raw)
        })
      }
      this.$http({
        name: 'UpdateChart',
        requireAuth: true,
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 提交中间件
    submit () {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.loading = true
          if (this.id === '' || this.id === undefined) {
            this.addSubmit()
          } else {
            this.editSubmit()
          }
        }
      })
    },
    // 获取数据
    listGet () {
      // 获取数据....
      this.$http({
        name: 'GetChart',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form.id = res.data.data.id
        this.form.name = res.data.data.name
        this.form.description = res.data.data.description
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 触发 file 的点击事件
    dispatchUpload () {
      this.$refs.uploadFolder.click()
    },
    // 选择文件夹
    folderChange (event) {
      const arr = []
      for (var i = 0; i < event.target.files.length; i++) {
        const tmp = event.target.files[i]
        arr.push({
          name: tmp.name,
          percentage: 0,
          raw: tmp,
          size: tmp.size,
          status: 'ready'
        })
      }
      this.form.fileList = arr
      this.$refs.uploadFolder.value = ''
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    } else {
      // 这里面对一些不同的需求做判断，如：
      // 新增时：密码不填 修改时：密码不必填
      this.$set(this.rules, 'fileList', [{ required: true, message: '请上传图表', trigger: 'blur' }])
    }
  }
}
</script>

<style lang="scss">
  // 文件夹
  .folder-upload{
    width: 560px;
    height: 150px;
    background-color: #fff;
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    box-sizing: border-box;
    position: relative;
    flex-shrink: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    cursor: pointer;
    &:hover{
      border-color: #409EFF;
    }
    > input[type="file"] {
      display: none;
    }
    .el-icon-upload{
      font-size: 67px;
      color: #C0C4CC;
      margin: 40px 0 16px;
      line-height: 50px;
    }
    p{
      color: #606266;
      font-size: 14px;
    }
  }
</style>
