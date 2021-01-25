<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <el-form-item label="用户名称" prop="username">
        <el-input v-model="form.username"></el-input>
      </el-form-item>
      <el-form-item label="用户密码" prop="password">
        <el-input v-model="form.password"  show-password></el-input>
      </el-form-item>
      <el-form-item label="用户角色" prop="role">
        <el-select v-model="form.role" multiple style="width: 100%;">
          <el-option v-for="(item, index) in roles" :key="index" :label="item.name" :value="item.id"/>
        </el-select>
      </el-form-item>
      <el-form-item label="用户昵称" prop="nickname">
        <el-input v-model="form.nickname"></el-input>
      </el-form-item>
      <el-form-item label="用户头像" prop="avatar">
        <el-input v-model="form.avatar" placeholder="请输入能够访问的在线url"></el-input>
      </el-form-item>
      <el-form-item label="用户状态" prop="status">
        <el-radio v-model="form.status" :label="true">启用</el-radio>
        <el-radio v-model="form.status" :label="false">禁用</el-radio>
      </el-form-item>
      <el-form-item label="备注信息" prop="remark">
        <el-input type="textarea" v-model="form.remark" :rows="2"></el-input>
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
        username: '',
        password: '',
        role: [],
        nickname: '用户007',
        avatar: 'http://localhost:3000/avatar/26192b0d-9281-4363-b8c5-e05a29bef677.jpg',
        status: true,
        remark: ''
      },
      rules: {
        username: [{ required: true, message: '请输入用户名称', trigger: 'blur' }],
        nickname: [{ required: true, message: '请输入用户昵称', trigger: 'blur' }],
        role: [{ required: true, message: '请输入用户角色', trigger: 'blur' }]
      },
      roles: []
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
        name: 'AddUser',
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
        name: 'UpdateUser',
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
      this.$http({
        name: 'GetUser',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.$set(this.form, 'id', res.data.id)
        this.form.username = res.data.username
        this.form.nickname = res.data.nickname
        this.form.avatar = res.data.avatar
        this.form.status = res.data.status
        this.form.remark = res.data.remark
        res.data.ur.forEach(item => {
          this.form.role.push(item.id)
        })
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 获取角色
    getRoles () {
      this.$http({
        name: 'GetRoles',
        params: {
          status: true,
          page: 1,
          size: 10000
        },
        requireAuth: true
      }).then(res => {
        this.roles = res.data.data
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    } else {
      // 只有在新增用户是才必须输入密码
      this.$set(this.rules, 'password', [{ required: true, message: '请输入用户密码', trigger: 'blur' }])
    }
    this.getRoles()
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
