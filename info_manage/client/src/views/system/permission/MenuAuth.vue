<template>
  <div class="app-page" style="padding: 0;">
    <div class="table">
      <el-tree
        :data="list.data"
        show-checkbox
        node-key="id"
        :check-on-click-node="true"
        :expand-on-click-node="false"
        v-loading="list.loading"
        :default-expanded-keys="list.expandKeys"
        ref="tree"
        :props="{
          children: 'children',
          label: 'name'
        }">
      </el-tree>
    </div>
    <div class="pagination">
      <el-button type="primary" size="medium" @click="submit" :loading="loading">确认</el-button>
      <el-button type="danger" size="medium" @click="cancel">取消</el-button>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      list: {
        page: 1,
        size: 10000,
        data: [],
        loading: false,
        expandKeys: []
      },
      loading: false
    }
  },
  methods: {
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetMenus',
        requireAuth: true,
        params: {
          page: this.list.page,
          size: this.list.size
        }
      }).then(res => {
        this.list.data = res.data.data
        return this.$http({
          name: 'GetRole',
          requireAuth: true,
          paths: [this.$route.params.id]
        })
      }).then(res => {
        const keys = []
        res.data.rm.forEach(item => {
          keys.push(item.id)
        })
        this.$nextTick(() => {
          this.$refs.tree.setCheckedKeys(keys)
          this.list.expandKeys = keys
        })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 角色详情
    itemGet () {
      this.$http({
        name: 'GetRole',
        requireAuth: true,
        paths: [this.$route.params.id]
      }).then(res => {
        console.log(res)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 提交
    submit () {
      this.loading = true
      this.$http({
        name: 'UpdateRoleMenu',
        requireAuth: true,
        paths: [this.$route.params.id],
        data: this.$refs.tree.getCheckedKeys()
      }).then(res => {
        this.$notify.success(res.msg)
        this.listGet()
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 返回上一级
    cancel () {
      this.$router.go(-1)
    }
  },
  created () {
    this.listGet()
  }
}
</script>

<style>

</style>
