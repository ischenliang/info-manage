<script>
export default {
  name: 'Redirect',
  // beforeCreate () {
  //   const { params, query } = this.$route
  //   const { path } = params
  //   this.$router.replace({ path: '/' + path, query })
  // },
  render (h) {
    return h() // 避免警告信息
  },
  // watch: {
  //   $route (val, old) {
  //     if (val.path.indexOf('redirect') !== -1) {
  //       const { params, query } = val
  //       const { path } = params
  //       this.$router.replace({ path: '/' + path, query })
  //     }
  //   }
  // },
  beforeRouteEnter (to, from, next) {
    next(vm => {
      vm.$router.replace({ path: from.path, query: to.query })
    })
  }
}
</script>
