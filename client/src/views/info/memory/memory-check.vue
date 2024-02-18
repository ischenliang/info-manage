<template>
  <div :class="['memory-check', { active: checked }]"></div>
</template>

<script>
export default {
  name: 'memory-check',
  props: {
    checked: Boolean
  },
  methods: {
    handleClick() {
      this.$emit('update:checked', !this.checked)
    }
  }
}
</script>

<style lang="scss">
.memory-check {
  width: 20px;
  height: 20px;
  background-image: url('./images/select.png');
  background-size: 100%;
  &.active {
    background-image: url('./images/select-checked.png');
  }
}
</style>