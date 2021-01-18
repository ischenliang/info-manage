<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
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
      <el-button type="primary" size="medium" @click="submit">确定</el-button>
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
      this.$emit('update:id', '')
    },
    // 新增提交
    addSubmit () {
      this.$http({
        name: 'AddRole',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
      }).catch(error => {
        this.$notify.error(error.message)
      })
    },
    // 编辑提交
    editSubmit () {
      this.$http({
        name: 'UpdateRole',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
      }).catch(error => {
        this.$notify.error(error.message)
      })
    },
    // 提交中间件
    submit () {
      this.$refs.form.validate(valid => {
        if (valid) {
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
      this.$http({
        name: 'GetRole',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data
      }).catch(error => {
        this.$notify.error(error.message)
      })
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    }
  }
}
</script>

<style>

</style>
