<template>
  <div v-if="item.meta.hidden === 1">
    <!-- 不止一个子节点 -->
    <el-submenu v-if="!hasOneShowingChild(item)" :index="item.path">
      <template slot="title">
        <i :class="item.meta.icon"></i>
        <span slot="title">{{ item.meta.title }}</span>
      </template>
      <c-menu-item
        v-for="(child, index) in item.children"
        :key="index + child.path"
        :item="child"
       />
    </el-submenu>
    <!-- 只有一个子节点 -->
    <!-- 需要排除外链的情况 -->
    <template v-else-if="parent">
      <el-menu-item v-if="item.meta.is_frame === 1" index="" @click.native="click">
        <i :class="item.meta.icon"></i>
        <span slot="title">{{ item.meta.title }}</span>
      </el-menu-item>
      <el-menu-item v-else :index="item.path">
        <i :class="item.meta.icon"></i>
        <span slot="title">{{ item.meta.title }}</span>
      </el-menu-item>
    </template>
  </div>
</template>

<script>
export default {
  name: 'cMenuItem',
  props: {
    item: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      parent: null
    }
  },
  methods: {
    // 只有一个可见子菜单
    hasOneShowingChild (item) {
      // 这里需要判断当前这个菜单项是否可见,如果根本就不可见,那就需要设置成父级高亮
      // 如果是可见,判断子菜单可见数量是否大于1
      const children = item.children.filter(item => item.meta.hidden)
      if (children.length <= 1) {
        // 当只有一个子菜单时，需要将当前父元素保存
        this.parent = item
        return true
      } else {
        return false
      }
    },
    click () {
      window.open(this.item.path, '_blank')
    }
  }
}
</script>

<style>

</style>
