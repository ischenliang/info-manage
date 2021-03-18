<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <el-form-item label="prop1" prop="prop1">
        <el-input v-model="form.prop1"></el-input>
      </el-form-item>
      <el-form-item label="prop2" prop="prop2">
        <el-input v-model="form.prop2"></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="primary" size="medium" @click="submit" :loading="loading">确定</el-button>
      <el-button type="danger" size="medium" @click="close">取消</el-button>
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
        prop1: '',
        prop2: ''
      },
      rules: {
        prop1: [{ required: true, message: '请输入prop1', trigger: 'blur' }]
      },
      loading: false
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
        name: 'AddUser',
        requireAuth: true,
        data: this.form
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
    // 编辑提交
    editSubmit () {
      this.$http({
        name: 'UpdateUser',
        requireAuth: true,
        data: this.form
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
    // 提交中间件
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
        name: 'GetUser',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    } else {
      // 这里面对一些不同的需求做判断，如：
      // 新增时：密码不填 修改时：密码不必填
      // this.$set(this.rules, 'password', [{ required: true, message: '请输入用户密码', trigger: 'blur' }])
    }
  }
}
</script>

<style lang="scss">
</style>
