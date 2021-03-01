<template>
  <div style="width: 100%;height: 100%;display:flex;flex-direction: column;justify-content: center;align-items: center;user-select: none;">
    <c-resources :visible.sync="visible" :title="'移动到'" />
  </div>
</template>

<script>
export default {
  data () {
    return {
      visible: true
    }
  },
  methods: {
  }
}
</script>

<style lang="scss">
</style>
