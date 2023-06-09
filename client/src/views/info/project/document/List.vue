<template>
  <div class="app-page" style="padding: 0;">
    <div class="document" v-loading="loading">
      <div class="document-left">
        <el-page-header
          style="padding-bottom: 10px;"
          @back="$router.push({ path: '/info/project/list' })"
          :content="'项目文档'" />
        <el-input v-model="list.filters.search" placeholder="输入关键字搜索文档" suffix-icon="el-icon-search" @input="listGet"/>
        <div class="document-title">
          <span>该项目所有文档</span>
          <el-button type="info" size="mini" icon="el-icon-plus" @click="itemAdd" :loading="loading">新增</el-button>
        </div>
        <div class="document-list c-scrollbar" v-if="list.data.length">
          <div
            v-for="(item, index) in list.data"
            :key="index"
            :class="current.id === item.id ? 'document-item active' : 'document-item'"
            @click="itemClick(item)">
            <div class="document-item-name">
              <span class="el-icon-document"></span>
              <span :title="item.name">{{ item.name }}</span>
            </div>
            <div class="document-item-delete el-icon-delete" @click.stop="itemDelete(item)"></div>
          </div>
        </div>
        <div class="document-list c-scrollbar" v-else>
          <span class="c-empty">暂无数据</span>
        </div>
      </div>
      <div class="document-right c-scrollbar" v-if="current" v-loading="detailLoading">
        <com-preview
          v-if="preview"
          :preview.sync="preview"
          :key="'preview-' + current.id"
          :document.sync="current"/>
        <com-edit
          v-else
          :preview.sync="preview"
          :document.sync="current"
          :key="'edit-' + current.id"
          @submit="handleSubmit"/>
      </div>
      <div class="document-right c-scrollbar" v-else>
        <span class="c-empty">暂无数据</span>
      </div>
    </div>
  </div>
</template>

<script>
// jzman simplicity-green
import 'juejin-markdown-themes/dist/vuepress.css'
import ComPreview from './Preview'
import ComEdit from './Edit'
export default {
  name: 'ProjectDocument',
  components: {
    ComPreview,
    ComEdit
  },
  data () {
    return {
      list: {
        data: [],
        filters: {
          search: ''
        }
      },
      loading: false,
      current: null,
      preview: true,
      detailLoading: false
    }
  },
  computed: {
    pid () {
      return this.$route.params.id ? this.$route.params.id : ''
    }
  },
  methods: {
    listGet () {
      this.loading = true
      this.$http({
        name: 'GetProjectDocuments',
        requireAuth: true,
        params: {
          pid: this.pid,
          search: this.list.filters.search
        }
      }).then(res => {
        this.list.data = res.data.data.data
        if (this.list.data.length) {
          this.current = res.data.data.data[0]
          this.itemClick(res.data.data.data[0])
        }
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 新增
    itemAdd () {
      this.loading = true
      this.$http({
        name: 'AddProjectDocument',
        requireAuth: true,
        data: {
          name: '未命名文档',
          content: '',
          text: '',
          pid: this.pid
        }
      }).then(res => {
        this.$notify.success(res.data.msg)
        // 直接手动操作数据，减少请求数量
        this.list.data.unshift({ id: res.data.data.id, name: res.data.data.name })
        this.itemClick(res.data.data)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteProjectDocument',
          requireAuth: true,
          paths: [row.id]
        }).then(res => {
          this.$notify.success(res.data.msg)
          // 删除完毕手手动处理数据，减少请求数量
          this.list.data.forEach((item, index) => {
            if (item.id === row.id) {
              this.list.data.splice(index, 1)
            }
          })
          this.itemClick(this.list.data[0])
        }).catch(error => {
          this.$notify.error(error)
        })
      }).catch(() => {})
    },
    // 点击节点
    itemClick (row) {
      // 这里获取数据
      this.detailLoading = true
      this.$http({
        name: 'GetProjectDocument',
        requireAuth: true,
        paths: [row.id]
      }).then(res => {
        this.current = res.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.detailLoading = false
      })
      this.preview = true
    },
    // 回调: 直接手动更新数据，减少请求调用次数
    handleSubmit (data) {
      this.list.data.forEach(item => {
        if (item.id === data.id) {
          item.name = data.name
        }
      })
    }
  },
  created () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.document {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: row;
  .document-left {
    width: 260px;
    height: 100%;
    background: #fff;
    flex-shrink: 0;
    border-right: 1px solid #ddd;
    padding: 10px;
    display: flex;
    flex-direction: column;
    .document-title{
      width: 100%;
      height: 30px;
      margin: 10px 0;
      line-height: 30px;
      font-weight: bold;
      font-size: 15px;
      color: #005980;
      display: flex;
      justify-content: space-between;
    }
    .document-list {
      overflow: auto;
      flex: 1 1 auto;
      width: 100%;
      .document-item {
        width: 100%;
        height: 30px;
        display: flex;
        cursor: pointer;
        color: #40485B;
        &.active{
          color: #42b983;
          background: #f4f6f8;
        }
        .document-item-name {
          flex: 1 1 auto;
          line-height: 30px;
          padding: 0 0 0 10px;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
          .el-icon-document {
            margin-right: 5px;
          }
        }
        .document-item-delete {
          width: 30px;
          height: 30px;
          text-align: center;
          flex-shrink: 0;
          line-height: 30px;
          font-size: 16px;
          color: #40485B;
          display: none;
        }
        &:hover {
          .document-item-delete {
            display: block;
          }
        }
      }
    }
  }
  .document-right {
    flex: 1 1 auto;
    height: 100%;
    background: #fff;
    overflow: hidden;
  }
}
</style>
