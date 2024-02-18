<template>
  <div class="app-page">
    <div class="toolbar" style="flex: 0 0 3rem;">
      <el-page-header
        @back="$router.push({ path: '/info/project/list' })"
        :content="'项目图集'" />
      <c-flex-auto />
      <span>共 <b>{{ list.total }}</b> 张图片</span>
    </div>
    <div class="table" style="padding: 5px 10px 10px 5px;" v-loading="list.loading">
      <div class="image-list">
        <div class="image-item" v-for="(item, index) in list.data" :key="index" :title="item.name">
          <el-image
            :src="addPrefix(item.path)"
            :preview-src-list="list.srcList"
            lazy>
            <div slot="error" class="image-slot">
              <i class="el-icon-picture-outline"></i>
            </div>
          </el-image>
          <div class="image-item-cover" @click="itemDelete(item)">
            <span class="el-icon-delete"></span>
          </div>
        </div>
        <div class="image-item">
          <el-upload
            :multiple="false"
            action=""
            accept="image/apng,image/bmp,image/gif,image/jpeg,image/pjpeg,image/png,image/svg+xml,image/tiff,image/webp,image/x-icon"
            drag
            :show-file-list="false"
            :on-change="handleChange"
            v-loading="loading"
            :auto-upload="false">
              <i class="el-icon-plus"></i>
          </el-upload>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProjectImage',
  data () {
    return {
      list: {
        loading: false,
        data: [],
        srcList: [],
        total: 0
      },
      loading: false
    }
  },
  computed: {
    pid () {
      return this.$route.params.id ? this.$route.params.id : ''
    }
  },
  methods: {
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetProjectImages',
        requireAuth: true,
        params: {
          sort: 'mtime',
          order: 'desc',
          pid: this.pid
        }
      }).then(res => {
        this.list.data = res.data.data.data
        this.list.total = res.data.data.total
        this.list.srcList = res.data.data.data.map(item => {
          return this.addPrefix(item.path)
        })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    // 当选择文件后触发
    handleChange (file, fileList) {
      const formData = new FormData()
      formData.append('file', file.raw)
      formData.append('pid', this.pid)
      this.loading = true
      this.$http({
        name: 'AddProjectImage',
        requireAuth: true,
        data: formData
      }).then(res => {
        this.listGet()
        this.$notify.success(res.data.msg)
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
          name: 'DeleteProjectImage',
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
    // 添加前缀
    addPrefix (url) {
      return window.g.ip + url.replace(/\\/g, '/')
    }
  },
  created () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.image-list {
  display: flex;
  flex-wrap: wrap;
  .image-item {
    width: 360px;
    height: 220px;
    margin: 5px 0 0 5px;
    border: 1px dashed #d9d9d9;
    position: relative;
    cursor: pointer;
    .image-item-cover {
      width: 30px;
      height: 30px;
      background: rgba(0, 0, 0, 0.75);
      position: absolute;
      top: 0;
      right: 0;
      display: none;
      justify-content: center;
      align-items: center;
      border-radius: 0 0 0 4px;
      color: #fff;
      font-size: 18px;
      font-weight: bold;
    }
    &:hover {
      .image-item-cover {
        display: flex;
      }
    }
    &:last-child {
      border: none;
    }
    .el-image {
      width: 100%;
      height: 100%;
      .image-slot {
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 30px;
        color: #909399;
        background: #f5f7fa;
      }
    }
    .el-upload {
      .el-upload-dragger {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 360px;
        height: 220px;
        .el-icon-plus {
          font-size: 28px;
          color: #8c939d;
        }
      }
    }
  }
}
</style>
