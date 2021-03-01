<template>
  <el-dialog
    :title="name === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <el-form-item label="文件夹名称" prop="name">
        <el-input v-model="form.name" placeholder="请输入文件夹名称"></el-input>
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
    name: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      form: {
        name: ''
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
      },
      loading: false
    }
  },
  computed: {
    path () {
      return this.$route.query.path ? this.$route.query.path : '/'
    }
  },
  methods: {
    close () {
      this.$emit('update:visible', false)
      this.$emit('update:name', '')
    },
    // 新增提交
    addSubmit () {
      this.$http({
        name: 'AddResource',
        requireAuth: true,
        data: this.form.name,
        params: {
          path: this.path
        },
        headers: {
          'Content-Type': 'text/plain'
        }
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
        name: 'UpdateResource',
        requireAuth: true,
        data: this.form.name,
        params: {
          path: this.name
        },
        headers: {
          'Content-Type': 'text/plain'
        }
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
          if (this.name === '' || this.name === undefined) {
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
        name: 'GetResource',
        requireAuth: true,
        params: {
          path: this.name
        }
      }).then(res => {
        this.form = res.data
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    if (this.name !== '') {
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
