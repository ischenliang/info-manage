<template>
  <div class="app-wrapper">
    <!-- <div class="sidebar-container has-logo"> -->
    <div class="sidebar-container">
      <div class="sidebar-logo-container">
        <label>个人信息管理系统</label>
      </div>
       <div class="el-scrollbar">
        <el-menu
          :default-active="active"
          class="el-menu-vertical-demo"
          background-color="#304156"
          text-color="#C1CBD9"
          active-text-color="#409EFF"
          style="border-right: none;"
          router>
          <el-menu-item index="/home">
            <i class="el-icon-s-home"></i>
            <span slot="title">首页</span>
          </el-menu-item>
          <el-menu-item index="/project">
            <i class="el-icon-s-grid"></i>
            <span slot="title">项目管理</span>
          </el-menu-item>
          <el-menu-item index="/collect">
            <i class="el-icon-star-on"></i>
            <span>收藏管理</span>
          </el-menu-item>
          <el-submenu index="/info">
            <template slot="title">
              <i class="el-icon-takeaway-box"></i>
              <span slot="title">信息管理</span>
            </template>
            <el-menu-item index="/info/resource/list">
              <i class="el-icon-folder"></i>
              <span>文件管理</span>
            </el-menu-item>
            <el-menu-item index="/info/password">
              <i class="el-icon-lock"></i>
              <span>密码管理</span>
            </el-menu-item>
            <el-menu-item index="/info/memory">
              <i class="el-icon-document"></i>
              <span>备忘录管理</span>
            </el-menu-item>
            <el-menu-item index="/info/account">
              <i class="el-icon-s-marketing"></i>
              <span>账目管理</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="/system">
            <template slot="title">
              <i class="el-icon-setting"></i>
              <span>系统管理</span>
            </template>
            <el-menu-item index="/system/role">
              <i class="el-icon-s-check"></i>
              <span slot="title">角色管理</span>
            </el-menu-item>
            <el-menu-item index="/system/menu">
              <i class="el-icon-menu"></i>
              <span>菜单管理</span>
            </el-menu-item>
            <el-menu-item index="/system/user">
              <i class="el-icon-user"></i>
              <span>用户管理</span>
            </el-menu-item>
            <el-menu-item index="/system/api">
              <i class="el-icon-location"></i>
              <span>接口管理</span>
            </el-menu-item>
          </el-submenu>
        </el-menu>
       </div>
    </div>
    <div class="main-container">
      <div class="app-header">
        <div class="navbar"></div>
        <div class="tags-view"></div>
      </div>
      <div class="app-main">
        <router-view></router-view>
      </div>
      <div class="app-copyright"></div>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    active () {
      switch (this.$route.name) {
        case 'SystemPermission':
        case 'SystemEdit':
          return '/system/role'
        default:
          return this.$route.path
      }
    }
  }
}
</script>

<style lang="scss">
</style>
