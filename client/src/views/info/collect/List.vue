<template>
  <div class="app-page" style="padding: 10px;">
    <el-tabs v-model="active" type="border-card" class="info-tabs">
      <el-tab-pane label="收藏列表" name="first">
        <collect v-if="active === 'first'" />
      </el-tab-pane>
      <el-tab-pane label="收藏类别" name="second">
        <type v-if="active === 'second'" />
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import Collect from './list/List'
import Type from './type/List'
export default {
  name: 'CollectList',
  components: {
    Collect,
    Type
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
      width: 100%;
      height: 100%;
    }
  }
}
</style>
