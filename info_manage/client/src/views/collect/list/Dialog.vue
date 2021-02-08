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
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="类别" prop="tid">
          <el-input v-model="form.tid"></el-input>
        </el-form-item>
      </div>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="form.remark" type="textarea" :rows="2"></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="primary" size="medium" @click="submit">确定</el-button>
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
        tid: '',
        url: '',
        logo: '',
        repository: '',
        tag: '',
        remark: ''
      },
      types: [],
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }]
      }
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
        name: 'AddCollectType',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 编辑提交
    editSubmit () {
      this.$http({
        name: 'UpdateCollectType',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 提交中间件
    submit () {
      this.$refs.form.validate(valid => {
        if (valid) {
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
        name: 'GetCollectType',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    } else {
      this.$http({
        name: 'GetCollectTypes',
        requireAuth: true,
        params: {
          status: true,
          page: 1,
          size: 10000
        }
      }).then(res => {
        this.types = res.data.data
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  }
}
</script>

<style lang="scss">
.form-inline{
  display: flex;
  .el-form-item{
    flex: 1;
    &:first-child{
      margin-right: 10px;
    }
    &:last-child{
      margin-left: 10px;
    }
  }
}
</style>
