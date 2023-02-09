<template>
  <div class="app-page">
    <el-tabs v-model="active" type="border-card" class="info-tabs">
      <el-tab-pane label="账目列表" name="first">
        <account v-if="active === 'first'" />
      </el-tab-pane>
      <el-tab-pane label="账目类别" name="second">
        <type v-if="active === 'second'" />
      </el-tab-pane>
      <el-tab-pane label="账目可视化" name="third">
        <chart v-if="active === 'third'" />
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import Account from './account/List'
import Type from './type/Type'
import Chart from './chart/Chart'
export default {
  name: 'AccountList',
  components: {
    Account,
    Type,
    Chart
  },
  data () {
    return {
      active: 'first'
    }
  }
}
</script>

<style lang="scss">
.info-tabs {
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
      height: 100%;
      flex: 1 1 auto !important;
    }
  }
}
</style>
