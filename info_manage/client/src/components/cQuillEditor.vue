<template>
  <!-- 第一种 -->
  <!-- <quill-editor
    ref="myTextEditor"
    v-model="curContent"
    :options="editorOption"
    style="height: 500px;"
    @change="onEditorChange($event)"> -->
  <!-- 第二种 -->
  <quill-editor
    ref="myTextEditor"
    :value="content"
    :options="editorOption"
    @change="onEditorChange($event)">
  </quill-editor>
</template>

<script>
export default {
  name: 'cQuillEditor',
  props: {
    content: String,
    text: String
  },
  model: {
    prop: 'content',
    event: 'change'
  },
  data () {
    return {
      // 第一种
      // curContent: this.content,
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
      }
    }
  },
  methods: {
    onEditorChange ({ editor, html, text }) {
      this.$emit('change', html)
      this.$emit('update:text', text)
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
</style>
