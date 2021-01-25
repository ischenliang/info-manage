<template>
<!--
  vue-json-excel
  官网：https://www.npmjs.com/package/vue-json-excel
  data：导要导出的数据
  fields：要导出的JSON对象中的字段。如果没有提供，JSON中的所有属性都将被导出
  name：要导出的文件名
  type：Mime类型[xls，csv]
  header：数据的标题 String/Array
  title：与header相同，title是为了复古兼容性而维护的，但由于与HTML5 title属性冲突，不建议使用它
  footer：数据的页脚
  worksheet：工作表选项卡的名称('Sheet1')
  fetch：回调以在下载之前获取数据，如果设置了回调，则在按下鼠标之后和下载过程之前立即运行，仅在未定义data属性时有效
  before-generate：回调以在生成/获取数据之前调用方法，例如：显示进度条
  before-finish：回调在下载框弹出之前调用一个方法，例如：隐藏加载进度
-->
  <json-excel
    :fields="fields"
    :name="filename + '.xls'"
    :type="type"
    :fetch="getData"
    :before-generate="handleGenerate"
    :before-finish="handleFinish">
    <el-button type="warning" size="medium" :loading="loading">导出</el-button>
  </json-excel>
</template>

<script>
// 参考：https://www.cnblogs.com/yy136/p/10015561.html
export default {
  props: {
    name: String, // 接口名称
    fields: Object, // 导出字段属性
    filename: { // 导出文件名称
      type: String,
      default: 'filename'
    }
  },
  data () {
    return {
      type: 'xls', // 导出类型：xls/csv
      // header: '测试header', // 数据的标题
      // footer: '测试footer', // 数据的页脚 String/Array
      // data: [ // 导出的数据
      //   { id: 'as1kuhu1kuy2gkhgyu3g2jy', name: 'admin', remark: '管理员' },
      //   { id: 'asdf2574as6d54a68s7d423', name: 'user', remark: '普通用户' },
      //   { id: 'sd53f7s5465s78as68dasd5', name: 'test', remark: '测试' }
      // ],
      // fields: { // 字段
      //   id: 'id',
      //   名称: 'name',
      //   备注: 'remark'
      // }
      loading: false
    }
  },
  methods: {
    // 获取数据
    async getData () {
      try {
        const res = await this.$http({
          name: this.name,
          requireAuth: true,
          params: {
            page: 1,
            size: 10000
          }
        })
        return res.data.data
      } catch (error) {
        this.$notify.error(error)
      }
    },
    handleGenerate () {
      this.loading = true
    },
    handleFinish () {
      this.loading = false
    }
  }
}
</script>

<style>

</style>
