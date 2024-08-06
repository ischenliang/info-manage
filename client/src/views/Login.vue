<template>
  <center-layout>
    <el-form :model="form" :rules="rules" ref="formRef">
      <el-form-item prop="username">
        <el-input v-model="form.username" prefix-icon="el-icon-user" placeholder="账号"></el-input>
      </el-form-item>
      <el-form-item prop="password" style="margin-bottom: 10px;">
        <el-input v-model="form.password" prefix-icon="el-icon-lock" show-password placeholder="密码"></el-input>
      </el-form-item>
      <el-form-item prop="remember" style="text-align: left;margin-bottom: 10px;">
        <el-checkbox v-model="form.remember">记住密码</el-checkbox>
      </el-form-item>
      <el-form-item class="login_btn">
        <el-button :loading="loading" type="primary" @click.native="login">登录</el-button>
      </el-form-item>
    </el-form>
    <p>
      还没有账号?
      <router-link to="/register" class="active-link">点此注册</router-link>
    </p>
  </center-layout>
</template>

<script>
import CenterLayout from './CenterLayout.vue'
export default {
  components: {
    CenterLayout
  },
  data () {
    return {
      // 表单
      form: {
        username: '',
        password: '',
        slide: false, // 滑动验证
        remember: true // 记住密码
      },
      // 表单验证规则
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 15, message: '用户名长度在3~15个字符之间', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 1, max: 15, message: '密码长度在1~15个字符之间', trigger: 'blur' }
        ]
      },
      // 按钮loading效果
      loading: false,
      expires: new Date(new Date().getTime() + 1000 * 60 * 60 * 24)
    }
  },
  computed: {
    path () {
      if (this.$route.query.redirect) {
        return this.$route.query.redirect
      }
      return '/'
    }
  },
  methods: {
    // 登录按钮点击
    login () {
      const formData = new FormData()
      formData.append('username', this.form.username)
      formData.append('password', this.form.password)
      // 获取登录表单实例,验证表单通过
      this.$refs.formRef.validate(valid => {
        if (!valid) {
          this.$msg.error('请按照要求填写表单')
        } else {
          this.loading = true
          this.$http({
            name: 'Login',
            data: formData,
            requireAuth: false
          }).then(res => {
            this.$Cookies.set('token', res.data.data.token, {
              expires: this.expires,
              sameSite: 'lax'
            })
            this.$Cookies.set('uid', res.data.data.user.id, {
              expires: this.expires,
              sameSite: 'lax'
            })
            this.$Cookies.set('user', JSON.stringify(res.data.data.user), {
              expires: this.expires,
              sameSite: 'lax'
            })
            this.$router.push({ path: this.path })
            this.$notify.success(res.data.msg)
          }).catch(error => {
            this.$notify.error(error)
          }).finally(() => {
            this.loading = false
          })
        }
      })
    }
  },
  mounted () {
    // 按 enter 键可以进行登录操作
    const _this = this
    document.onkeydown = (evt) => {
      if (evt.keyCode === 13) {
        _this.login()
      }
    }
  },
  beforeDestroy () {
    // 释放按键事件
    document.onkeydown = null
  },
  created () {
  }
}
</script>