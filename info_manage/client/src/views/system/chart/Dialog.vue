<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <el-form-item label="名称" prop="name">
        <el-input v-model="form.name"></el-input>
      </el-form-item>
      <el-form-item label="组件名称" prop="component">
        <el-input v-model="form.component"></el-input>
      </el-form-item>
      <el-form-item label="描述" prop="description">
        <el-input type="textarea" v-model="form.description"></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="primary" size="medium" @click="submit" :loading="loading">确定</el-button>
      <el-button type="danger" size="medium" @click="close">取消</el-button>
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
    }
  },
  data () {
    return {
      form: {
        name: '',
        description: '',
        component: ''
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
      },
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
      this.$http({
        name: 'AddChart',
        requireAuth: true,
        data: this.form
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
      this.$http({
        name: 'UpdateChart',
        requireAuth: true,
        data: this.form
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
        name: 'GetChart',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form.id = res.data.data.id
        this.form.name = res.data.data.name
        this.form.description = res.data.data.description
        this.form.component = res.data.data.component
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    } else {
    }
  }
}
</script>

<style lang="scss">
  // 文件夹
  .folder-upload{
    width: 560px;
    height: 150px;
    background-color: #fff;
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    box-sizing: border-box;
    position: relative;
    flex-shrink: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    cursor: pointer;
    &:hover{
      border-color: #409EFF;
    }
    > input[type="file"] {
      display: none;
    }
    .el-icon-upload{
      font-size: 67px;
      color: #C0C4CC;
      margin: 40px 0 16px;
      line-height: 50px;
    }
    p{
      color: #606266;
      font-size: 14px;
    }
  }
</style>
