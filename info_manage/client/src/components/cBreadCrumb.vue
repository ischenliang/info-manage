<template>
  <el-breadcrumb separator="/">
    <template v-for="(item, index) in breadcrumbs">
      <el-breadcrumb-item
        :key="index + item.name"
        v-if="index === breadcrumbs.length - 1">{{ item.title }}</el-breadcrumb-item>
      <el-breadcrumb-item
        :key="index + item.path"
        v-else
        :to="item.redirect || item.path">{{ item.title }}</el-breadcrumb-item>
    </template>
  </el-breadcrumb>
</template>

<script>
export default {
  name: 'cBreadCrumb',
  data () {
    return {
      breadcrumbs: []
    }
  },
  methods: {
    getBreadcrumb () {
      let matched = this.$route.matched
      if (matched[0] && matched[0].name !== 'Home') {
        matched = [{ path: '/home', meta: { title: '首页' }, name: 'Home' }].concat(matched)
      }
      this.breadcrumbs = matched.map(item => {
        return {
          name: item.name,
          path: item.path,
          title: item.meta.title,
          redirect: item.redirect
        }
      })
    }
  },
  created () {
    this.getBreadcrumb()
  },
  watch: {
    $route (to, from) {
      this.getBreadcrumb()
    }
  }
}
</script>

<style lang="scss">

</style>
