<script>
export default {
  name: 'Redirect',
  // 这种方式会报错：TypeError: Cannot convert undefined or null to object
  // beforeCreate () {
  //   const { params, query } = this.$route
  //   const { path } = params
  //   this.$router.push({ path: '/' + path, query }).catch(error => error)
  // },

  // 一定要在created中使用，否则会出现页面不刷新
  created () {
    const { params, query } = this.$route
    const { path } = params
    this.$router.replace({ path: '/' + path, query }).catch(error => error)
  },
  render (h) {
    return h() // 避免警告信息
  },
  // 采用这种方式来解决上面的错
  // 但是使用这种方式会导致页面不刷新(之刷新一次，其后就不刷新了)
  beforeRouteEnter (to, from, next) {
    next()
    // next(vm => {
    //   // 通过 `vm` 访问组件实例
    //   vm.$router.push({ path: from.path, query: to.query })
    // })
    // next({ path: `/${to.params.path}`, query: to.query })
  }
}
</script>
