<template>
  <el-dialog
    :title="title"
    :visible.sync="visible"
    :before-close="close"
    :close-on-click-modal="false"
    class="resource-dialog">
    <div class="file-tree-container">
      <el-tree
        :props="props"
        :load="loadNode"
        lazy
        ref="tree"
        @node-click="nodeClick">
        <div class="el-tree-line" slot-scope="{ data }">
          <img :src="folder" alt="folder">
          {{ data.name }}
        </div>
      </el-tree>
    </div>
    <span slot="footer" class="dialog-footer">
      <el-button
        size="medium"
        plain
        icon="el-icon-folder-add"
        @click="addFolder"
        :loading="loading"
        style="float: left;">新建文件夹</el-button>
      <el-button type="primary" size="medium" @click="submit">确定</el-button>
      <el-button type="danger" size="medium" @click="close">取消</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: 'Resources',
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    title: {
      type: String,
      default: '浏览'
    }
  },
  data () {
    return {
      folder: require('@/assets/icon/folder.png'),
      props: {
        label: 'name',
        children: 'children',
        isLeaf: 'leaf'
      },
      current: null,
      currentNode: null,
      rootNode: null,
      rootResolve: null,
      loading: false
    }
  },
  methods: {
    close () {
      this.$emit('update:visible', false)
    },
    // 获取资源列表
    async listGet (path = '/') {
      const res = await this.$http({
        name: 'GetResources',
        requireAuth: true,
        params: {
          path
        }
      })
      res.data.forEach(item => {
        if (item.type === 'folder') {
          this.$set(item, 'leaf', false)
        }
      })
      return res.data.filter(item => item.type === 'folder')
    },
    // 获取文件列表
    async loadNode (node, resolve) {
      try {
        if (node.level === 0) {
          this.rootNode = node
          this.rootResolve = resolve
          return resolve(await this.listGet())
        } else {
          return resolve(await this.listGet(node.data.path))
        }
      } catch (error) {
        this.$notify.error(error)
      }
    },
    // 节点被点击
    nodeClick (data, node) {
      this.current = data
      this.currentNode = node
    },
    // 新增文件夹
    addFolder () {
      this.$prompt('文件夹名称', '新建文件夹', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputValue: '新建文件夹'
      }).then(({ value }) => {
        this.loading = true
        this.$http({
          name: 'AddResource',
          requireAuth: true,
          data: value,
          params: {
            path: this.current === null ? '/' : this.current.path
          },
          headers: {
            'Content-Type': 'text/plain'
          }
        }).then(async res => {
          if (this.current !== null) {
            // 设置loaded为false；模拟一次节点展开事件，加载重命名后的新数据
            this.currentNode.loaded = false
            this.currentNode.expand()
          } else {
            this.rootNode.childNodes = []
            this.loadNode(this.rootNode, this.rootResolve)
          }
        }).catch(error => {
          this.$notify.error(error)
        }).finally(() => {
          this.loading = false
        })
      }).catch(() => {})
    },
    // 提交
    submit () {
      this.$emit('submit', this.current.path)
      this.close()
    }
  },
  created () {
  }
}
</script>

<style lang="scss">
  .resource-dialog {
    border-radius: 4px !important;
    .el-dialog__header {
      padding: 10px 20px !important;
      border-bottom: 1px solid #D0DFE7;
      .el-dialog__title {
        font-size: 16px !important;
        color: #666 !important;
      }
      .el-dialog__headerbtn {
        top: 13px !important;
      }
    }
    .el-dialog__body {
      padding: 20px !important;
    }
    .file-tree-container{
      height: 200px;
      overflow: auto;
      .el-tree {
        .el-tree-node__content {
          height: 34px;
          >.el-tree-node__expand-icon {
            padding: 6px 10px 6px 6px;
          }
          .el-tree-line {
            display: flex;
            align-items: center;
            img {
              width: 22px;
              height: 18px;
              margin-right: 5px;
            }
          }
        }
        .el-tree-node__expand-icon.expanded {
          -webkit-transform: rotate(0deg);
          transform: rotate(0deg);
        }
        .el-icon-caret-right:before {
          content: "\e6d9";
          font-size: 12px;
          padding: 2px;
          border: 1px solid #ddd;
          color: #333;
        }
        .el-icon-caret-right.is-leaf:before {
          content: "";
          width: 16px;
          margin-left: 16px;
          border: none;
          font-size: 12px;
          padding: 2px;
          color: #333;
        }
        .el-tree-node__expand-icon.expanded.el-icon-caret-right:before{
          content: "\e6d8";
          font-size: 12px;
          padding: 2px;
          color: #333;
        }
      }
      /*滚动条整体样式*/
      &::-webkit-scrollbar {
        /*高宽分别对应横竖滚动条的尺寸*/
        width: 10px;
        height: 1px;
      }
      /*滚动条里面小方块*/
      &::-webkit-scrollbar-thumb {
        // box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        border-radius: 10px;
        background: #999999;
      }
      /*滚动条里面轨道*/
      &::-webkit-scrollbar-track, &::-moz-scrollbar-track {
        // box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        border-radius: 10px;
        background: #ffffff;
      }
    }
  }
</style>
