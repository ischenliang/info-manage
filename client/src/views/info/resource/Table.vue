<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <c-flex-auto />
      <!-- <el-button type="info" @click="toggle" size="small" icon="el-icon-reading">面板</el-button> -->
      <el-button
        type="primary"
        size="small"
        v-perms="'system:resource:add'"
        @click="itemAdd">
        新增
      </el-button>
      <el-dropdown trigger="click" @command="handleCommond">
        <el-button
          type="warning"
          v-perms="'system:resource:upload'"
          style="margin: 0 10px;"
          size="small">
          上传
        </el-button>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item :command="() => toUpload('file')">文件上传</el-dropdown-item>
          <el-dropdown-item :command="() => toUpload('folder')">文件夹上传</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
      <el-button
        type="info"
        size="small"
        title="保存网路图片"
        v-perms="'system:resource:saveImg'"
        @click="itemSave">
        网络
      </el-button>
      <el-button
        type="danger"
        size="small"
        v-perms="'system:resource:delete'"
        @click="deleteSelected"
        :disabled="deleteDisabled">
        删除
      </el-button>
      <el-button
        type="success"
        size="small"
        v-perms="'system:resource:move'"
        @click="moveVisible = true"
        :disabled="moveDisabled">
        移动
      </el-button>
      <el-button
        type="success"
        size="small"
        v-perms="'system:resource:copy'"
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
          <el-breadcrumb-item v-else :key="'else-' + index">{{ item }}</el-breadcrumb-item>
        </template>
      </el-breadcrumb>
    </div>
    <div class="table">
      <el-table
        style="width: 100%;"
        height="100%"
        stripe
        ref="table"
        size="medium"
        v-loading="list.loading"
        @selection-change="selectChange"
        @row-click="rowClick"
        :data="list.data"
        :row-style="rowStyle">
        <el-table-column type="selection" label="选择" width="60" align="center"/>
        <el-table-column label="" prop="extension" width="100" align="center">
          <template v-slot="{ row }">
            <img :src="setImg(row.extension, row.type)" alt="" style="width: 30px;height: 30px;" />
          </template>
        </el-table-column>
        <el-table-column v-if="show[0].value" label="文件名" prop="name" min-width="200" align="left">
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
        <!-- <el-table-column v-if="show[1].value" label="路径" prop="path" min-width="160" align="center"/> -->
        <el-table-column v-if="show[2].value" label="大小" prop="size" width="100" align="center">
          <template v-slot="{ row }">{{ row.size | sizeFormat }}</template>
        </el-table-column>
        <el-table-column v-if="show[3].value" label="类型" prop="extension" width="100" align="center">
          <template v-slot="{ row }">{{ (row.extension === '' || row.type === 'folder') ? '文件夹' : row.extension }}</template>
        </el-table-column>
        <el-table-column v-if="show[4].value" label="创建时间" prop="mtime" width="160" align="center"/>
        <el-table-column v-if="show[5].value" label="修改时间" prop="ctime" width="160" align="center"/>
        <el-table-column prop="download" label="下载"  width="80" align="center">
          <template v-slot="{ row }">
            <el-button
              type="primary"
              size="mini"
              icon="el-icon-download"
              title="下载"
              v-perms="'system:resource:download'"
              @click="itemDownload(row)" />
          </template>
        </el-table-column>
        <el-table-column label="操作" width="300" align="center">
          <template v-slot="{ row }">
            <el-button @click="moveFile(row)" size="mini" type="info" v-perms="'system:resource:move'">移动</el-button>
            <el-button @click="copyFile(row)" size="mini" type="primary" v-perms="'system:resource:copy'">复制</el-button>
            <el-button @click="itemEdit(row)" size="mini" type="warning" v-perms="'system:resource:update'">重命名</el-button>
            <el-button @click="itemDelete(row)" size="mini" type="danger" v-perms="'system:resource:delete'">删除</el-button>
            <!-- <el-dropdown style="margin-right: 10px;" trigger="click" @command="handleCommand">
              <el-button type="primary" size="mini">
                <i class="el-icon-more"></i>
              </el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item
                  v-perms="'system:resource:move'"
                  :command="() => moveFile(row)">
                  移动到
                </el-dropdown-item>
                <el-dropdown-item
                  v-perms="'system:resource:copy'"
                  :command="() => copyFile(row)">
                  复制到
                </el-dropdown-item>
                <el-dropdown-item
                  v-perms="'system:resource:update'"
                  :command="() => itemEdit(row)">
                  重命名
                </el-dropdown-item>
                <el-dropdown-item
                  v-perms="'system:resource:delete'"
                  :command="() => itemDelete(row)">
                  删除
                </el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown> -->
          </template>
        </el-table-column>
      </el-table>
    </div>
    <c-resources v-if="moveVisible" :visible.sync="moveVisible" :title="'移动到'" @submit="moveSubmit" />
    <c-resources v-if="copyVisible" :visible.sync="copyVisible" :title="'复制到'" @submit="copySubmit" />
  </div>
</template>

