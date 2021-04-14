<template>
  <com-table v-if="showTable" :showTable.sync="showTable" />
  <com-panel v-else :showTable.sync="showTable" />
</template>

<script>
import ComTable from './Table'
import ComPanel from './Panel'
export default {
  name: 'ResourceList',
  data () {
    return {
      showTable: true
    }
  },
  components: {
    ComTable,
    ComPanel
  },
  created () {
    console.log(this.showTable)
  }
}
</script>

<style>

</style>
