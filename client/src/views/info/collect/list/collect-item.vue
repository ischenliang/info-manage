<template>
  <div class="collect-item">
    <div class="collect-item-square">
      <img :src="item.repository" alt="">
    </div>
    <div class="collect-item-tags">
      <el-tag size="small" type="success">{{ item.collect_type.name }}</el-tag>
    </div>
    <div class="collect-item-content">
      <div class="collect-content-title">{{ item.name }}</div>
      <div class="collect-content-count">{{ item.remark }}</div>
      <div class="collect-content-tags">
        <template v-if="item.tag">
          <el-tag
            v-for="(item, index) in tags"
            :key="'tag-' + index"
            size="mini">{{ item }}</el-tag>
        </template>
      </div>
      <div class="collect-content-time">
        创建时间: {{ item.ctime }}
      </div>
    </div>
    <div class="collect-item-action">
      <slot></slot>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({
  item: Object
})
const tags = computed(() => {
  return props.item.tag.split(',')
})
</script>

<style lang="scss">
$border: 1px solid #e9ecef;
$border-active: 1px solid #32cfaa;
$text-color: #747a80;
$text-color-active: #32cfaa;
@mixin border($active: false) {
  border-radius: 6px;
  border-style: solid;
  border-width: 1px;
  @if $active {
    border-color: #32cfaa;
  } @else {
    border-color: #e9ecef;
  }
}
.collect-item {
  height: 225px;
  @include border;
  position: relative;
  display: flex;
  flex-direction: column;
  cursor: pointer;
  transition: transform .3s;

  .collect-item-tip {
    width: 100%;
    height: 100%;
    color: #747a80;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;

    span {
      margin-right: 5px;
      font-size: 20px;
    }
  }

  .collect-item-square {
    height: 50px;
    width: 50px;
    line-height: 50px;
    transform: rotate(45deg);
    transition: all 0.5s ease;
    text-align: center;
    @include border;
    top: -25px;
    position: absolute;
    left: 10px;
    background: #fff;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;

    img {
      transform: rotate(-45deg);
      width: 30px;
      height: 30px;
    }
  }

  .collect-item-tags {
    position: absolute;
    right: 16px;
    top: 8px;
    text-align: right;

    .el-tag+.el-tag {
      margin-left: 5px;
    }
  }

  .collect-item-content {
    flex: 1;
    padding: 40px 16px 16px;
    position: relative;
    overflow: hidden;

    .collect-content-title {
      font-size: 16px;
      font-weight: 600;
      color: #535353;
    }

    .collect-content-count {
      margin-top: 10px;
      height: 40px;
      line-height: 20px;
      overflow: hidden;
      text-overflow: ellipsis;
      display: -webkit-box;
      box-orient: vertical;
      line-clamp: 2;
    }
    .collect-content-tags {
      margin-top: 5px;
      .el-tag {
        margin: 2px 4px 2px 0;
      }
    }
    .collect-content-time {
      // line-height: 20px;
      height: 20px;
      display: flex;
      align-items: center;
      font-size: 14px;
      margin-top: 5px;
      color: rgba(0, 0, 0, .45);

      .el-tag {
        margin-right: 5px;
        background-color: red !important;
        border-color: red !important;
      }
    }
  }

  .collect-item-action {
    height: 42px;
    flex-shrink: 0;
    border-top: $border;
    display: flex;
    flex-direction: row;

    .collect-action-item {
      flex: 1;
      display: flex;
      flex-direction: row;
      justify-content: center;
      align-items: center;
      color: $text-color;
      cursor: pointer;

      +.collect-action-item {
        border-left: $border;
      }
    }
  }

  &:hover {
    @include border(true);
    transform: translateY(-10px);

    .collect-item-square {
      @include border(true);
      // background: #32cfaa;

      // span {
      //   color: #fff;
      // }
    }

    // .collect-item-action {
    //   border-top: $border-active;

    //   .collect-action-item {
    //     color: $text-color-active;

    //     +.collect-action-item {
    //       border-left: $border-active;
    //     }
    //   }
    // }
  }
}
</style>