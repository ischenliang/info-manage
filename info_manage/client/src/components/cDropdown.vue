<template>
  <el-dropdown trigger="click" :hide-on-click="false" style="margin-left: 10px;">
    <el-button type="primary" size="medium">
      列<i class="el-icon-caret-bottom"></i>
    </el-button>
    <el-dropdown-menu slot="dropdown">
      <el-dropdown-item v-for="(item, index) in show" :key="index">
        <el-checkbox v-model="item.value" :name="item.name" :disabled="item.disabled" @change="handleChange">{{ item.label }}</el-checkbox>
      </el-dropdown-item>
    </el-dropdown-menu>
  </el-dropdown>
</template>

<script>
export default {
  props: {
    show: Array
  },
  methods: {
    handleChange () {
      this.$emit('update:show', this.show)
    }
  }
}
</script>

<style>

</style>
