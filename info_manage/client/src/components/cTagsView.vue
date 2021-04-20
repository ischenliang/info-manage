<template>
  <div class="tags-view">
    <div class="tags-view-list">
      <!--
        <el-scrollbar :native="false" ref="tagsview" id="tagsview" :vertical="false" style="height: 34px;">
       -->
      <!-- <el-scrollbar
        :native="false"
        ref="tagsview"
        id="tagsview"
        :noresize="true"
        :vertical="false"> -->
      <div class="my-tags" ref="tagsview" id="tagsview">
        <router-link
          tag="span"
          v-for="(item, index) in tags"
          :class="$route.path === item.path ? 'tags-view-item active' : 'tags-view-item'"
          :to="{ path: item.fullPath }"
          @contextmenu.native="handleContextMenu($event, item)"
          :key="index">
          {{ item.title }}
          <i v-if="item.path !== '/home'" class="el-icon-close" @click.stop="delTag(item)"></i>
        </router-link>
      </div>
      <!-- </el-scrollbar> -->
    </div>
    <el-dropdown class="tags-view-opt" trigger="hover" placement="bottom-start" @command="handleCommand">
      <span class="el-dropdown-link">
        更多操作<i class="el-icon-arrow-down el-icon--right"></i>
      </span>
      <el-dropdown-menu slot="dropdown" class="tags-view-dropdown">
        <el-dropdown-item :command="() => close('current')"><i class="el-icon-circle-close"></i>关闭当前</el-dropdown-item>
        <el-dropdown-item :command="() => close('other')"><i class="el-icon-circle-close"></i>关闭其他</el-dropdown-item>
        <el-dropdown-item :command="() => close('all')"><i class="el-icon-circle-close"></i>关闭所有</el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
    <div class="popover" :style="style" v-if="isShowPopover">
      <div class="popover-item" @click="refresh('current')">刷新页面</div>
      <div class="popover-item" v-if="current !== 'Home'" @click="closeTag('current')">关闭当前</div>
      <div class="popover-item" @click="closeTag('other')">关闭其他</div>
      <div class="popover-item" @click="closeTag('all')">关闭所有</div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  name: 'TagsView',
  data () {
    return {
      popoverLeft: 0,
      popoverTop: 0,
      isShowPopover: false,
      current: ''
    }
  },
  computed: {
    ...mapGetters(['menus', 'tags']),
    // 计算出鼠标右键弹窗距离
    style () {
      return {
        left: this.popoverLeft + 'px',
        top: this.popoverTop + 'px'
      }
    }
  },
  methods: {
    ...mapActions({
      add_tag: 'tagsview/add_tag',
      del_tag: 'tagsview/del_tag',
      del_other_tag: 'tagsview/del_other_tag',
      del_all_tag: 'tagsview/del_all_tag',
      del_cached_tag: 'tagsview/del_cached_tag'
    }),
    // 自定义鼠标右键功能
    handleContextMenu (event, tag) {
      // 阻止默认的右键内容弹出
      event.preventDefault()
      this.current = tag
      this.popoverLeft = event.clientX
      this.popoverTop = event.clientY
      this.isShowPopover = true // 显示自定义菜单栏
      document.body.addEventListener('click', () => {
        this.isShowPopover = false
        this.popoverLeft = 0
        this.popoverTop = 0
      })
    },
    // 关闭标签页
    closeTag (type) {
      switch (type) {
        case 'current':
          this.delTag(this.current)
          break
        case 'other':
          // 需要将固定的和当前的存起来，然后删除其他的
          this.del_other_tag({
            name: this.$route.name,
            params: this.$route.params,
            query: this.$route.query,
            title: this.$route.meta.title,
            path: this.$route.path,
            fullPath: this.$route.fullPath
          })
          break
        case 'all':
          this.del_all_tag()
          this.$router.push({ name: 'Home' })
          break
      }
    },
    // 删除tabs，同时需要将vuex中的也给删除
    delTag (tag) {
      const { name } = this.$route
      const index = this.tags.findIndex(item => item.name === tag.name)
      if (name === tag.name) {
        this.$router.push({ name: this.tags[index - 1].name })
      }
      this.del_tag(tag)
    },
    // 刷新页面
    refresh (type) {
      switch (type) {
        case 'current':
          this.del_cached_tag(this.current.name).then(() => {
            this.$nextTick(() => {
              this.$router.replace({
                path: '/redirect' + this.current.fullPath
              })
            })
          })
          break
        case 'all':
          break
      }
    },
    // 指令处理下拉
    handleCommand (func) {
      func()
    },
    // 下拉框的删除操作回调
    close (type) {
      if (type === 'current') {
        this.current = this.$route
      }
      this.closeTag(type)
    }
  },
  watch: {
    $route (val, old) {
      if (val.path.indexOf('/redirect') !== -1) {
        return
      }
      this.add_tag({
        name: val.name,
        params: val.params,
        query: val.query,
        title: this.$route.meta.title,
        path: this.$route.path,
        fullPath: this.$route.fullPath
      })
      this.$nextTick(() => {
        // 将当前高亮显示的显示在视图中
        document.getElementById('tagsview').getElementsByClassName('active')[0].scrollIntoView()
      })
    }
  },
  mounted () {
    this.add_tag({
      name: this.$route.name,
      query: this.$route.query,
      params: this.$route.params,
      title: this.$route.meta.title,
      path: this.$route.path,
      fullPath: this.$route.fullPath
    })
  }
}
</script>

