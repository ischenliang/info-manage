<template>
  <!-- 组件wrapper -->
  <div class="login_wrapper">
    <vue-particles
        color="#fff"
        :particleOpacity="0.7"
        :particlesNumber="100"
        shapeType="circle"
        :particleSize="4"
        linesColor="#fff"
        :linesWidth="1"
        :lineLinked="true"
        :lineOpacity="0.6"
        :linesDistance="150"
        :moveSpeed="2"
        :hoverEffect="true"
        hoverMode="grab"
        :clickEffect="true"
        clickMode="push"
        class="lizi">
    </vue-particles>
    <div class="login-section">
      <!-- <div class="login-text">{{ $t('message.welcome') }}</div> -->
      <div class="login-text">信息管理系统</div>
      <el-form :model="logInForm" :rules="logInFormRules" ref="logInFormRef">
        <el-form-item prop="username">
          <el-input v-model="logInForm.username" prefix-icon="el-icon-user" class="input-item"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="logInForm.password" prefix-icon="el-icon-lock"  class="input-item" show-password></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="logInForm.password" prefix-icon="el-icon-lock"  class="input-item" show-password></el-input>
        </el-form-item>
        <el-form-item class="login_btn">
          <el-button :loading="loading" type="primary" @click.native="login">登录</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data () {
    return {
      // 登录表单信息
      logInForm: {
        username: '', // 用户名 默认值为''
        password: '' // 密码 默认值为''
      },
      // 登录表单验证规则
      logInFormRules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          {
            min: 3,
            max: 15,
            message: '用户名长度在3~15个字符之间',
            trigger: 'blur'
          }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          {
            min: 1,
            max: 15,
            message: '密码长度在1~15个字符之间',
            trigger: 'blur'
          }
        ]
      },
      loading: false
    }
  },
  methods: {
    ...mapActions({
      LOGIN: 'user/login'
    }),
    // 登录按钮点击
    login () {
      const formData = new FormData()
      formData.append('username', this.logInForm.username)
      formData.append('password', this.logInForm.password)
      // 获取登录表单实例,验证表单通过
      this.$refs.logInFormRef.validate(valid => {
        if (!valid) {
          this.$msg.error('请按照要求填写表单')
        } else {
          this.loading = true
          this.$request.ajax({
            name: 'Login',
            data: formData,
            requireAuth: false,
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }).then(res => {
            if (res.data.data !== null) {
              // 先保存一份数据在本地,为了解决 vuex 里的数据页面刷新丢失问题
              this.LOGIN({ name: res.data.data.name, token: res.data.token })
              this.$Cookies.set('token', res.data.token, {
                expires: new Date(new Date().getTime() + 1000 * 60 * 60 * 24),
                sameSite: 'lax'
              })
              this.$Cookies.set('Authorization', res.data.jsession, {
                expires: new Date(new Date().getTime() + 1000 * 60 * 60 * 24),
                sameSite: 'lax'
              })
              this.$Cookies.set('username', res.data.data.name, {
                expires: new Date(new Date().getTime() + 1000 * 60 * 60 * 24),
                sameSite: 'lax'
              })
              this.$router.replace({ path: '/home' })
              this.$msg.success('login')
            } else {
              this.$msg.error(res.data.message)
            }
          }).catch(error => {
            this.$msg.error(error)
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
    background-color: rgba(0,0,0,0.2);
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
      color: #f2f2f2;
      margin: 20px 0;
      letter-spacing: 2px;
      text-shadow: 3px 3px 3px #464140,
                   -3px -3px 3px #1d4d7e;
    }
    .login_btn{
      button{
        width: 100%;
      }
    }
    .el-input__icon{
      color: #111;
    }
    .el-input__inner{
      background-color: rgba(255,255,255,0.8);
      padding: 0 10px 0 35px;
      font-size: 17px !important;
    }
  }
  #particles-js{
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
  }
}
</style>
