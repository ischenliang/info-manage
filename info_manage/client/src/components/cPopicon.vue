<template>
  <!-- 不设置title和content：然后设置下面的html代码，会显示在内容区 -->
  <div class="icon-body">
    <div style="width: 100%;margin-bottom: 8px;">
      <el-input v-model="name" placeholder="请输入图标名称" @input="filterIcons"></el-input>
    </div>
    <div class="icons-list">
      <template v-if="filters.length === 0">
        <span>暂无数据</span>
      </template>
      <template v-else v-for="(item, index) in filters">
        <div :key="index" @click="submit(item)" :class="item.value === icon ? 'active' : ''">
          <i :class="item.value" :title="item.value"></i>
          <span>{{ item.name }}</span>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    icon: String,
    visible: Boolean
  },
  data () {
    return {
      name: '',
      icons: [
        { name: '定位信息', value: 'el-icon-location-information' },
        { name: '删除', value: 'el-icon-delete' },
        { name: '首页', value: 'el-icon-s-home' },
        { name: '日期', value: 'el-icon-date' },
        { name: '权限', value: 'el-icon-lock' },
        { name: '文件夹(关闭)', value: 'el-icon-folder' },
        { name: '文件夹(打开)', value: 'el-icon-folder-opened' },
        { name: '设置', value: 'el-icon-setting' },
        { name: '图片(实心)', value: 'el-icon-picture' },
        { name: '图片(空心)', value: 'el-icon-picture-outline' },
        { name: '上传1', value: 'el-icon-upload' },
        { name: '上传2', value: 'el-icon-upload2' },
        { name: '下载', value: 'el-icon-download' },
        { name: '相机(空心)', value: 'el-icon-camera' },
        { name: '相机(实心)', value: 'el-icon-camera-solid' },
        { name: '通知(实心)', value: 'el-icon-message-solid' },
        { name: '通知(空心)', value: 'el-icon-bell' },
        { name: '合作', value: 'el-icon-s-cooperation' },
        { name: '显示器', value: 'el-icon-s-platform' },
        { name: '折叠', value: 'el-icon-s-fold' },
        { name: '展开', value: 'el-icon-s-unfold' },
        { name: '销售', value: 'el-icon-s-marketing' },
        { name: '评论', value: 'el-icon-s-comment' },
        { name: '柱状图', value: 'el-icon-s-data' },
        { name: '网格', value: 'el-icon-s-grid' },
        { name: '菜单', value: 'el-icon-menu' },
        { name: '分享', value: 'el-icon-share' },
        { name: '三角_左', value: 'el-icon-caret-left' },
        { name: '三角_右', value: 'el-icon-caret-right' },
        { name: '三角_下', value: 'el-icon-caret-bottom' },
        { name: '三角_上', value: 'el-icon-caret-top' },
        { name: '打印', value: 'el-icon-printer' },
        { name: '备忘录', value: 'el-icon-notebook-1' },
        { name: '用户(空心)', value: 'el-icon-user' },
        { name: '用户(实心)', value: 'el-icon-user-solid' },
        { name: '标签', value: 'el-icon-collection-tag' },
        { name: '收藏', value: 'el-icon-collection' },
        { name: '排序', value: 'el-icon-s-order' },
        { name: '事项', value: 'el-icon-tickets' },
        { name: '接口', value: 'el-icon-s-operation' }
      ],
      filters: []
    }
  },
  methods: {
    submit (row) {
      this.$emit('update:icon', row.value)
      this.$emit('update:visible', false)
      // 提交后应该将图标列表重置
      this.name = ''
      this.filterIcons()
    },
    filterIcons () {
      this.filters = this.icons.filter(item => {
        return item.name.indexOf(this.name) !== -1
      })
    }
  },
  created () {
    this.filters = this.icons
  }
}
</script>

<style lang="scss">
.icon-body{
  display: flex;
  height: 290px;
  flex-direction: column;
  .icons-list{
    width: 100%;
    height: 242px;
    display: flex;
    flex-wrap: wrap;
    align-content: flex-start;
    overflow: auto;
    > span {
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      color: rgba($color: #000000, $alpha: 0.5);
    }
    > div {
      width: 86px;
      height: 60px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      border-right: 1px solid #eee;
      border-bottom: 1px solid #eee;
      cursor: pointer;
      &:nth-child(1),
      &:nth-child(2),
      &:nth-child(3),
      &:nth-child(4),
      &:nth-child(5),
      &:nth-child(6){
        border-top: 1px solid #eee;
      }
      &:nth-child(6n + 1) {
        border-left: 1px solid #eee;
      }
      > i {
        font-size: 32px;
      }
      > span {
        display: block;
        width: 100%;
        height: 20px;
        line-height: 20px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        text-align: center;
        font-size: 12px;
        color: rgba(0, 0, 0, 0.5);
      }
    }
    > div.active {
      background: #009688;
      color: #fff;
      > span {
        color: #fff;
      }
    }
  }
}
</style>
