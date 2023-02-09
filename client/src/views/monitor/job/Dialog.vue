<template>
  <div class="app-page">
    <div class="toolbar">
      <el-page-header
        @back="$router.push({ path: '/monitor/job/list' })"
        :content="id === '' ? '新增定时任务' : '更新定时任务'" />
      <c-flex-auto />
      <el-button
        type="success"
        size="medium"
        @click="submit"
        :loading="loading">保存</el-button>
      <el-button
        type="danger"
        size="medium"
        @click="$router.push({ path: '/monitor/job/list' })">取消</el-button>
    </div>
    <div class="table" style="padding: 10px 20px;">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
        <el-form-item label="任务名称" prop="name">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <div class="form-inline">
          <el-form-item label="调用目标字符串" prop="invoke_target">
            <el-select v-model="form.invoke_target" style="width: 100%">
              <el-option label="task.notification" value="task.notification" />
              <el-option label="task.cleanupLog" value="task.cleanupLog" />
            </el-select>
          </el-form-item>
          <el-form-item prop="cron_expression">
            <span slot="label">
              cron表达式
              <el-tooltip class="item" effect="dark" content="https://www.cnblogs.com/cmt/p/14553189.html" placement="right">
                <i class="el-icon-question"></i>
              </el-tooltip>
            </span >
            <el-input v-model="form.cron_expression"></el-input>
          </el-form-item>
        </div>
        <div class="form-inline">
          <el-form-item label="通知邮箱" prop="email">
            <el-input v-model="form.email" placeholder="方便执行成功邮件通知"></el-input>
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-switch v-model="form.status"></el-switch>
            <span style="margin-left: 10px;">{{ form.status ? '启用' : '不启用' }}</span>
          </el-form-item>
        </div>
        <el-form-item label="通知内容" prop="content">
          <c-quill-editor
            v-model="form.content"
            style="height: 360px;"
            :placeholder="'请输入通知内容....'" />
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    id () {
      return this.$route.params.id === undefined ? '' : this.$route.params.id
    }
  },
  data () {
    return {
      form: {
        name: '',
        invoke_target: '',
        cron_expression: '',
        status: true,
        email: '',
        content: '通知内容...'
      },
      rules: {
        name: [{ required: true, message: '请输入任务名称', trigger: 'blur' }],
        invoke_target: [{ required: true, message: '请输入调用目标字符串', trigger: 'blur' }],
        cron_expression: [{ required: true, message: '请输入cron表达式', trigger: 'blur' }],
        email: [
          { required: true, message: '请输入邮箱', trigger: 'blur' },
          { type: 'email', message: '邮箱地址格式不正确', trigger: ['blur', 'change'] }
        ]
      },
      loading: false
    }
  },
  methods: {
    // 新增提交
    addSubmit () {
      this.$http({
        name: 'AddTask',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$router.push({ path: '/monitor/job/list' })
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 编辑提交
    editSubmit () {
      this.$http({
        name: 'UpdateTask',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$router.push({ path: '/monitor/job/list' })
        this.$notify.success(res.data.msg)
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
        name: 'GetTask',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data.data
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
