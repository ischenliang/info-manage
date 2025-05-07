<template>
  <!-- 组件wrapper -->
  <div class="center_wrapper">
    <!-- <c-particles /> -->
    <div class="center-section">
      <div class="center-title">信息管理系统</div>
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {}
  },
  methods: {
  }
}
</script>

<style lang="scss">
.center_wrapper {
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
  .center-section {
    background-color: #FFFFFF;
    border: 2px solid rgba(255,255,255,0.3);
    border-radius: 10px;
    width: 400px;
    min-height: 300px;
    padding: 0 50px 20px 50px;
    box-sizing: border-box;
    z-index: 1;
    .center-title{
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
      margin-bottom: 0px;
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
    .active-link {
      color: #ff2e44;
      text-decoration: none;
    }
  }
}
</style>
