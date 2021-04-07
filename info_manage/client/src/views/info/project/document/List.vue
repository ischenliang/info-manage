<template>
  <div class="app-page" style="padding: 0;">
    <div class="document">
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
        <div class="document-list c-scrollbar">
          <div
            v-for="(item, index) in list.data"
            :key="index"
            :class="current.id === item.id ? 'document-item active' : 'document-item'"
            @click="itemClick(item)">
            <div class="document-item-name">
              <span class="el-icon-document"></span>
              <span :title="item.name">{{ item.name }}</span>
            </div>
            <div class="document-item-delete el-icon-delete"></div>
          </div>
        </div>
      </div>
      <div class="document-right c-scrollbar"></div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProjectDocument',
  data () {
    return {
      list: {
        data: [],
        filters: {
          search: ''
        }
      },
      loading: false,
      current: null
    }
  },
  computed: {
    pid () {
      return this.$route.params.id ? this.$route.params.id : ''
    }
  },
  methods: {
    listGet () {
      this.$http({
        name: 'GetProjectDocument',
        requireAuth: true,
        params: {
          pid: this.pid
        }
      }).then(res => {
        this.list.data = res.data.data.data
        this.current = this.list.data[0]
      }).catch(error => {
        this.$notify.error(error)
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
          pid: this.pid
        }
      }).then(res => {
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
        this.listGet()
      })
    },
    // 点击节点
    itemClick (row) {
      this.current = row
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
    width: 240px;
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
        }
      }
    }
  }
  .document-right {
    flex: 1 1 auto;
    height: 100%;
    background: #fff;
  }
}
</style>
