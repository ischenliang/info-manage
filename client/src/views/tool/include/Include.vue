<template>
  <div class="app-page">
    <div class="toolbar">
      <span style="font-weight: bold;">百度网站收录</span>
      <c-flex-auto />
      <el-button @click="addItem" type="primary" size="medium">新增</el-button>
      <el-button @click="submit" :loading="loading" type="success" size="medium">提交</el-button>
    </div>
    <div class="table" style="padding: 10px 20px;">
      <div style="line-height: 30px;color: #696867;">主动向百度搜索主动推送资源，让您的网站能够被百度搜索引擎收录.....</div>
      <el-form ref="form" :model="form" label-width="80px" label-position="top">
        <el-form-item
          label="令牌"
          prop="token"
          :rules="[{ required: true, message: '请输入百度收录令牌', trigger: 'blur' }]">
          <el-input v-model="form.token" placeholder="百度收录令牌"></el-input>
        </el-form-item>
        <el-form-item
          label="百度站点"
          prop="site"
          :rules="[{ required: true, message: '请输入百度收录站点', trigger: 'blur' }]">
          <el-input v-model="form.site" placeholder="百度收录站点" />
        </el-form-item>
        <el-form-item
          v-for="(item, index) in form.data"
          :key="index.key"
          :label="'链接地址' + (index + 1)"
          :prop="'data.' + index + '.value'"
          :rules="[{ required: true, message: '链接地址不能为空', trigger: 'blur' }]"
          class="url-inline">
          <el-input v-model="item.value" />
          <el-button v-if="index !== 0" @click.prevent="removeItem(item, index)">删除</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ToolInclude',
  data () {
    return {
      form: {
        token: localStorage.getItem('baidu_token') ? localStorage.getItem('baidu_token') : '',
        site: localStorage.getItem('baidu_site') ? localStorage.getItem('baidu_site') : '',
        data: [{
          value: ''
        }]
      },
      loading: false
    }
  },
  methods: {
    submit () {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.loading = TextTrackCueList
          this.$http({
            name: 'BaiduIncluded',
            requireAuth: true,
            params: {
              token: this.form.token,
              site: this.form.site
            },
            data: this.form.data.map(item => item.value)
          }).then(res => {
            const h = this.$createElement
            this.$notify.success(h('div', null, [
              h('div', null, `当天剩余条数：${res.data.data.remain}`),
              h('div', null, `本次成功条数：${res.data.data.success}`)
            ]))
            localStorage.setItem('baidu_token', this.form.token)
            localStorage.setItem('baidu_site', this.form.site)
          }).catch(error => {
            this.$notify.error(error)
          }).finally(() => {
            this.loading = false
          })
        }
      })
    },
    removeItem (item, index) {
      this.form.data.splice(index, 1)
    },
    // 新增链接
    addItem () {
      this.form.data.push({ value: '' })
    }
  }
}
</script>

<style lang="scss">
.url-inline{
  .el-form-item__content {
    display: flex;
    .el-button{
      margin-left: 10px;
    }
  }
}
</style>
