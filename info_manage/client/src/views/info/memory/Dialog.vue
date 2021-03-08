<template>
  <div class="app-page">
    <div class="toolbar">
      <el-page-header
        @back="$router.push({ path: '/info/memory/list' })"
        :content="id === '' ? '新增备忘录' : '更新备忘录'" />
      <c-flex-auto />
      <el-button
        type="success"
        size="medium"
        @click="submit"
        :loading="loading">保存</el-button>
      <el-button type="danger" size="medium">取消</el-button>
    </div>
    <div class="table" style="padding: 10px 20px;">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
        <div class="form-inline">
          <el-form-item label="名称" prop="name">
            <el-input v-model="form.name"/>
          </el-form-item>
          <el-form-item label="重要性" prop="priority">
            <el-rate v-model="form.priority" show-text />
          </el-form-item>
        </div>
        <el-form-item label="标签" prop="tag" class="form-item-tags">
          <c-tags-input
            v-model="form.tag"
            :repeat="false"
            :type="'warning'"
            :theme="'dark'"
            :placeholder="'按enter键创建'" />
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <quill-editor
            ref="myTextEditor"
            v-model="form.content"
            :options="editorOption"
            style="height: 500px;"
            @change="onEditorChange($event)"></quill-editor>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MemoryDialog',
  data () {
    return {
      form: {
        name: '',
        tag: [],
        priority: 0,
        content: ''
      },
      editorOption: {
        placeholder: '请输入备忘录内容'
        // modules: {
        //   toolbar: [
        //     ['bold', 'italic', 'underline', 'strike'], // 加粗，斜体，下划线，删除线
        //     ['blockquote', 'code-block'], // 引用，代码块
        //     [{ header: 1 }, { header: 2 }], // 标题，键值对的形式；1、2表示字体大小
        //     [{ list: 'ordered' }, { list: 'bullet' }], // 列表
        //     [{ script: 'sub' }, { script: 'super' }], // 上下标
        //     [{ indent: '-1' }, { indent: '+1' }], // 缩进
        //     [{ direction: 'rtl' }], // 文本方向
        //     [{ size: ['small', false, 'large', 'huge'] }], // 字体大小
        //     [{ header: [1, 2, 3, 4, 5, 6, false] }], // 几级标题
        //     [{ color: [] }, { background: [] }], // 字体颜色，字体背景颜色
        //     [{ font: [] }], // 字体
        //     [{ align: ['left', 'center', 'right'] }], // 对齐方式
        //     ['clean'], // 清除字体样式
        //     ['image', 'video'] // 上传图片、上传视频
        //   ]
        // }
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        tag: [{ required: true, message: '请输入标签', trigger: 'blur' }],
        priority: [{ required: true, message: '请选择重要性', trigger: 'blur' }]
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
    onEditorChange ({ editor, html, text }) {
      this.content = html
      console.log(text)
    },
    // 新增提交
    addSubmit () {
      const data = JSON.parse(JSON.stringify(this.form))
      data.tag = data.tag.join(',')
      this.$http({
        name: 'AddMemory',
        requireAuth: true,
        data: data
      }).then(res => {
        this.$notify.success(res.msg)
        this.$router.push({ path: '/info/memory/list' })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 编辑提交
    editSubmit () {
      const tag = this.tags.find(item => {
        return item.id === this.form.tag
      })
      const account = JSON.parse(JSON.stringify(this.form))
      account.tag = {
        name: tag.name,
        icon: tag.icon
      }
      this.$http({
        name: 'UpdateAccount',
        requireAuth: true,
        data: account
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
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
    }
  }
}
</script>

<style lang="scss">
  .ql-snow .ql-picker-label::before{
    position: absolute !important;
  }
  .ql-snow .ql-color-picker .ql-picker-label svg, .ql-snow .ql-icon-picker .ql-picker-label svg {
    right: 4px;
    top: 0;
    position: absolute !important;
  }
  .form-item-tags {
    .el-form-item__content {
      line-height: 0 !important;
    }
  }
</style>
