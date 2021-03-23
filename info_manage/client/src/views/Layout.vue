<template>
  <div class="app-wrapper">
    <!-- <div class="sidebar-container has-logo"> -->
    <div class="sidebar-container">
      <div class="sidebar-logo-container">
        <label>个人信息管理系统</label>
      </div>
       <div class="el-scrollbar">
         <!-- unique-opened -->
        <el-menu
          :default-active="activeMenu"
          class="el-menu-vertical-demo"
          background-color="#304156"
          text-color="#C1CBD9"
          active-text-color="#409EFF"
          style="border-right: none;"
          router>
          <c-menu-item
            v-for="(item, index) in menus"
            :key="index + item.path"
            :item="item"
          />
          <!-- <el-menu-item index="/home">
            <i class="el-icon-s-home"></i>
            <span slot="title">首页</span>
          </el-menu-item>
          <el-submenu index="/monitor">
            <template slot="title">
              <i class="el-icon-video-camera-solid"></i>
              <span slot="title">系统监控</span>
            </template>
            <el-menu-item index="/monitor/job">
              <i class="el-icon-date"></i>
              <span>定时任务</span>
            </el-menu-item>
            <el-menu-item index="/monitor/server">
              <i class="el-icon-service"></i>
              <span>服务监控</span>
            </el-menu-item>
            <el-menu-item index="/monitor/cache">
              <i class="el-icon-data-line"></i>
              <span>缓存监控</span>
            </el-menu-item>
          </el-submenu>
          <el-submenu index="/info">
            <template slot="title">
              <i class="el-icon-takeaway-box"></i>
              <span slot="title">信息管理</span>
            </template>
            <el-menu-item index="/info/resource">
              <i class="el-icon-folder"></i>
              <span>文件管理</span>
            </el-menu-item>
            <el-menu-item index="/info/project">
              <i class="el-icon-s-grid"></i>
              <span>项目管理</span>
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
            <el-menu-item index="/info/collect">
              <i class="el-icon-collection"></i>
              <span>收藏管理</span>
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
          </el-submenu> -->
        </el-menu>
       </div>
    </div>
    <div class="main-container">
      <div class="app-header">
        <div class="navbar" style="display: flex;justify-content: flex-end;align-items: flex-end;">
          <el-button
            type="primary"
            size="small"
            @click="logout"
            style="margin-right: 25px;">退出</el-button>
        </div>
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
import { mapActions, mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters({
      menus: 'menus'
    }),
    activeMenu () {
      const route = this.$route
      const { meta, path } = route
      // 这样处理有个bug：如果不是list页面呢？待解决
      if (meta.active === '' && path.indexOf('list') !== -1) {
        return path.replace(/\/list/, '')
      }
      // 排除授权页的高亮
      if (path.indexOf('/system/permission') !== -1) {
        return '/system/role'
      }
      if (meta.active !== '') {
        return meta.active
      }
      return path
    }
  },
  methods: {
    ...mapActions({
      clear_info: 'user/CLEAR_INFO'
    }),
    logout () {
      this.$Cookies.remove('token')
      this.$Cookies.remove('uid')
      this.clear_info()
      this.$router.push({ path: '/login' })
    }
  }
}
</script>

<style lang="scss">
.el-submenu .el-menu-item {
  background-color: #1f2d3d !important;
}
</style>
