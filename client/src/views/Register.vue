<template>
  <center-layout>
    <el-form :model="form" :rules="rules" ref="formRef">
      <el-form-item prop="username">
        <el-input v-model="form.username" prefix-icon="el-icon-user" placeholder="用户名"></el-input>
      </el-form-item>
      <el-form-item prop="nickname">
        <el-input v-model="form.nickname" prefix-icon="el-icon-postcard" placeholder="昵称"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input v-model="form.password" prefix-icon="el-icon-lock" show-password placeholder="密码"></el-input>
      </el-form-item>
      <el-form-item prop="rpassword">
        <el-input v-model="form.rpassword" prefix-icon="el-icon-lock" show-password placeholder="确认密码"></el-input>
      </el-form-item>
      <el-form-item class="login_btn">
        <el-button :loading="loading" type="primary" @click.native="register">注册</el-button>
      </el-form-item>
    </el-form>
    <p>
      已经有账号了? 
      <router-link to="/login" class="active-link">点此登录</router-link>
    </p>
  </center-layout>
</template>

<script>
import CenterLayout from './CenterLayout.vue'
import { useCrypto, useEncode64 } from '../utils/useCrypto'
export default {
  components: {
    CenterLayout
  },
  data () {
    return {
      // 表单
      form: {
        username: '',
        nickname: '',
        password: '',
        rpassword: ''
      },
      // 表单验证规则
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: ['blur', 'change'] },
          { min: 3, max: 15, message: '用户名长度在3~15个字符之间', trigger: ['blur', 'change'] }
        ],
        nickname: [
          { required: true, message: '请输入昵称', trigger: ['blur', 'change'] }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: ['blur', 'change'] },
          { min: 1, max: 15, message: '密码长度在1~15个字符之间', trigger: ['blur', 'change'] }
        ],
        rpassword: [
          { required: true, message: '请再次输入密码', trigger: ['blur', 'change'] },
          {
            trigger: ['blur', 'change'],
            validator: (rule, value, callback) => {
              if (value === '') {
                callback(new Error('请再次输入密码'));
              } else if (value !== this.form.password) {
                callback(new Error('两次输入密码不一致!'));
              } else {
                callback();
              }
            }
          }
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
    register () {
      // 获取登录表单实例,验证表单通过
      this.$refs.formRef.validate(valid => {
        if (!valid) {
          this.$msg.error('请按照要求填写表单')
        } else {
          this.loading = true
          useCrypto(this.form.password).then(res => {
            const { label, data: password_enc } = res
            const username_enc = useEncode64(this.form.username)
            this.$http({
              name: 'Register',
              data: {
                nickname: this.form.nickname,
                password: password_enc,
                label,
                username: username_enc
              },
              requireAuth: false
            }).then(res => {
              this.$router.push({ path: '/login' })
              this.$notify.success('账号注册成功！')
            }).catch(error => {
              this.$notify.error(error)
            }).finally(() => {
              this.loading = false
            })
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