<script>
import folder from './icon/folder.png'
import file from './icon/file.png'
export default {
  name: 'ResourceTable',
  props: {
    showTable: Boolean
  },
  data () {
    return {
      show: [
        { label: '名称', disabled: true, value: true },
        { label: '路径', disabled: false, value: true },
        { label: '大小', disabled: true, value: true },
        { label: '类型', disabled: true, value: true },
        { label: '创建时间', disabled: false, value: true },
        { label: '修改时间', disabled: false, value: true }
      ],
      list: {
        loading: false,
        filters: {
          path: this.$route.query.path === undefined ? '/' : this.$route.query.path,
          search: ''
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
    // 切换模式
    toggle () {
      this.$emit('update:showTable', !this.showTable)
    },
    handleCommond (func) {
      func()
    },
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetResources',
        requireAuth: true,
        params: {
          path: this.list.filters.path,
          search: this.list.filters.search
        }
      }).then(res => {
        const { data } = res.data
        this.list.data = [
          ...data.filter(item => item.type === 'folder').sort((a, b) => {
            const aTime = new Date(a.ctime).getTime()
            const bTime = new Date(b.ctime).getTime()
            return bTime - aTime
          }),
          ...data.filter(item => item.type === 'file').sort((a, b) => {
            const aTime = new Date(a.ctime).getTime()
            const bTime = new Date(b.ctime).getTime()
            return bTime - aTime
          })
        ]
        this.list.data.forEach(item => this.$set(item, 'editable', false))
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
        new Date().getTime()
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
    // 新增
    itemAdd () {
      const _this = this
      this.$prompt('文件夹名称', '新建文件夹', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputValue: '新建文件夹'
      }).then(({ value }) => {
        _this.$http({
          name: 'AddResource',
          requireAuth: true,
          data: value,
          params: {
            path: _this.$route.query.path ? _this.$route.query.path : '/'
          },
          headers: {
            'Content-Type': 'text/plain'
          }
        }).then(res => {
          _this.listGet()
          _this.$notify.success(res.data.msg)
        }).catch(error => {
          _this.$notify.error(error)
        })
      }).catch(() => {})
    },
    // 保存网络图片
    itemSave () {
      const _this = this
      this.$prompt('请输入图片地址', '保存网络图片', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputPattern: /^((ht|f)tps?):\/\/[\w\\-]+(\.[\w\\-]+)+([\w\-\\.,@?^=%&:\\/~\\+#]*[\w\-\\@?^=%&\\/~\\+#])?$/,
        inputErrorMessage: '图片地址格式不正确'
      }).then(({ value }) => {
        _this.$http({
          name: 'SaveResource',
          requireAuth: true,
          data: value,
          params: {
            path: _this.$route.query.path ? _this.$route.query.path : '/'
          },
          headers: {
            'Content-Type': 'text/plain'
          }
        }).then(res => {
          _this.listGet()
          _this.$notify.success(res.data.msg)
        }).catch(error => {
          _this.$notify.error(error)
        })
      }).catch(() => {})
    },
    // 更改
    itemEdit (row) {
      const _this = this
      this.$prompt('文件名称', '文件重命名', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputValue: row.name
      }).then(({ value }) => {
        _this.$http({
          name: 'UpdateResource',
          requireAuth: true,
          data: value,
          params: {
            path: row.path
          },
          headers: {
            'Content-Type': 'text/plain'
          }
        }).then(res => {
          _this.listGet()
          _this.$notify.success(res.data.msg)
        }).catch(error => {
          _this.$notify.error(error)
        })
      }).catch(() => {})
    },
    // 下载
    itemDownload (row) {
      // 文件夹时:下载成zip包
      // 文件就直接下载文件
      this.$http({
        name: 'DownloadResource',
        requireAuth: true,
        params: {
          path: row.path,
          token: this.$Cookies.get('token')
        },
        headers: {
          'Content-Type': 'application/octet-stream'
        }
      }).then(res => {
        window.open(`${res.url}?path=${res.params.path}&token=${res.params.token}`, '_self')
      }).catch(error => {
        this.$notify.error(error)
      })
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
          this.$notify.success(res.data.msg)
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
              this.$notify.success(res.data.msg)
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
          return folder
        case 'file':
          if (extension !== '') {
            try {
              return new URL(`./icon/${extension}.png`, import.meta.url).href
            } catch (error) {
              return file
            }
          } else {
            return folder
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
        // 方式二
        // return tmp.slice(0, index + 1).join('/')
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
        this.$notify.success(res.data.msg)
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
        this.$notify.success(res.data.msg)
        this.listGet()
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    toUpload (type) {
      this.$router.push({
        path: '/info/resource/upload',
        query: {
          path: this.$route.query.path,
          type
        }
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
  },
  filters: {
    sizeFormat (val) {
      if (val === 0) {
        return '-'
      }
      if (val / (1024 * 1024 * 1024 * 1024 * 1024) > 1) {
        return (val / (1024 * 1024 * 1024 * 1024 * 1024)).toFixed(2) + ' P'
      } else if (val / (1024 * 1024 * 1024 * 1024) > 1) {
        return (val / (1024 * 1024 * 1024 * 1024)).toFixed(2) + ' T'
      } else if (val / (1024 * 1024 * 1024) > 1) {
        return (val / (1024 * 1024 * 1024)).toFixed(2) + ' G'
      } else if (val / (1024 * 1024) > 1) {
        return (val / (1024 * 1024)).toFixed(2) + ' MB'
      } else if (val / 1024 > 1) {
        return (val / 1024).toFixed(2) + ' KB'
      } else {
        return (val / 1024).toFixed(2) + ' KB'
      }
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
