<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <c-flex-auto />
      <el-button
        type="warning"
        size="medium"
        v-perms="'system:resource:upload'"
        @click="$router.push({ path: '/info/resource/upload', query: { path: list.filters.path } })">
        上传
      </el-button>
      <el-button
        type="primary"
        size="medium"
        v-perms="'system:user:add'"
        @click="visible = true">
        新增
      </el-button>
      <el-button
        type="danger"
        size="medium"
        @click="deleteSelected"
        :disabled="deleteDisabled">
        删除
      </el-button>
      <el-button
        type="success"
        size="medium"
        @click="moveVisible = true"
        :disabled="moveDisabled">
        移动
      </el-button>
      <el-button
        type="success"
        size="medium"
        @click="copyVisible = true"
        :disabled="copyDisabled">
        复制
      </el-button>
      <cDropdown :show.sync="show" />
    </div>
    <div class="my-breadcrumb" v-if="breadcrumbs.length > 1">
      <el-breadcrumb separator=">">
        <template v-for="(item, index) in breadcrumbs">
          <el-breadcrumb-item
            v-if="index < (breadcrumbs.length - 1)"
            :key="index"
            :to="{ path: '/info/resource/list', query: { path: setQueryPath(index) } }">
            {{ item }}
          </el-breadcrumb-item>
          <el-breadcrumb-item v-else :key="index">{{ item }}</el-breadcrumb-item>
        </template>
      </el-breadcrumb>
    </div>
    <div class="table">
      <el-table
        style="width: 100%;"
        height="100%"
        stripe
        ref="table"
        v-loading="list.loading"
        @selection-change="selectChange"
        @row-click="rowClick"
        :data="list.data"
        :row-style="rowStyle">
        <el-table-column type="selection" label="选择" width="60" align="center"/>
        <el-table-column label="类型" prop="extension" width="100" align="center">
          <template v-slot="{ row }">
            <img :src="setImg(row.extension, row.type)" alt="" style="width: 35px;height: 35px;" />
          </template>
        </el-table-column>
        <el-table-column v-if="show[0].value" label="名称" prop="name" min-width="160" align="center">
          <template v-slot="{ row }">
            <template v-if="row.editable">
              <div style="display: flex;">
                <el-input v-model="row.name" size="small" style="flex: 1 1 auto;" />
                <el-button type="success" icon="el-icon-check" size="mini" plain style="margin-left: 5px;"/>
                <el-button type="danger" icon="el-icon-close" size="mini" plain style="margin-left: 5px;"/>
              </div>
            </template>
            <template v-else>{{ row.name }}</template>
          </template>
        </el-table-column>
        <el-table-column v-if="show[1].value" label="路径" prop="path" min-width="160" align="center"/>
        <el-table-column v-if="show[2].value" label="大小" prop="size" width="80" align="center"/>
        <el-table-column v-if="show[3].value" label="扩展名" prop="extension" width="80" align="center">
          <template v-slot="{ row }">{{ row.extension === '' ? '-' : row.extension }}</template>
        </el-table-column>
        <el-table-column v-if="show[4].value" label="创建时间" prop="ctime" width="170" align="center"/>
        <el-table-column v-if="show[5].value" label="修改时间" prop="mtime" width="170" align="center"/>
        <el-table-column prop="download" label="下载"  width="80" align="center">
          <template v-slot="{ row }">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-download"
              title="下载"
              @click="itemDownload(row)" />
          </template>
        </el-table-column>
        <el-table-column label="操作" width="80" align="center">
          <template v-slot="{ row }">
            <el-dropdown style="margin-right: 10px;" trigger="click" @command="handleCommand">
              <el-button type="primary" size="mini">
                <i class="el-icon-more"></i>
              </el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item :command="() => moveFile(row)">移动到</el-dropdown-item>
                <el-dropdown-item :command="() => copyFile(row)">复制到</el-dropdown-item>
                <el-dropdown-item :command="() => itemEdit(row)">重命名</el-dropdown-item>
                <el-dropdown-item :command="() => itemDelete(row)">删除</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <com-dialog v-if="visible" :visible.sync="visible" @submit="listGet" :name.sync="name" />
    <c-resources v-if="moveVisible" :visible.sync="moveVisible" :title="'移动到'" @submit="moveSubmit" />
    <c-resources v-if="copyVisible" :visible.sync="copyVisible" :title="'复制到'" @submit="copySubmit" />
  </div>
</template>

