<template>
  <mavon-editor
    :value="content"
    language="zh-CN"
    fontSize="14px"
    :scrollStyle="scrollStyle"
    :boxShadow="boxShadow"
    :boxShadowStyle="'0 2px 12px 0 rgba(0, 0, 0, 0.1)'"
    :transition="true"
    :toolbarsBackground="'#ffffff'"
    :previewBackground="'#fbfbfb'"
    style="border: 1px solid #ccc;border-radius: 0;"
    :subfield="false"
    :defaultOpen="defaultOpen"
    :placeholder="'请输入内容......'"
    :editable="true"
    :codeStyle="'atom-one-dark'"
    :toolbarsFlag="toolbarsFlag"
    :navigation="true"
    :shortCut="true"
    :autofocus="false"
    :ishljs="true"
    :toolbars="toolbars"
    @change="handleChange"
    ref="md"
    @imgAdd="imgAdd"
    @imgDel="imgDel">
  </mavon-editor>
</template>

<script>
export default {
  name: 'cMavonEditor',
  props: {
    content: String,
    text: String,
    toolbarsFlag: {
      type: Boolean,
      default: true
    },
    defaultOpen: {
      type: String,
      default: 'edit'
    },
    boxShadow: {
      type: Boolean,
      default: false
    },
    scrollStyle: {
      type: Boolean,
      default: true
    }
  },
  model: {
    prop: 'content',
    event: 'change'
  },
  data () {
    return {
      toolbars: {
        bold: false, // 粗体
        italic: false, // 斜体
        header: false, // 标题
        underline: false, // 下划线
        strikethrough: false, // 中划线
        mark: false, // 标记
        superscript: false, // 上角标
        subscript: false, // 下角标
        quote: false, // 引用
        ol: false, // 有序列表
        ul: false, // 无序列表
        link: false, // 链接
        imagelink: false, // 图片链接
        code: false, // code
        table: false, // 表格
        fullscreen: true, // 全屏编辑
        readmodel: true, // 沉浸式阅读
        htmlcode: false, // 展示html源码
        help: true, // 帮助
        /* 1.3.5 */
        undo: false, // 上一步
        redo: false, // 下一步
        trash: false, // 清空
        save: false, // 保存（触发events中的save事件）
        /* 1.4.2 */
        navigation: true, // 导航目录
        /* 2.1.8 */
        alignleft: false, // 左对齐
        aligncenter: false, // 居中
        alignright: false, // 右对齐
        /* 2.2.1 */
        subfield: false, // 单双栏模式
        preview: false // 预览
      }
    }
  },
  methods: {
    // 图片文件添加回调事件
    imgAdd (pos, file) {
      // 第一步.将图片上传到服务器.
      var formdata = new FormData()
      formdata.append('image', file)
      // axios({
      //   url: 'server url',
      //   method: 'post',
      //   data: formdata,
      //   headers: { 'Content-Type': 'multipart/form-data' },
      // }).then((url) => {
      //   // 第二步.将返回的url替换到文本原位置![...](0) -> ![...](url)
      //   /**
      //  * $vm 指为mavonEditor实例，可以通过如下两种方式获取
      //  * 1. 通过引入对象获取: `import {mavonEditor} from ...` 等方式引入后，`$vm`为`mavonEditor`
      //  * 2. 通过$refs获取: html声明ref : `<mavon-editor ref=md ></mavon-editor>，`$vm`为 `this.$refs.md`
      //  */
      //   $vm.$img2Url(pos, url)
      // })
      this.$refs.md.$imglst2Url([[pos, 'https://camo.githubusercontent.com/1d4f37917e6048582d298221101eec3ac8b63181a5f7cb88d1aab6e3fff0ff27/68747470733a2f2f6e6f6465692e636f2f6e706d2f6d61766f6e2d656469746f722e706e673f646f776e6c6f6164733d7472756526646f776e6c6f616452616e6b3d747275652673746172733d74727565']])
    },
    // 图片文件删除回调事件
    imgDel (filename) {
      console.log(filename)
    },
    // 编辑区发生变化的回调事件
    handleChange (text, html) {
      this.$emit('change', text)
      this.$emit('update:text', html)
    }
  }
}
</script>

<style lang="scss">
.v-note-wrapper .v-note-op {
  border-bottom: 1px solid #ccc !important;
}
</style>