<style lang="scss">
  .tags-view {
    width: 100%;
    height: 34px;
    display: flex;
    .tags-view-list {
      flex: 1 1 auto;
      overflow: hidden;
      height: 100%;
      .my-tags {
        width: 100%;
        height: 100%;
        overflow: auto hidden;
        white-space: nowrap;
        &::-webkit-scrollbar {/*滚动条整体样式*/
          width: 5px;/*高宽分别对应横竖滚动条的尺寸*/
          height: 1px;
        }
        &::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
          border-radius: 5px;
          box-shadow: inset 0 0 5px #caccce;
          background: #606a78;
        }
        /*滚动条里面轨道*/
        &::-webkit-scrollbar-track {
          box-shadow: inset 0 0 5px #caccce;
          border-radius: 5px;
          background: #c5c7ca;
        }
        .tags-view-item {
          display: inline-block;
          position: relative;
          cursor: pointer;
          height: 26px;
          line-height: 26px;
          border: 1px solid #d8dce5;
          color: #495060;
          background: #fff;
          padding: 0 8px;
          font-size: 12px;
          margin-left: 5px;
          margin-top: 4px;
          > .el-icon-close {
            width: 16px;
            height: 16px;
            line-height: 16px;
            vertical-align: middle;
            border-radius: 50%;
            text-align: center;
            transition: all .3s cubic-bezier(.645,.045,.355,1);
            transform-origin: 100% 50%;
          }
          &:last-of-type{
            margin-right: 15px;
          }
          // .router-link-exact-active
          &.active{
            background: #42b983 !important;
            border-color: #42b983 !important;
            color: #fff;
            > .el-icon-close {
              color: #fff;
            }
            // 实现那个小点点
            &:before {
              content: "";
              background: #fff;
              display: inline-block;
              width: 8px;
              height: 8px;
              border-radius: 50%;
              position: relative;
              margin-right: 2px;
            }
          }
        }
      }
      .el-scrollbar {
        width: 100%;
        height: 100%;
        .el-scrollbar__wrap {
          width: 100%;
          // height: calc(100% + 20px);
          height: 34px;
          overflow-x: scroll;
          overflow-y: hidden;
        }
        .el-scrollbar__wrap::-webkit-scrollbar {/*滚动条整体样式*/
          width: 5px;/*高宽分别对应横竖滚动条的尺寸*/
          height: 1px;
        }
        .el-scrollbar__wrap::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
          border-radius: 5px;
          box-shadow: inset 0 0 5px #caccce;
          background: #606a78;
        }
        /*滚动条里面轨道*/
        .el-scrollbar__wrap::-webkit-scrollbar-track {
          box-shadow: inset 0 0 5px #caccce;
          border-radius: 5px;
          background: #c5c7ca;
        }
        .el-scrollbar__view {
          white-space: nowrap;
          display: inline-block;
          height: 34px;
        }
        .tags-view-item {
          display: inline-block;
          position: relative;
          cursor: pointer;
          height: 26px;
          line-height: 26px;
          border: 1px solid #d8dce5;
          color: #495060;
          background: #fff;
          padding: 0 8px;
          font-size: 12px;
          margin-left: 5px;
          margin-top: 4px;
          > .el-icon-close {
            width: 16px;
            height: 16px;
            line-height: 16px;
            vertical-align: middle;
            border-radius: 50%;
            text-align: center;
            transition: all .3s cubic-bezier(.645,.045,.355,1);
            transform-origin: 100% 50%;
          }
          &:last-of-type{
            margin-right: 15px;
          }
          // .router-link-exact-active
          &.active{
            background: #42b983 !important;
            border-color: #42b983 !important;
            color: #fff;
            > .el-icon-close {
              color: #fff;
            }
            // 实现那个小点点
            &:before {
              content: "";
              background: #fff;
              display: inline-block;
              width: 8px;
              height: 8px;
              border-radius: 50%;
              position: relative;
              margin-right: 2px;
            }
          }
        }
      }
    }
    .tags-view-opt {
      flex-shrink: 0;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 0 15px;
      border-bottom: 1px solid #c9cbcd;
      .el-dropdown-link {
        cursor: pointer;
        color: #606266;
      }
      .el-icon-arrow-down {
        font-size: 14px;
      }
    }
  }
  .tags-view-dropdown {
    margin-top: -1px !important;
    .el-dropdown-menu__item{
      line-height: 25px !important;
    }
  }
  .popover {
    min-width: 80px;
    // height: 300px;
    position: fixed;
    background: #fff;
    padding: 5px 0;
    border-radius: 4px;
    box-shadow: 2px 2px 3px 0 rgb(0 0 0 / 30%);
    z-index: 99999;
    .popover-item {
      padding: 7px 16px;
      cursor: pointer;
      font-size: 12px;
      color: #333;
      &:hover {
        background: #eeeeee;
      }
    }
  }
</style>
