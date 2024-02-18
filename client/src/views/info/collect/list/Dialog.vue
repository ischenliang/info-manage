<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <div class="form-inline">
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入名称"></el-input>
        </el-form-item>
        <el-form-item label="类别" prop="tid">
          <el-select v-model="form.tid" filterable clearable style="width: 100%;">
            <el-option v-for="(item, index) in types" :key="index" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
      </div>
      <el-form-item label="网址" prop="url">
        <el-input v-model="form.url" placeholder="请输入网址"></el-input>
      </el-form-item>
      <el-form-item label="logo地址" prop="repository">
        <el-input v-model="form.repository" placeholder="请输入logo地址"></el-input>
      </el-form-item>
      <el-form-item label="排序值" prop="logo">
        <el-input-number v-model="form.logo" :precision="2" :min="0"></el-input-number>
      </el-form-item>
      <el-form-item label="标签" prop="tag" class="form-item-tags">
        <c-tags-input
          v-model="form.tag"
          :repeat="false"
          :type="'success'"
          :theme="'dark'"
          :placeholder="'按enter键创建'" />
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注"></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="primary" size="small" @click="submit" :loading="loading">确定</el-button>
      <el-button type="danger" size="small" @click="close">取消</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  props: {
    visible: Boolean,
    id: {
      type: String,
      default: ''
    },
    tid: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      form: {
        name: '',
        tid: '',
        url: '',
        logo: '',
        repository: '',
        tag: [],
        remark: ''
      },
      types: [],
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        tid: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        url: [{ required: true, message: '请输入网址', trigger: 'blur' }],
        logo: [{ required: true, message: '请输入图标', trigger: 'blur' }]
      },
      prefix: 'https://badgen.net/badge/icon/',
      suffix: 'label',
      loading: false
    }
  },
  methods: {
    close () {
      this.$emit('update:visible', false)
      this.$emit('update:id', '')
    },
    // 新增提交
    addSubmit () {
      const data = JSON.parse(JSON.stringify(this.form))
      data.tag = data.tag.join(',')
      data.logo = data.logo.toString()
      this.$http({
        name: 'AddCollect',
        requireAuth: true,
        data: data
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 编辑提交
    editSubmit () {
      const data = JSON.parse(JSON.stringify(this.form))
      data.tag = data.tag.join(',')
      data.logo = data.logo.toString()
      this.$http({
        name: 'UpdateCollect',
        requireAuth: true,
        data: data
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 提交中间件
    submit () {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.loading = true
          if (this.id === '' || this.id === undefined) {
            this.addSubmit()
          } else {
            this.editSubmit()
          }
        }
      })
    },
    // 获取数据
    listGet () {
      // 获取数据....
      this.$http({
        name: 'GetCollect',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        // res.data.data.logo = res.data.data.logo.replace(new RegExp(this.prefix), '')
        // res.data.data.logo = res.data.data.logo.replace(new RegExp('\\?' + this.suffix), '')
        res.data.data.logo = parseFloat(res.data.data.logo)
        res.data.data.tag = res.data.data.tag.split(',')
        this.form = res.data.data
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    }
    if (this.tid) {
      this.form.tid = this.tid
    }
    this.$http({
      name: 'GetCollectTypes',
      requireAuth: true,
      params: {
        status: true,
        page: 1,
        size: 10000
      }
    }).then(res => {
      this.types = res.data.data.data
    }).catch(error => {
      this.$notify.error(error)
    })
  }
}
</script>

<style lang="scss">
.form-item-tags {
  .el-form-item__content {
    line-height: 0 !important;
  }
}
</style>
