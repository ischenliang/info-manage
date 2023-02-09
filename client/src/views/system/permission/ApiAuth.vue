<template>
  <div class="app-page" style="padding: 0;">
    <div class="toolbar">
      <el-button type="primary" size="medium" @click="handleSelect('all')">全选</el-button>
      <el-button type="primary" size="medium" @click="handleSelect('no')">全不选</el-button>
    </div>
    <div class="table">
      <el-tree
        show-checkbox
        node-key="id"
        :check-on-click-node="true"
        :expand-on-click-node="false"
        v-loading="list.loading"
        lazy
        :load="loadNode"
        ref="tree"
        :default-checked-keys="list.checkedKeys"
        :props="{
          children: 'children',
          label: 'name',
          isLeaf: 'leaf'
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
import { mapActions } from 'vuex'
export default {
  data () {
    return {
      list: {
        page: 1,
        size: 10000,
        data: [],
        loading: false,
        checkedKeys: []
      },
      loading: false
    }
  },
  methods: {
    ...mapActions({
      setPerms: 'user/SET_PERMS'
    }),
    async loadNode (node, resolve) {
      if (node.level === 0) {
        this.list.loading = true
        try {
          const res = await this.$http({
            name: 'GetApiTypes',
            requireAuth: true,
            params: {
              page: 1,
              size: 10000
            }
          })
          this.list.loading = false
          // 设置默认展开
          this.$nextTick(() => {
            node.childNodes.forEach(item => {
              item.expanded = true
              item.loadData()
            })
          })
          this.list.data = res.data.data.data
          return resolve(res.data.data.data)
        } catch (error) {
          this.$notify.error(error)
        }
      }
      if (node.level >= 1) {
        try {
          const res = await this.$http({
            name: 'GetApis',
            requireAuth: true,
            params: {
              page: 1,
              size: 10000,
              tid: node.data.id
            }
          })
          // 因为不涉及到更深层次的节点：所以这里就将二层节点设置为叶子节点，别忘记了设置 isLeaf: 'leaf' 的prop
          res.data.data.data.forEach(item => {
            this.$set(item, 'leaf', true)
          })
          node.data.children = res.data.data.data
          return resolve(res.data.data.data)
        } catch (error) {
          this.$notify.error(error)
        }
      }
    },
    // 详情
    itemGet () {
      this.$http({
        name: 'GetRole',
        requireAuth: true,
        paths: [this.$route.params.id]
      }).then(res => {
        const keys = []
        res.data.data.ra.forEach(item => {
          keys.push(item.id)
        })
        this.$nextTick(() => {
          this.$refs.tree.setCheckedKeys(keys)
        })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 提交
    submit () {
      // 这里需要排除第一层数据
      const keys = this.$refs.tree.getCheckedKeys()
      const tmp = []
      const result = []
      this.list.data.forEach(item => {
        tmp.push(item.id)
      })
      // 比较两个的差异性
      keys.forEach(key => {
        if (tmp.indexOf(key) === -1) {
          result.push(key)
        }
      })
      this.loading = true
      this.$http({
        name: 'UpdateRoleApi',
        requireAuth: true,
        paths: [this.$route.params.id],
        data: result
      }).then(async res => {
        this.$notify.success(res.data.msg)
        this.itemGet()
        // 这里需要重置下权限
        await this.setPerms()
      }).catch(error => {
        console.log(error)
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 返回上一级
    cancel () {
      this.$router.go(-1)
    },
    // 设置tree全选或全不选
    handleSelect (type) {
      switch (type) {
        case 'all':
          this.$nextTick(() => {
            this.$refs.tree.setCheckedNodes(this.list.data)
          })
          break
        case 'no':
          this.$nextTick(() => {
            this.$refs.tree.setCheckedKeys([])
          })
          break
      }
    }
  },
  created () {
    this.itemGet()
  }
}
</script>

<style>

</style>
