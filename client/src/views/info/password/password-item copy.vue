<template>
  <div class="password-item">
    <div class="password-item-type">
      <el-tag size="small" type="success">网站</el-tag>
    </div>
    <div class="password-item-content">
      <div class="password-item-name">七牛云图床</div>
      <div class="password-item-remark">
        世界杯体彩竞猜世界杯体彩竞猜世界杯体彩竞猜世界杯体彩竞猜
      </div>
      <div class="password-item-line">
        <span class="item-label">账号:</span>
        <el-input size="mini" disabled value="Kl-q6_6YIUmC3vD6N4_BxtbWAjlXrGLONzzd0MFN" />
        <c-toggle-copy :copy="false" :text="'1234'" style="margin-left: 5px;"></c-toggle-copy>
      </div>
      <div class="password-item-line">
        <span class="item-label">密码:</span>
        <el-input size="mini" disabled value="Kl-q6_6YIUmC3vD6N4_BxtbWAjlXrGLONzzd0MFN">
          <template #suffix>
            <span class="visible-btn">显示</span>
          </template>
        </el-input>
        <c-toggle-copy :copy="false" :text="'1234'" style="margin-left: 5px;"></c-toggle-copy>
      </div>
    </div>
    <div class="password-item-action">
      <div class="password-action-item">编辑</div>
      <div class="password-action-item">删除</div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'

/**
 * 变量定义
 */
const item = reactive({
  id: '',
  visible: false
})
</script>

<style lang="scss">
.password-item {
  width: 100%;
  // height: 209px;
  border-radius: 6px;
  border-style: solid;
  border-width: 1px;
  border-color: #e9ecef;
  position: relative;
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  cursor: pointer;
  transition: transform .3s;
  position: relative;
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