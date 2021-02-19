<template>
  <div class="c-tags-input">
    <el-tag
      v-for="(item, index) in list"
      :key="index"
      closable
      size="medium"
      :disable-transitions="false"
      :type="type"
      :effect="theme"
      @close="handleClose(index)">
      {{item}}
    </el-tag>
    <el-input
      v-model="value"
      @keyup.enter.native="add"
      ref="Tagsinput"
      :placeholder="placeholder"></el-input>
  </div>
</template>

<script>
export default {
  props: {
    repeat: {
      type: Boolean,
      default: false
    },
    defaultList: {
      type: Array,
      default: null,
      required: true
    },
    placeholder: {
      type: String,
      default: '按enter键创建标签'
    },
    type: {
      type: String,
      default: 'info'
    },
    theme: {
      type: String,
      default: 'dark'
    }
  },
  // 给自定义组件添加v-model：https://cn.vuejs.org/v2/guide/components-custom-events.html#%E8%87%AA%E5%AE%9A%E4%B9%89%E7%BB%84%E4%BB%B6%E7%9A%84-v-model
  // 在这里定义了还需要在props中定义
  model: {
    prop: 'defaultList',
    event: 'handleChange'
  },
  data () {
    return {
      list: [],
      value: ''
    }
  },
  methods: {
    add () {
      if (this.value.trim() !== '') this.list.push(this.value)
      if (!this.repeat) {
        this.list = Array.from(new Set(this.list))
      }
      this.$emit('handleChange', this.list)
      this.value = ''
    },
    handleClose (index) {
      this.list.splice(index, 1)
      this.$emit('handleChange', this.list)
    }
  },
  mounted () {
    this.$nextTick(() => {
      this.list = this.defaultList
      this.$refs.Tagsinput.focus()
    })
  }
}
</script>

<style lang="scss">
  .c-tags-input {
    width: 100%;
    min-height: 40px;
    border: 1px solid #DCDFE6;
    display: flex;
    flex-wrap: wrap;
    border-radius: 4px;
    padding: 3px 4px;
    box-sizing: border-box;
    overflow: hidden;
    .el-tag {
      margin: 2px 0 2px 6px !important;
      align-content: flex-start;
    }
    .el-input {
      flex: 1;
      padding: 2px !important;
      input.el-input__inner {
        border: none !important;
        padding: 0 10px !important;
        height: 28px !important;
        min-width: 70px !important;
      }
    }
  }
</style>
