<template>
  <div class="c-line-container">
    <el-input v-model="row.name" size="small" class="c-line-input" />
    <el-button
      type="success"
      icon="el-icon-check"
      size="mini"
      plain
      class="c-line-button"/>
    <el-button
      type="danger"
      icon="el-icon-close"
      size="mini"
      plain
      class="c-line-button"/>
  </div>
</template>

<script>
export default {
  name: 'cLineEdit'
}
</script>

<style lang="scss">
  .c-line-container{
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: row;
    align-items: center;
    .c-line-input {
      flex: 1 1 auto;
    }
    .c-line-button {
      margin-left: 5px;
    }
  }
</style>
