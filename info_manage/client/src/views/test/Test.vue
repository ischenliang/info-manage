<template>
  <div style="width: 100%;height: 100%;display:flex;flex-direction: column;justify-content: center;align-items: center;user-select: none;">
    <div style="width: 400px;">
      <c-tags-input
        v-model="list"
        :repeat="false"
        :type="'success'"
        :theme="'dark'"
        :placeholder="'按enter键创建'" />
    </div>
    <div style="width: 500px;height: 300px;position: relative;background: #ccc;margin-top: 10px;">
      <c-fork-me
        :href="'https://element.eleme.cn/#/zh-CN/component/tag'"
        :fill-color="'red'"
        :color="'#ccc'" />
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      list: ['vue']
    }
  },
  methods: {
  }
}
</script>

<style lang="scss">
</style>
