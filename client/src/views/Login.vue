<template>
  <!-- 组件wrapper -->
  <div class="login_wrapper">
    <!-- <c-particles /> -->
    <div class="login-section">
      <div class="login-text">信息管理系统</div>
      <el-form :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="username">
          <el-input v-model="form.username" prefix-icon="el-icon-user" placeholder="账号"></el-input>
        </el-form-item>
        <el-form-item prop="password" style="margin-bottom: 10px;">
          <el-input v-model="form.password" prefix-icon="el-icon-lock" show-password placeholder="密码"></el-input>
        </el-form-item>
        <!-- 滑动验证 -->
        <!-- <el-form-item prop="password" style="margin-bottom: 5px;">
          <el-input v-model="form.password" prefix-icon="el-icon-lock" show-password></el-input>
        </el-form-item> -->
        <el-form-item prop="remember" style="text-align: left;margin-bottom: 10px;">
          <el-checkbox v-model="form.remember">记住密码</el-checkbox>
        </el-form-item>
        <el-form-item class="login_btn">
          <el-button :loading="loading" type="primary" @click.native="login">登录</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
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

<style lang="scss" scoped>
.login_wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  position: relative;
  background-image: url('../assets/img/bg.jpg');
  background-repeat: no-repeat;
  background-size: cover;
  text-align: center;
  .login-section {
    // background-color: rgba(0,0,0,0.2);
    background-color: #FFFFFF;
    border: 2px solid rgba(255,255,255,0.3);
    border-radius: 10px;
    width: 400px;
    min-height: 300px;
    padding: 0 50px 0px 50px;
    box-sizing: border-box;
    z-index: 1;
    .login-text{
      width: 100%;
      height: 60px;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 2.2rem;
      // color: #f2f2f2;
      color: #1e4874;
      margin: 20px 0;
      letter-spacing: 2px;
      text-shadow: 3px 3px 3px #e7e0de,
                   -2px -2px 2px #a1d4e7;
    }
    .login_btn{
      button{
        width: 100%;
      }
    }
    .el-form{
      padding-bottom: 10px;
      .el-input__icon{
        color: #111;
      }
      .el-input__inner{
        background-color: rgba(255,255,255,0.8);
        padding: 0 10px 0 35px;
        font-size: 17px !important;
      }
    }
  }
}
</style>
