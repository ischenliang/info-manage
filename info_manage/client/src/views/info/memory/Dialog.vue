<template>
  <div class="app-page">
    <div class="toolbar">
      <c-flex-auto />
      <el-button type="success" size="medium">保存</el-button>
      <el-button type="danger" size="medium">取消</el-button>
    </div>
    <div class="table" style="padding: 10px 15px;">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name"/>
        </el-form-item>
        <el-form-item label="标签" prop="tag">
          <el-input v-model="form.tag"/>
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
        tag: '',
        content: ''
      },
      editorOption: {
        placeholder: '编辑文章内容',
        modules: {
          toolbar: [
            ['bold', 'italic', 'underline', 'strike'], // 加粗，斜体，下划线，删除线
            ['blockquote', 'code-block'], // 引用，代码块
            [{ header: 1 }, { header: 2 }], // 标题，键值对的形式；1、2表示字体大小
            [{ list: 'ordered' }, { list: 'bullet' }], // 列表
            [{ script: 'sub' }, { script: 'super' }], // 上下标
            [{ indent: '-1' }, { indent: '+1' }], // 缩进
            [{ direction: 'rtl' }], // 文本方向
            [{ size: ['small', false, 'large', 'huge'] }], // 字体大小
            [{ header: [1, 2, 3, 4, 5, 6, false] }], // 几级标题
            [{ color: [] }, { background: [] }], // 字体颜色，字体背景颜色
            [{ font: [] }], // 字体
            [{ align: [] }], // 对齐方式
            ['clean'], // 清除字体样式
            ['image', 'video'] // 上传图片、上传视频
          ]
        }
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
      }
    }
  },
  methods: {
    onEditorChange ({ editor, html, text }) {
      console.log(html)
      this.content = html
    }
  }
}
</script>

<style lang="scss">
  .ql-snow .ql-picker-label::before{
    position: absolute !important;
  }
</style>
