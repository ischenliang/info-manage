<template>
  <com-table v-if="showTable" :showTable.sync="showTable" />
  <com-panel v-else :showTable.sync="showTable" />
</template>

<script>
import ComTable from './Table'
import ComPanel from './Panel'
export default {
  name: 'CollectTable',
  data () {
    return {
      showTable: false
    }
  },
  components: {
    ComTable,
    ComPanel
  }
}
</script>

<style>

</style>
