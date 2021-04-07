<template>
  <div class="app-page">
    <div class="toolbar">
      <el-page-header
        @back="$router.push({ path: '/info/project/list' })"
        :content="id === '' ? '新增项目' : '更新项目'" />
      <c-flex-auto />
      <el-button
        type="success"
        size="medium"
        @click="submit"
        :loading="loading">保存</el-button>
      <el-button
        type="danger"
        size="medium"
        @click="$router.push({ path: '/info/project/list' })">取消</el-button>
    </div>
    <div class="table" style="padding: 10px 20px;">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
        <el-form-item label="项目名称" prop="name">
          <el-input v-model="form.name" placeholder="方便记忆的名称或代号"/>
        </el-form-item>
        <el-form-item label="项目描述" prop="description">
          <el-input type="textarea" v-model="form.description" :rows="7" placeholder="简单描述此项目的需求、目标、意义等。" />
        </el-form-item>
        <div class="form-inline">
          <el-form-item label="项目类型" prop="type">
            <div class="c-input">
              <el-radio v-model="form.type" :label="1">个人项目</el-radio>
              <el-radio v-model="form.type" :label="2">内部项目</el-radio>
              <el-radio v-model="form.type" :label="3">外包项目</el-radio>
            </div>
          </el-form-item>
          <el-form-item label="项目状态" prop="status">
            <div class="c-input">
              <el-radio v-model="form.status" :label="1">开始</el-radio>
              <el-radio v-model="form.status" :label="2">暂停</el-radio>
              <el-radio v-model="form.status" :label="3">关闭</el-radio>
            </div>
          </el-form-item>
        </div>
        <el-form-item label="部署地址" prop="url">
          <el-input v-model="form.url" placeholder="项目线上部署地址"/>
        </el-form-item>
        <el-form-item label="项目技术" prop="tag" class="form-item-tags">
          <c-tags-input
            v-model="form.tag"
            :repeat="false"
            :type="'warning'"
            :theme="'dark'"
            :focus="false"
            :placeholder="'按enter键创建'" />
        </el-form-item>
        <el-form-item label="项目源代码" prop="file">
          <el-upload
            :multiple="true"
            action=""
            accept=".zip,.rar,.7z,.tar,.gz"
            drag
            list-type="text"
            :show-file-list="false"
            :on-change="handleChange"
            :auto-upload="false">
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
          </el-upload>
          <div style="color: #747474;line-height: 20px;">接受.zip,.rar,.7z,.tar,.gz几种类型文件</div>
          <div v-if="form.file" style="line-height: 20px;">{{ `已选择1个文件` }}</div>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProjectDialog',
  data () {
    return {
      form: {
        name: '',
        description: '',
        tag: [],
        status: 1,
        url: '',
        type: 1,
        file: null
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        tag: [{ required: true, message: '请输入标签', trigger: 'blur' }],
        type: [{ required: true, message: '请选择项目类型', trigger: 'blur' }],
        status: [{ required: true, message: '请选择项目状态', trigger: 'blur' }]
      },
      loading: false
    }
  },
  computed: {
    id () {
      return this.$route.params.id ? this.$route.params.id : ''
    }
  },
  methods: {
    // 新增提交
    addSubmit () {
      const data = JSON.parse(JSON.stringify(this.form))
      const formData = new FormData()
      formData.append('name', data.name)
      formData.append('description', data.description)
      formData.append('type', data.type)
      formData.append('status', data.status)
      formData.append('url', data.url)
      formData.append('tag', data.tag.join(','))
      formData.append('file', this.form.file.raw)
      this.$http({
        name: 'AddProject',
        requireAuth: true,
        data: formData
      }).then(res => {
        this.$notify.success(res.data.msg)
        this.$router.push({ path: '/info/project/list' })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 编辑提交
    editSubmit () {
      const data = JSON.parse(JSON.stringify(this.form))
      const formData = new FormData()
      formData.append('id', data.id)
      formData.append('name', data.name)
      formData.append('description', data.description)
      formData.append('type', data.type)
      formData.append('status', data.status)
      formData.append('url', data.url)
      formData.append('tag', data.tag.join(','))
      if (this.form.file) {
        formData.append('file', this.form.file.raw)
      }
      this.$http({
        name: 'UpdateProject',
        requireAuth: true,
        data: formData
      }).then(res => {
        this.$notify.success(res.data.msg)
        this.$router.push({ path: '/info/project/list' })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 提交
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
        name: 'GetProject',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        const data = res.data.data
        this.form.name = data.name
        this.form.description = data.description
        this.form.tag = data.tag.split(',')
        this.form.url = data.url
        this.form.status = data.status
        this.form.type = data.type
        this.$set(this.form, 'id', data.id)
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 当选择文件后触发
    handleChange (file, fileList) {
      this.form.file = file
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    } else {
      this.$set(this.rules, 'file', [{ required: true, message: '请上传项目源代码', trigger: 'blur' }])
    }
  }
}
</script>

<style lang="scss">
  .form-item-tags {
    .el-form-item__content {
      line-height: 0 !important;
    }
  }
  .c-input{
    border: 1px solid #DCDFE6;
    height: 40px;
    border-radius: 4px;
    display: flex;
    align-items: center;
    padding: 0 15px;
  }
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
