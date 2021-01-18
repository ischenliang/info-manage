<template>
  <el-dialog
    title="提示"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close">
    <span>这是一段信息</span>
    <span slot="footer" class="dialog-footer">
      <el-button type="danger" size="medium" @click="close">取 消</el-button>
      <el-button type="primary" size="medium">确 定</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  props: {
    visible: Boolean
  },
  methods: {
    close () {
      this.$emit('update:visible', false)
    }
  }
}
</script>

<style>

</style>
