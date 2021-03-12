<template>
  <div style="width: 100%;height: 100%;display:flex;flex-direction: column;justify-content: center;align-items: center;user-select: none;">
    <div style="width: 100%;height: 400px;">
      <!-- <mavon-editor
        v-model="value"
        language="zh-CN"
        fontSize="14px"
        :scrollStyle="true"
        :boxShadow="true"
        :boxShadowStyle="'0 2px 12px 0 rgba(0, 0, 0, 0.1)'"
        :transition="true"
        :toolbarsBackground="'#ffffff'"
        :previewBackground="'#fbfbfb'"
        :subfield="false"
        :defaultOpen="'edit'"
        :placeholder="'请输入内容......'"
        :editable="true"
        :codeStyle="'code-github'"
        :toolbarsFlag="true"
        :navigation="false"
        :shortCut="true"
        :autofocus="false"
        :ishljs="true"
        :toolbars="toolbars"
        @change="handleHtmlCode"
        ref="md"
        @imgAdd="imgAdd"/> -->
        <c-fork-me />
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      value: '',
      toolbars: {
        bold: true, // 粗体
        italic: true, // 斜体
        header: true, // 标题
        underline: true, // 下划线
        strikethrough: true, // 中划线
        mark: true, // 标记
        superscript: true, // 上角标
        subscript: true, // 下角标
        quote: true, // 引用
        ol: true, // 有序列表
        ul: true, // 无序列表
        link: true, // 链接
        imagelink: true, // 图片链接
        code: true, // code
        table: true, // 表格
        fullscreen: true, // 全屏编辑
        readmodel: true, // 沉浸式阅读
        htmlcode: true, // 展示html源码
        help: true, // 帮助
        /* 1.3.5 */
        undo: true, // 上一步
        redo: true, // 下一步
        trash: true, // 清空
        save: true, // 保存（触发events中的save事件）
        /* 1.4.2 */
        navigation: true, // 导航目录
        /* 2.1.8 */
        alignleft: true, // 左对齐
        aligncenter: true, // 居中
        alignright: true, // 右对齐
        /* 2.2.1 */
        subfield: true, // 单双栏模式
        preview: true // 预览
      }
    }
  },
  methods: {
    handleChange (value) {
      console.log(value)
    },
    imgAdd (pos, file) {
      console.log(file)
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
    handleHtmlCode (status, value) {
      console.log(status, value)
    }
  }
}
</script>

<style lang="scss">
</style>
