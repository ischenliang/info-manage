<template>
  <div class="app-page">
    <div class="toolbar">
      <el-page-header
        @back="$router.push({ path: '/monitor/job/list' })"
        :content="id === '' ? '新增定时任务' : '更新定时任务'" />
      <c-flex-auto />
      <el-button
        type="success"
        size="medium"
        @click="submit"
        :loading="loading">保存</el-button>
      <el-button
        type="danger"
        size="medium"
        @click="$router.push({ path: '/monitor/job/list' })">取消</el-button>
    </div>
    <div class="table">
      哈哈哈哈哈
    </div>
  </div>
</template>

<script>
export default {
  name: 'MonitorJobLog'
}
</script>

<style>

</style>
