<template>
  <div class="password-item">
    <div class="password-item-type">
      <el-tag
        size="small"
        effect="dark"
        :type="item.type === 1 ? 'success' : 'primary'">
        {{ item.type === 1 ? '网站' : '软件' }}
      </el-tag>
    </div>
    <div class="password-item-content">
      <div class="password-item-name" @click="handleClick">
        {{ item.name }}
      </div>
      <div class="password-item-remark">{{ item.remark || '无备注' }}</div>
      <div class="password-item-line">
        <span class="item-label">账号:</span>
        <el-input size="mini" readonly :value="item.account" />
        <c-toggle-copy
          :copy.sync="copy.account"
          :text="item.account"
          style="margin-left: 5px;"></c-toggle-copy>
      </div>
      <div class="password-item-line">
        <span class="item-label">密码:</span>
        <el-input size="mini" readonly :value="passwordFormat">
          <template #suffix>
            <span class="visible-btn" @click="toggle">{{ look ? '隐藏' : '显示' }}</span>
          </template>
        </el-input>
        <c-toggle-copy
          :copy.sync="copy.password"
          :text="item.password"
          style="margin-left: 5px;"></c-toggle-copy>
      </div>
    </div>
    <div class="password-item-action">
      <slot></slot>
    </div>
  </div>
</template>

<script setup>
import { computed, reactive, watch, ref } from 'vue'

/**
 * 实例定义
 */
const props = defineProps({
  item: Object
})

/**
 * 变量定义
 */
const look = ref(false)
const copy = reactive({
  password: false,
  account: false
})
const passwordFormat = computed(() => {
  const password = props.item.password
  if (look.value) {
    return password
  }
  return password.replace(/[A-Za-z0-9-_@#*\\$!^&*\\(\\)+=;'"\\.,`~]/g, '*')
})


/**
 * 函数
 */
const toggle = () => {
  look.value = !look.value
}
// 打开
const handleClick = () => {
  const { type, url } = props.item
  if (type === 1) {
    window.open(url, '_blank')
  }
}
</script>

<style lang="scss">
.password-item {
  width: 100%;
  height: 203px;
  border-radius: 6px;
  border-style: solid;
  border-width: 1px;
  border-color: #e9ecef;
  position: relative;
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  transition: transform .3s;
  position: relative;
  cursor: pointer;
  &:hover {
    transform: translateY(-5px);
    box-shadow: 0px 0px 8px rgba(0, 0, 0, 0.1);
  }
  &-content {
    padding: 16px 16px 16px;
    flex: 1;
  }
  &-action {
    height: 42px;
    flex-shrink: 0;
    border-top: 1px solid #e9ecef;
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
    .password-action-item {
      flex: 1;
      display: flex;
      flex-direction: row;
      flex-wrap: nowrap;
      justify-content: center;
      align-items: center;
      color: #747a80;
      cursor: pointer;
      border-left: 1px solid #e9ecef;
      font-size: 16px;
      &:first-child {
        border-left: none;
      }
    }
  }
  &-type {
    position: absolute;
    right: 16px;
    top: 8px;
    text-align: right;
  }
  &-line {
    display: flex;
    align-items: center;
    margin-top: 10px;
    // padding: 0 5px;
    span.item-label {
      flex-shrink: 0;
      margin-right: 10px;
      font-size: 16px;
    }
    .el-input {
      .el-input__inner {
        padding: 0 12px;
        background: #F5F7FA !important;
      }
      &.el-input--suffix .el-input__inner {
        padding-right: 45px;
      }
      .el-input__suffix {
        width: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
        .el-input__suffix-inner {
          width: 100%;
          height: 100%;
          display: flex;
          justify-content: center;
          align-items: center;
        }
      }
    }
    .visible-btn {
      width: 33px;
      height: 18px;
      line-height: 18px;
      color: #fff;
      font-size: 12px;
      padding: 0;
      background-color: #b8c7e6;
      border-radius: 3px;
      user-select: none;
      cursor: pointer;
    }
  }
  &-remark {
    height: 20px;
    font-size: 14px;
    margin-top: 10px;
    color: #00000073;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;

  }
  &-name {
    font-size: 16px;
    font-weight: 600;
    color: #535353;
  }
}
</style>