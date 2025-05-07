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
      <el-form-item label="地址" prop="path">
        <el-input v-model="form.path"></el-input>
      </el-form-item>
      <el-form-item label="权限标识" prop="perms">
        <el-input v-model="form.perms" placeholder="权限标识用于前台按钮级权限控制(请尽量不要做修改)"></el-input>
      </el-form-item>
      <div class="form-inline">
        <el-form-item label="接口类型" prop="type">
          <el-select v-model="form.type" style="width: 100%;">
            <el-option v-for="(item, index) in list.types" :key="index" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="所属模块" prop="tid">
          <el-select v-model="form.tid" style="width: 100%;">
            <el-option v-for="(item, index) in list.apiTypes" :key="index" :label="item.name" :value="item.id" />
          </el-select>
        </el-form-item>
      </div>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="form.remark" type="textarea" :rows="2"></el-input>
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
    }
  },
  data () {
    return {
      form: {
        name: '',
        path: '',
        perms: '',
        type: 'GET',
        tid: '',
        remark: ''
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        path: [{ required: true, message: '请输入地址', trigger: 'blur' }],
        perms: [{ required: true, message: '请输入权限标识', trigger: 'blur' }],
        type: [{ required: true, message: '请选择接口类型', trigger: 'blur' }],
        tid: [{ required: true, message: '请选择类型', trigger: 'blur' }]
      },
      list: {
        types: [
          { label: 'GET', value: 'GET' },
          { label: 'POST', value: 'POST' },
          { label: 'PUT', value: 'PUT' },
          { label: 'DELETE', value: 'DELETE' }
        ],
        apiTypes: []
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
        name: 'AddApi',
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
        name: 'UpdateApi',
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
    itemGet () {
      // 获取数据....
      this.$http({
        name: 'GetApi',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data.data
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 获取列表数据
    listGet () {
      this.$http({
        name: 'GetApiTypes',
        requireAuth: true,
        params: {
          page: 1,
          size: 10000,
          status: true
        }
      }).then(res => {
        this.list.apiTypes = res.data.data.data
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    this.listGet()
    if (this.id !== '') {
      this.itemGet()
    } else {
    }
  }
}
</script>

<style lang="scss">
</style>
