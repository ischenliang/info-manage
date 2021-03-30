<template>
  <div class="app-wrapper">
    <!-- <div class="sidebar-container has-logo"> -->
    <div class="sidebar-container" :style="collapse === true ? { width: '64px' } : { width: '210px' }">
      <div class="sidebar-logo-container">
        <a href="/" class="sidebar-logo-link">
          <img src="../assets/logo.png" alt="logo" class="sidebar-logo" :style="{ marginRight: collapse ? '' : '5px' }">
          <span class="sidebar-title" v-if="!collapse">信息管理系统</span>
        </a>
      </div>
       <div class="el-scrollbar c-scrollbar">
         <!-- unique-opened -->
        <el-menu
          :default-active="activeMenu"
          background-color="#304156"
          text-color="#C1CBD9"
          :collapse="collapse"
          active-text-color="#409EFF"
          style="border-right: none;"
          collapse-transition
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
        <div class="app-navbar">
          <div class="app-hamburger" @click="collapse = !collapse">
            <span :class="collapse ? 'el-icon-s-unfold' : 'el-icon-s-fold'"></span>
          </div>
          <div class="app-breadbrumb">
            <c-bread-crumb />
          </div>
          <div class="app-rightmenu">
            <el-button
              type="primary"
              size="small"
              @click="logout">退出</el-button>
          </div>
        </div>
        <div class="app-tagsview">
          <c-tags-view></c-tags-view>
        </div>
      </div>
      <div class="app-main">
        <!-- 添加个key就能实现多个路由指向同一个组件缓存 -->
        <!-- 这样做的问题：当刷新某一个页面时，导致所有缓存页面都刷新了 -->
        <!-- <transition name="fade-transform" mode="out-in" v-if="cachedTags.includes($route.name)">
          <keep-alive>
            <router-view :key="key"></router-view>
          </keep-alive>
        </transition>
        <transition name="fade-transform" mode="out-in" v-if="!cachedTags.includes($route.name)">
          <router-view :key="key"></router-view>
        </transition> -->

        <!-- 这种方式对于共用一个组件的会失效: 原因是路由嵌套了三层，在使用的时候实际上应该搞第二层的组件名称 -->
        <keep-alive :include="cachedTags">
          <router-view :key="key"></router-view>
        </keep-alive>
      </div>
      <div class="app-copyright"></div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  data () {
    return {
      collapse: false
    }
  },
  computed: {
    cachedTags () {
      return this.$store.state.tagsview.cachedTags
    },
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
      if (path === '/home') {
        return '/'
      }
      // 排除授权页的高亮
      if (path.indexOf('/system/permission') !== -1) {
        return '/system/role'
      }
      if (meta.active !== '') {
        return meta.active
      }
      return path
    },
    key () {
      return this.$route.fullPath
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
