<template>
  <div class="memory-item" @click="$router.push({ path: `/info/memory/detail/${item.id}` })">
    <div class="memory-item-select">
      <slot name="select"></slot>
    </div>
    <div class="memory-item-cover">
      <img :src="image[item.type]"/>
    </div>
    <div class="memory-item-info">
      <div class="item-info-title">{{ item.name }}</div>
      <div class="item-info-tags">
        <el-tag
          v-for="(item, index) in tags"
          :key="'tag-' + index"
          size="mini"
          type="primary">{{ item }}</el-tag>
      </div>
    </div>
    <div class="memory-item-action">
      <div class="action-fixed">
        <div class="action-time">{{ time }}</div>
        <el-tag size="mini" effect="dark" type="warning" v-if="item.priority == 0">置顶</el-tag>
      </div>
      <div class="action-btns">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, reactive } from 'vue';
import moment from 'moment'
import 'moment/dist/locale/zh-cn'
import rich from './images/rich.png'
import markdown from './images/markdown.png'

const image = reactive({
  1: rich,
  2: markdown
})

moment.locale('zh-cn')

const props = defineProps({
  item: Object
})

const tags = computed(() => {
  return props.item.tag.split(',')
})
const time = computed(() => {
  return moment(props.item.mtime).fromNow() + '更新'
})
</script>

<style lang="scss">
.memory-item {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  border-bottom: 1px solid #e9ecef;
  padding: 10px 20px;
  cursor: pointer;
  &-select {
    flex-shrink: 0;
    width: 30px;
    // background: #ddd;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  &-cover {
    width: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    img {
      width: 30px;
      height: 30px;
    }
  }
  &-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    .item-info-title {
      font-size: 16px;
      // font-weight: bold;
    }
    .item-info-tags {
      margin-top: 10px;
      .el-tag + .el-tag {
        margin-left: 8px;
      }
    }
  }
  &-action {
    flex-shrink: 0;
    width: 140px;
    display: flex;
    justify-content: flex-end;
    align-items: flex-end;
    position: relative;
    .action-fixed {
      position: absolute;
      top: 0;
      right: 0;
      display: flex;
      .action-time {
        font-size: 15px;
        color: #00000073;
      }
      .el-tag {
        margin-left: 10px;
      }
    }
  }
}
</style>