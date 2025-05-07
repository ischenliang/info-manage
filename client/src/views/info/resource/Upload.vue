<template>
  <div class="app-page page-upload" style="background: #f5f7f9;">
    <el-page-header @back="goBack" content="文件上传"></el-page-header>
    <div :class="'table ' + tableClass" style="align-items: center;display: flex;flex-direction: column;background: #f5f7f9;" v-if="type === 'file'">
      <h3 style="font-size: 18px;margin-bottom: 10px;">文件上传(<span style="color: #409EFF;">文件上传)</span></h3>
      <el-upload
        :multiple="true"
        action=""
        drag
        list-type="text"
        :show-file-list="true"
        :on-change="handleChange"
        :auto-upload="false"
        :file-list="fileList"
        :on-remove="handleRemove"
        :class="uploadClass">
          <i class="el-icon-upload"></i>
          <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
      </el-upload>
      <div style="margin-top: 10px;">
        <el-button
          type="primary"
          size="small"
          v-perms="'system:resource:upload'"
          :loading="loading"
          @click="upload">
          上传
        </el-button>
        <el-button type="danger" icon="el-icon-error" size="small" @click="cancel">取消</el-button>
      </div>
    </div>
    <div :class="'table ' + tableClass" style="align-items: center;display: flex;flex-direction: column;background: #f5f7f9;" v-if="type === 'folder'">
      <h3 style="font-size: 18px;margin-bottom: 10px;">资源上传(<span style="color: #409EFF;">文件夹上传</span>)</h3>
      <div class="folder-upload" @click="dispatchUpload">
        <i class="el-icon-upload"></i>
        <p>点击选择文件夹进行上传</p>
        <input ref="uploadFolder" type="file" name="file" multiple="multiple" webkitdirectory @change="folderChange($event)">
      </div>
      <ul class="folder-file-list" :style="listStyle">
        <li v-for="(item, index) in fileList" :key="index">
          <div>
            <i class="el-icon-document"></i>{{ item.name }}
          </div>
          <i class="el-icon-close" @click="deleteByIndex(index)"></i>
        </li>
      </ul>
      <div style="margin-top: 10px;">
        <el-button type="primary" icon="el-icon-upload" size="small" :disabled="disabled" @click="upload" :loading="loading">上传</el-button>
        <el-button type="danger" icon="el-icon-error" size="small" @click="cancel">取消</el-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ResourceUpload',
  computed: {
    uploadClass: function () {
      return this.fileList.length === 0 ? 'resource-upload' : 'resource-uploaded'
    },
    disabled: function () {
      if (this.fileList.length === 0) {
        return true
      } else {
        return false
      }
    },
    tableClass () {
      if (this.fileList.length > 0) {
        return ''
      } else {
        return 'flex-center'
      }
    },
    listStyle () {
      if (this.fileList.length > 0 && this.type === 'folder') {
        return { padding: '5px', marginTop: '10px' }
      } else {
        return ''
      }
    }
  },
  data () {
    return {
      fileList: [], // 文件列表
      loading: false,
      type: this.$route.query.type === undefined ? 'file' : this.$route.query.type
    }
  },
  methods: {
    goBack () {
      this.$router.go(-1)
    },
    // 当选择文件后触发
    handleChange (file, fileList) {
      this.fileList = fileList
    },
    // 文件删除时触发
    handleRemove (file, fileList) {
      this.fileList = fileList
    },
    // 自定义文件上传
    upload () {
      this.loading = true
      const formData = new FormData()
      this.fileList.forEach((file, index) => {
        formData.append('files', file.raw)
      })
      this.$http({
        name: 'UploadResource',
        requireAuth: true,
        params: {
          path: this.$route.query.path ? this.$route.query.path : '/'
        },
        headers: {
          'Content-Type': 'multipart/form-data'
        },
        data: formData
      }).then((res) => {
        this.fileList = []
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 触发 file 的点击事件
    dispatchUpload () {
      this.$refs.uploadFolder.click()
    },
    // 选择文件夹
    folderChange (event) {
      const arr = []
      for (var i = 0; i < event.target.files.length; i++) {
        const tmp = event.target.files[i]
        arr.push({
          name: tmp.name,
          percentage: 0,
          raw: tmp,
          size: tmp.size,
          status: 'ready'
        })
      }
      this.fileList = [...this.fileList, ...arr]
      // 然后去重
      const tmp = {}
      this.fileList = this.fileList.reduce((item, next) => {
        tmp[next.name] = tmp[next.name] ? '' : item.push(next)
        return item
      }, [])
      this.$refs.uploadFolder.value = ''
    },
    // 根据索引删除
    deleteByIndex (index) {
      this.fileList.splice(index, 1)
    },
    // 返回
    cancel () {
      this.$router.go(-1)
    }
  }
}
</script>

<style lang="scss">
  .page-upload {
    .el-page-header {
      flex-shrink: 0;
    }
    .flex-center {
      justify-content: center;
    }
    .folder-file-list {
      width: 700px;
      margin: 0;
      padding: 0;
      background-color: #FFFFFF;
      li{
        margin-top: 5px;
        height: 25px;
        color: #606266;
        font-size: 14px;
        position: relative;
        list-style: none;
        cursor: pointer;
        div{
          width: 100%;
          height: 100%;
          display: flex;
          align-items: center;
          overflow: hidden;
          text-overflow: ellipsis;
          display: -webkit-box;
          -webkit-line-clamp: 1;
          -webkit-box-orient: vertical;
          padding: 0 20px 0 10px;
          box-sizing: border-box;
          line-height: 25px;
          > i {
            margin-right: 7px;
          }
        }
        > i{
          display: none;
          position: absolute;
          top: 5px;
          right: 5px;
          cursor: pointer;
          opacity: .75;
          color: #606266;
        }
        &:hover{
          i.el-icon-close{
            display: block;
          }
          &{
            background-color: #f5f7fa;
          }
        }
      }
    }
  }
  .resource-upload .el-upload-list {
    margin: 0 !important;
    background: #fff !important;
    padding: 0 !important;
  }
  .resource-uploaded .el-upload-list {
    margin: 10px 0 !important;
    background: #fff !important;
    padding: 5px 10px !important;
    border-radius: 4px;
    // max-height: 200px;
    // overflow: auto;
  }
  .el-upload-dragger {
    width: 700px !important;
    height: 400px !important;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  // 文件夹
  .folder-upload{
    width: 700px;
    height: 400px;
    background-color: #fff;
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    box-sizing: border-box;
    position: relative;
    flex-shrink: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    cursor: pointer;
    &:hover{
      border-color: #409EFF;
    }
    > input[type="file"] {
      display: none;
    }
    .el-icon-upload{
      font-size: 67px;
      color: #C0C4CC;
      margin: 40px 0 16px;
      line-height: 50px;
    }
    p{
      color: #606266;
      font-size: 14px;
    }
  }
</style>
