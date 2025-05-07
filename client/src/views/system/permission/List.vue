<template>
  <div class="app-page">
    <el-tabs type="border-card" class="permission-tabs" v-model="active">
      <el-tab-pane label="菜单授权" name="first">
        <menu-auth v-if="active === 'first'" v-perms="'system:role:menu'" />
      </el-tab-pane>
      <el-tab-pane label="接口授权" name="second">
        <api-auth v-if="active === 'second'" v-perms="'system:role:api'" />
      </el-tab-pane>
      <el-tab-pane label="数据授权" name="third">
        <data-auth v-if="active === 'third'" v-perms="'system:role:data'" />
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
  },
  data () {
    return {
      active: 'first'
    }
  }
}
</script>

<style lang="scss">
  .permission-tabs {
    height: 100%;
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
