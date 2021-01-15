<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" @input="listGet"></el-input>
      <div style="flex: auto;"></div>
      <el-button type="primary" size="medium">新增</el-button>
      <el-button type="warning" size="medium">导出</el-button>
      <el-button type="danger" size="medium">删除</el-button>
      <!-- 考虑做成组件 -->
      <el-dropdown trigger="click" :hide-on-click="false" style="margin-left: 10px;">
        <el-button type="primary" size="medium">
          列<i class="el-icon-arrow-down el-icon--right"></i>
        </el-button>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item v-for="(item, index) in show" :key="index">
            <el-checkbox v-model="showItem[item.name]" :name="item.name" :disabled="item.disabled">{{ item.label }}</el-checkbox>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
    <div class="table">
      <el-table
        style="width: 100%;"
        height="100%"
        border
        stripe
        :data="list.data">
        <el-table-column type="selection" width="60" align="center"/>
        <el-table-column v-if="showItem.name" prop="name" label="角色名称" width="200" align="center" sortable="custom" />
        <el-table-column v-if="showItem.remark" prop="remark" label="备注" min-width="200" align="center" sortable="custom" />
        <el-table-column v-if="showItem.priority" prop="priority" label="显示顺序" width="120" align="center" sortable="custom" />
        <el-table-column v-if="showItem.status" prop="status" label="状态" width="120" align="center" sortable="custom" />
        <el-table-column v-if="showItem.ctime" prop="ctime" label="创建时间" width="170" align="center" sortable="custom" />
        <el-table-column v-if="showItem.mtime" prop="mtime" label="修改时间" width="170" align="center" sortable="custom" />
        <el-table-column label="操作" width="220" align="center">
          <template>
            <el-button type="primary" size="mini" icon="el-icon-edit" title="编辑" />
          </template>
        </el-table-column>
      </el-table>
    </div>
    <cPagination
      :total="list.total"
      :page.sync="list.page"
      :size.sync="list.size"
      @change="listGet" />
  </div>
</template>

<script>
export default {
  data () {
    return {
      // 用户动态绑定哪些元素需要展示
      showItem: {},
      // 用于dropdown的循环
      show: [],
      list: {
        total: 0,
        size: 10,
        page: 1,
        data: [],
        filters: {
          search: ''
        }
      }
    }
  },
  methods: {
    listGet () {
      this.$http({
        name: 'GetRoles',
        params: {
          status: true,
          page: this.list.page,
          size: this.list.size,
          search: this.list.filters.search
        }
      }).then(res => {
        this.list.total = res.total
        this.list.data = res.data
      }).catch(error => {
        console.log(error)
      })
    },
    setShow () {
      this.show = [
        { name: 'name', label: '角色名称', disabled: true },
        { name: 'remark', label: '备注', disabled: true },
        { name: 'priority', label: '显示排序', disabled: false },
        { name: 'status', label: '状态', disabled: false },
        { name: 'ctime', label: '创建时间', disabled: false },
        { name: 'mtime', label: '修改时间', disabled: false }
      ]
      this.showItem = {
        name: true,
        remark: true,
        priority: true,
        status: true,
        ctime: false,
        mtime: true
      }
    }
  },
  created () {
    this.setShow()
    this.listGet()
  }
}
</script>

<style>

</style>
