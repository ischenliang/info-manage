<template>
  <div class="app-wrapper">
    <div class="sidebar-container has-logo">
      <div class="sidebar-logo-container">
        <img src="../assets/img/logo.png" alt="" style="width: 100%;height: 100%;">
      </div>
       <div class="el-scrollbar">
        <el-menu
          default-active="/system/role"
          class="el-menu-vertical-demo"
          background-color="#304156"
          text-color="#C1CBD9"
          active-text-color="#409EFF"
          style="border-right: none;"
          router>
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
          </el-submenu>
          <el-menu-item index="/project">
            <i class="el-icon-s-grid"></i>
            <span slot="title">项目管理</span>
          </el-menu-item>
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

}
</script>

<style lang="scss">
</style>
