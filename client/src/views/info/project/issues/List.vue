<template>
  <div class="app-page" style="padding: 0">
    <com-table v-if="showTable" :showTable.sync="showTable" :pid="pid" />
    <com-panel v-else :showTable.sync="showTable" :pid="pid" />
  </div>
</template>

<script>
import ComTable from './Table'
import ComPanel from './Panel'
export default {
  name: 'ProjectIssues',
  components: {
    ComTable,
    ComPanel
  },
  computed: {
    pid () {
      return this.$route.params.id ? this.$route.params.id : ''
    }
  },
  data () {
    return {
      showTable: true
    }
  }
}
</script>

<style>

</style>
