<template>
  <div style="width: 100%;height: 100%;display:flex;flex-direction: column;justify-content: center;align-items: center;user-select: none;">
    <!-- <c-resources :visible.sync="visible" :title="'移动到'" @submit="submit" /> -->
    <el-cascader
      v-model="value"
      :options="options"
      filterable
      clearable
      :props="{
        label: 'name',
        value: 'code'
      }"
      @change="handleChange"/>
  </div>
</template>

<script>
const citys = require('@/assets/json/country.json')
console.log(citys)
export default {
  data () {
    return {
      // visible: true
      value: [],
      options: JSON.parse(JSON.stringify(citys))
    }
  },
  methods: {
    // submit (data) {
    //   console.log(data)
    // }
    handleChange (value) {
      console.log(value)
    }
  }
}
</script>

<style lang="scss">
</style>
