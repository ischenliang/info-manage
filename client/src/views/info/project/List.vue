<template>
  <div class="app-page">
    <div class="toolbar">
      <el-input v-model="list.filters.search" placeholder="请输入内容" suffix-icon="el-icon-search" @input="listGet"/>
      <c-flex-auto />
    </div>
    <div class="table none-scroller" style="background: #f0f2f5;">
      <div class="project-list" v-loading="list.loading">
        <el-row>
          <el-col :xl="6" :lg="8" :md="12" :sm="24">
            <el-card class="project-item" shadow="hover">
              <div
                class="project-add el-icon-circle-plus-outline"
                title="新增项目"
                @click="$router.push({ path: '/info/project/add' })"></div>
            </el-card>
          </el-col>
          <el-col :xl="6" :lg="8" :md="12" :sm="24" v-for="(item, index) in list.data" :key="index">
            <el-card class="project-item" shadow="hover">
              <div class="project-name" :title="item.name">{{ item.name }}</div>
              <div class="project-desc">{{ item.description }}</div>
              <div class="project-deploy">
                部署地址：<a v-if="item.url" :href="item.url">{{ item.url }}</a><span v-else>暂未部署</span>
              </div>
              <div class="project-tags">
                <el-tag
                  size="small"
                  type="success"
                  v-for="(tag, index) in formatTags(item.tag)"
                  :key="tag + index">
                  {{ tag }}
                </el-tag>
              </div>
              <div class="project-info">
                <span><b>项目类别：</b>{{ formatType(item.type) }}</span>
                <span><b>项目状态：</b>{{ formatStatus(item.status) }}</span>
                <span><b>源代码：</b><i class="el-icon-download" @click="itemDownload(item)"></i></span>
              </div>
              <div class="project-other">
                <el-button
                  type="primary"
                  size="mini"
                  icon="el-icon-picture"
                  @click="$router.push({ path: `/info/project/image/${item.id}` })">
                  图集
                </el-button>
                <el-button
                  type="primary"
                  size="mini"
                  icon="el-icon-document"
                  @click="$router.push({ path: `/info/project/document/${item.id}` })">
                  文档
                </el-button>
                <el-button
                  type="primary"
                  size="mini"
                  icon="el-icon-s-claim"
                  @click="$router.push({ path: `/info/project/issues/${item.id}` })">
                  任务
                </el-button>
                <el-button
                  type="primary"
                  size="mini"
                  icon="el-icon-edit"
                  title="编辑"
                  @click="$router.push({ path: `/info/project/edit/${item.id}` })"/>
                <el-button
                  type="primary"
                  size="mini"
                  icon="el-icon-delete"
                  title="删除"
                  @click="itemDelete(item)"/>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProjectList',
  data () {
    return {
      list: {
        loading: false,
        filters: {
          search: ''
        },
        data: []
      }
    }
  },
  methods: {
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetProjects',
        requireAuth: true,
        params: {
          search: this.list.filters.search,
          sort: 'mtime',
          order: 'desc'
        }
      }).then(res => {
        this.list.data = res.data.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 删除
    itemDelete (row) {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteProject',
          requireAuth: true,
          paths: [row.id]
        }).then(res => {
          this.$notify.success(res.data.msg)
        }).catch(error => {
          this.$notify.error(error)
        }).finally(() => {
          this.listGet()
        })
      }).catch(() => {})
    },
    // 下载
    itemDownload (row) {
      this.$http({
        name: 'DownloadProject',
        params: {
          id: row.id,
          token: this.$Cookies.get('token')
        }
      }).then(res => {
        window.open(`${res.config.url}?id=${res.config.params.id}&token=${res.config.params.token}`, '_self')
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    formatTags (tags) {
      return tags.split(',')
    },
    formatType (type) {
      switch (type) {
        case 1:
          return '个人项目'
        case 2:
          return '内部项目'
        case 3:
          return '外包项目'
        default:
          return '未知项目'
      }
    },
    formatStatus (status) {
      switch (status) {
        case 1:
          return '开始'
        case 2:
          return '暂停'
        case 3:
          return '关闭'
        default:
          return '未知'
      }
    }
  },
  created () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.project-list {
  display: flex;
  flex-wrap: wrap;
  .el-col {
    padding: 0 5px 10px;
  }
  .project-item {
    width: 100%;
    border-color: #23b7e5 #afe7f9 #afe7f9 #afe7f9;
    border-width: 7px 1px 1px 1px;
    border-style: solid;
    // margin: 0 5px 10px 5px;
    height: 261px;
    cursor: pointer;
    position: relative;
    .project-name {
      width: 100%;
      height: 46px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      color: #7b7b7b;
      font-size: 24px;
      text-align: center;
      padding-bottom: 15px;
    }
    .project-desc {
      width: 100%;
      height: 46px;
      overflow: hidden;
      color: #676a6c;
      line-height: 23px;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
    }
    .project-deploy {
      width: 100%;
      margin-top: 5px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      span{
        color: #7d7676;
      }
    }
    .project-info {
      width: 100%;
      margin-top: 5px;
      text-align: center;
      line-height: 20px;
      font-size: 14px;
      overflow: hidden;
      word-break: keep-all;
      white-space: nowrap;
      span:not(last-child){
        margin-left: 15px;
      }
    }
    .project-tags {
      width: 100%;
      height: 24px;
      margin-top: 10px;
      text-align: center;
      overflow: auto;
      .el-tag {
        margin: 0 5px;
      }
    }
    .project-other {
      width: 100%;
      margin-top: 10px;
      text-align: center;
      overflow: hidden;
      word-break: keep-all;
      white-space: nowrap;
    }
    .el-card__body {
      width: 100%;
      height: 100%;
    }
    .project-add {
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 120px;
      color: #c7c7c7;
      &:hover {
        color: #23b7e5;
      }
    }
  }
}
</style>
