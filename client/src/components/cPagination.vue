<template>
  <div class="pagination">
    <el-pagination
      background
      :layout="layout"
      :current-page="page"
      :total="total"
      :page-size="size"
      :page-sizes="sizes"
      :pager-count="pager"
      :hide-on-single-page="singleHide"
      @current-change="listPageChange"
      @size-change="listPageSizeChange"
      />
  </div>
</template>

<script>
export default {
  name: 'cPagination',
  props: {
    page: { // 当前页码
      type: Number,
      default: 1
    },
    size: { // 每页显示数量
      type: Number,
      default: 10
    },
    sizes: {
      type: Array,
      default:  () => {
        return [10, 20, 50, 100]
      }
    },
    total: { // 总数量
      type: Number,
      default: 0
    },
    sizeChangeable: { // 是否可以更改每页显示数量
      type: Boolean,
      default: true
    },
    pager: { // 显示几个页码
      type: Number,
      default: 5
    },
    singleHide: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    layout () {
      if (this.$props.sizeChangeable) {
        return 'total, sizes, prev, pager, next, jumper'
      } else {
        return 'total, prev, pager, next, jumper'
      }
    }
  },
  methods: {
    // 当前页发生变化时触发
    listPageChange (page) {
      this.$emit('update:page', page)
      this.$emit('change')
    },
    // pageSize 改变时会触发
    listPageSizeChange (size) {
      let maxPage = Math.floor(this.$props.total / size)
      if (this.$props.total % size !== 0) {
        maxPage++
      }
      if (this.$props.page > maxPage) {
        this.$emit('update:page', maxPage)
      }
      this.$emit('update:size', size)
      this.$emit('change')
    }
  }
}
</script>

<style>

</style>
