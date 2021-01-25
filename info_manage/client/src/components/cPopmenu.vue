<template>
  <!-- 不设置title和content：然后设置下面的html代码，会显示在内容区 -->
  <div class="menu-body">
    <el-tree
      :data="menus"
      show-checkbox
      node-key="id"
      ref="tree"
      :check-on-click-node="true"
      :expand-on-click-node="false"
      :check-strictly="true"
      :default-checked-keys="[id]"
      @check-change="handleChange"
      :props="{
        children: 'children',
        label: 'name'
      }">
    </el-tree>
  </div>
</template>

<script>
export default {
  props: {
    id: String,
    visible: Boolean
  },
  data () {
    return {
      name: '',
      menus: [],
      loading: false
    }
  },
  methods: {
    submit (row) {
      this.$emit('update:icon', row.value)
      this.$emit('update:visible', false)
    },
    listGet () {
      this.loading = true
      this.$http({
        name: 'GetMenus',
        params: {
          page: 1,
          size: 10000
        },
        requireAuth: true
      }).then(res => {
        this.menus = res.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 设置 el-tree 单选
    handleChange (data, checked, node) {
      if (checked) {
        this.$nextTick(() => {
          this.$refs.tree.setCheckedKeys([data.id])
          this.$emit('update:id', data.id)
          this.$emit('update:visible', false)
        })
      }
    }
  },
  created () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.menu-body{
  display: flex;
  height: 290px;
  flex-direction: column;
  overflow: auto;
  .el-tree .el-tree-node__expand-icon.expanded {
    -webkit-transform: rotate(0deg) !important;
    transform: rotate(0deg) !important;
  }
  .el-tree .el-tree-node__expand-icon.el-icon-caret-right:before {
    content: "\e723" !important;
    font-size: 16px !important;
    color: #1389BC !important;
  }
  .el-tree .el-tree-node__expand-icon.expanded.el-icon-caret-right:before{
    content: "\e722" !important;
    font-size: 16px !important;
    color: #1389BC !important;
  }
  .el-tree .el-tree-node__expand-icon.is-leaf.el-icon-caret-right:before {
    color: transparent !important;
    cursor: default !important;
  }
}
</style>
