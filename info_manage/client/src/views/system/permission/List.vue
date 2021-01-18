<template>
  <div class="app-page">
    <el-tabs type="border-card" class="permission-tabs">
      <el-tab-pane label="菜单授权">
        <menu-auth />
      </el-tab-pane>
      <el-tab-pane label="接口授权">
        <api-auth />
      </el-tab-pane>
      <el-tab-pane label="数据授权">
        <data-auth />
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import MenuAuth from './MenuAuth'
import ApiAuth from './ApiAuth'
import DataAuth from './DataAuth'
export default {
  name: 'SystemPermission',
  components: {
    MenuAuth,
    ApiAuth,
    DataAuth
  }
}
</script>

<style lang="scss">
  .permission-tabs {
    flex: 1 1 auto;
    box-shadow: 0 0 0 0 transparent !important;
    display: flex;
    flex-direction: column;
    .el-tabs__header{
      flex-shrink: 0;
    }
    .el-tabs__content{
      flex: 1 1 auto;
      .el-tab-pane{
        width: 100%;
        height: 100%;
      }
    }
  }
</style>
