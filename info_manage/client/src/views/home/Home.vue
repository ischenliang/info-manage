<template>
  <div class="app-page">
    <div class="table">
      <el-menu
        :default-active="activeMenu"
        class="el-menu-vertical-demo"
        style="width: 100%;">
        <c-menu-item
          v-for="(item, index) in menus"
          :key="index + item.path"
          :item="item"
        />
      </el-menu>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  name: 'Home',
  data () {
    return {
    }
  },
  computed: {
    ...mapGetters({
      menus: 'menus'
    }),
    activeMenu () {
      const route = this.$route
      // const { meta, path } = route
      const { path } = route
      return path
    }
  }
}
</script>
