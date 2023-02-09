<template>
  <com-table v-if="showTable" :showTable.sync="showTable" :filter.sync="filter" />
  <com-panel v-else :showTable.sync="showTable" :filter.sync="filter" />
</template>

<script>
import ComTable from './Table'
import ComPanel from './Panel'
export default {
  name: 'CollectTable',
  data () {
    return {
      showTable: false,
      filter: {
        id: '',
        name: ''
      }
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