<script>
import ComDialog from './Dialog'
export default {
  name: 'ResourceList',
  components: {
    ComDialog
  },
  data () {
    return {
      show: [
        { label: '名称', disabled: true, value: true },
        { label: '路径', disabled: false, value: true },
        { label: '大小', disabled: true, value: true },
        { label: '类型', disabled: true, value: true },
        { label: '创建时间', disabled: false, value: false },
        { label: '修改时间', disabled: false, value: true }
      ],
      list: {
        loading: false,
        filters: {
          path: this.$route.query.path === undefined ? '/' : this.$route.query.path
        },
        selected: []
      },
      name: '',
      breadcrumbs: [],
      visible: false,
      moveVisible: false,
      copyVisible: false,
      current: []
    }
  },
  computed: {
    deleteDisabled: function () {
      return !this.list.selected.length
    },
    moveDisabled () {
      return !this.current.length
    },
    copyDisabled () {
      return !this.current.length
    }
  },
  methods: {
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetResources',
        requireAuth: true,
        params: {
          path: this.list.filters.path
        }
      }).then(res => {
        this.list.data = res.data
        this.list.data.forEach(item => this.$set(item, 'editable', false))
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 选择回调
    selectChange (rows) {
      this.list.selected = rows.map(item => item.path)
      this.current = rows.map(item => item.path)
    },
    // 设置表格行样式
    rowStyle () {
      return {
        cursor: 'pointer'
      }
    },
    // 行被点击
    rowClick (row, column) {
      if (column.label !== '选择' && column.label !== '操作' && column.label !== '下载' && row.type === 'folder') {
        this.$router.push({ path: '/info/resource/list', query: { path: row.path } })
      }
    },
    // 更改
    itemEdit (row) {
      // this.name = row.path
      // this.visible = true
      this.$prompt('文件名称', '文件重命名', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputValue: row.name
      }).then(({ value }) => {
        console.log(value)
      }).catch(() => {})
    },
    // 下载
    itemDownload (row) {
      // 文件夹时:下载成zip包
      // 文件就直接下载文件
    },
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteResource',
          requireAuth: true,
          params: {
            path: row.path
          }
        }).then(res => {
          this.$notify.success(res.msg)
        }).catch(error => {
          this.$notify.error(error)
        }).finally(() => {
          this.listGet()
        })
      }).catch(() => {})
    },
    // 批量删除
    deleteSelected () {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.list.selected.forEach((item, index) => {
          this.$http({
            name: 'DeleteResource',
            requireAuth: true,
            params: {
              path: item
            }
          }).then(res => {
            if (index === this.list.selected.length - 1) {
              this.$notify.success(res.msg)
              this.list.selected = []
            }
          }).catch(error => {
            this.$notify.error(error)
          }).finally(() => {
            this.listGet()
          })
        })
      }).catch(() => {})
    },
    // 设置文件图标
    setImg (extension, type) {
      switch (type) {
        case 'folder':
          return require('@/assets/icon/folder.png')
        case 'file':
          if (extension !== '') {
            try {
              return require(`@/assets/icon/${extension}.png`)
            } catch (error) {
              return require('@/assets/icon/file.png')
            }
          } else {
            return require('@/assets/icon/folder.png')
          }
      }
    },
    // 设置面包屑的query参数
    setQueryPath (index) {
      const tmp = JSON.parse(JSON.stringify(this.breadcrumbs))
      if (index === 0) {
        return '/'
      } else {
        return '/' + tmp.slice(1).slice(0, index).join('/')
      }
    },
    // dropdown指令调用回调：传入方法，然后直接调用
    handleCommand (func) {
      func()
    },
    // 移动文件
    moveFile (row) {
      this.moveVisible = true
      this.current = [row.path]
    },
    // 移动回调
    moveSubmit (path) {
      this.$http({
        name: 'MoveResource',
        requireAuth: true,
        params: {
          path: path
        },
        data: this.current
      }).then(res => {
        this.$notify.success(res.msg)
        this.listGet()
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 复制文件
    copyFile (row) {
      this.copyVisible = true
      this.current = [row.path]
    },
    // 复制回调
    copySubmit (path) {
      this.$http({
        name: 'CopyResource',
        requireAuth: true,
        params: {
          path: path
        },
        data: this.current
      }).then(res => {
        this.$notify.success(res.msg)
        this.listGet()
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    this.listGet()
    if (this.$route.query.path === undefined || this.$route.query.path === '/') {
      this.breadcrumbs = ['全部文件']
    } else {
      this.breadcrumbs = [...['全部文件'], ...this.$route.query.path.split('/').slice(1)]
    }
  },
  // 解决：el-table抖动问题
  beforeUpdate () {
    this.$nextTick(() => {
      // 在数据加载完，重新渲染表格
      this.$refs.table.doLayout()
    })
  },
  watch: {
    $route (val) {
      if (val.query.path === undefined || val.query.path === '/') {
        this.list.filters.path = '/'
        this.breadcrumbs = ['全部文件']
      } else {
        this.list.filters.path = val.query.path
        this.breadcrumbs = [...['全部文件'], ...val.query.path.split('/').slice(1)]
      }
      this.listGet()
    }
  }
}
</script>

<style lang="scss">
  .my-breadcrumb {
    min-height: 20px;
    margin-bottom: 5px;
    .el-breadcrumb {
      line-height: 20px !important;
      font-size: 12px !important;
      .el-breadcrumb__inner {
        color: #666 !important;
      }
      .el-breadcrumb__inner a,.el-breadcrumb__inner.is-link{
        color: #09aaff !important;
      }
    }
  }
</style>
