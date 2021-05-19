<template>
  <div class="app-page" style="padding: 0;">
    <div class="toolbar" style="flex: 0 0 3rem;">
      <div class="menu-tags">
        <div
          :class="(current && current.id === item.id) ? 'menu-tag active' : 'menu-tag'"
          v-for="(item, index) in list.types"
          :key="index"
          @click="tagClick(item)">
          {{ item.name ? item.name : '全部收藏' }}
        </div>
      </div>
      <c-flex-auto />
      <el-button type="info" @click="toggle" size="small">列表模式</el-button>
    </div>
    <div class="table none-scroller" v-loading="list.loading">
      <div class="collect-list">
        <div class="collect-item" v-for="(item, index) in list.data" :key="index" @click="toPath(item)">
          <div class="collect-title">
            <el-image class="collect-icon">
              <div slot="error" class="image-slot">
                <i class="el-icon-picture-outline"></i>
              </div>
            </el-image>
            <div class="collect-name">{{ item.name }}</div>
          </div>
          <div class="collect-remark">{{ item.remark === null || item.remark === '' ? '暂无描述.....' : item.remark }}</div>
          <div class="collect-footer">
            <div>
              <el-tag type="success" size="mini" v-for="(tag, i) in setTags(item.tag)" :key="i">{{ tag }}</el-tag>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CollectPanel',
  props: {
    showTable: Boolean
  },
  data () {
    return {
      list: {
        loading: false,
        data: [],
        types: []
      },
      current: null
    }
  },
  methods: {
    // 切换模式
    toggle () {
      this.$emit('update:showTable', !this.showTable)
    },
    // 获取数据
    listGet () {
      this.list.loading = true
      this.$http({
        name: 'GetCollects',
        requireAuth: true,
        params: {
          page: 1,
          size: 10000,
          type: this.current === null ? '' : this.current.name
        }
      }).then(res => {
        this.list.data = res.data.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.list.loading = false
      })
    },
    tagClick (row) {
      this.current = row
      this.listGet()
    },
    // 格式化tags
    setTags (tag) {
      return tag.split(',')
    },
    // 前往网址地方
    toPath (item) {
      window.open(item.url, '_blank')
    },
    getTypes () {
      this.$http({
        name: 'GetCollectTypes',
        requireAuth: true,
        params: {
          page: 1,
          size: 10000,
          status: true
        }
      }).then(res => {
        this.list.types = [{
          id: 'a42asd2874a87sd',
          name: ''
        }, ...res.data.data.data]
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    this.listGet()
    this.getTypes()
  }
}
</script>

<style lang="scss">
.menu-tags {
  display: flex;
  flex-wrap: wrap;
  .menu-tag {
    padding: 4px 7px;
    font-size: 12px;
    // background: red;
    border-radius: 14px;
    margin: 0 7px 5px 0;
    border: 1px solid #c3c5cf;
    color: #3e3f65;
    cursor: pointer;
    &.active {
      color: #fff;
      background: #42b983;
      border: 1px solid #42b983;
    }
  }
}
.collect-list {
  display: flex;
  flex-wrap: wrap;
  width: 100%;
  height: 100%;
  align-content: flex-start;
  .collect-item {
    width: 250px;
    height: 122px;
    border: 1px solid #ddd;
    margin: 15px 7px 0 8px;
    border-radius: 6px;
    cursor: pointer;
    .collect-title {
      width: 100%;
      height: 50px;
      display: flex;
      align-items: center;
      padding: 5px;
      .collect-icon {
        width: 40px;
        height: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 30px;
        flex-shrink: 0;
        img {
          width: 100%;
          height: 100%;
        }
      }
      .collect-name {
        flex: 1 1 auto;
        height: 100%;
        font-size: 16px;
        color: #3273dc;
        font-weight: bold;
        line-height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }
    }
    .collect-remark {
      width: 100%;
      height: 40px;
      line-height: 20px;
      overflow: hidden;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      padding: 0 10px;
      font-size: 12px;
    }
    .collect-footer {
      width: 100%;
      height: 32px;
      padding: 4px 0 8px 0;
      > div {
        padding: 0 10px;
        overflow: auto;
        display: flex;
        flex-wrap: wrap;
        width: 100%;
        height: 100%;
        .el-tag {
          margin: 0 3px;
        }
      }
    }
  }
}
</style>
