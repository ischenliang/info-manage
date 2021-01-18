<template>
  <el-dialog
    title="新增"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <el-form-item label="角色名称" prop="name">
        <el-input v-model="form.name"></el-input>
      </el-form-item>
      <el-form-item label="优先级" prop="priority">
        <el-input-number v-model="form.priority" :min="1" :max="100"></el-input-number>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-switch v-model="form.status"></el-switch>
      </el-form-item>
      <el-form-item label="备注信息" prop="remark">
        <el-input type="textarea" v-model="form.remark" :rows="2"></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="danger" size="medium" @click="close">取消</el-button>
      <el-button type="primary" size="medium">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  props: {
    visible: Boolean
  },
  data () {
    return {
      form: {
        name: '',
        priority: 1,
        status: true,
        remark: ''
      },
      rules: {
        name: [
          { required: true, message: '请输入名称', trigger: 'blur' }
        ]
      }
    }
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
