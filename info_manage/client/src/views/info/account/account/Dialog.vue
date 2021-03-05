<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <el-form-item label="金额" prop="money">
        <el-input v-model="form.money"></el-input>
      </el-form-item>
      <div class="form-inline">
        <el-form-item label="支付方式" prop="pay">
          <el-select v-model="form.pay" style="width: 100%;" filterable>
            <el-option label="支付宝" value="支付宝" />
            <el-option label="微信" value="微信" />
            <el-option label="银行卡" value="银行卡" />
            <el-option label="现金" value="现金" />
          </el-select>
        </el-form-item>
        <el-form-item label="付款时间" prop="ptime">
          <el-date-picker v-model="form.ptime" type="datetime" placeholder="选择付款时间" style="width: 100%;" format="yyyy-MM-DD HH:mm:ss" @change="timeFormat" />
        </el-form-item>
      </div>
      <el-form-item label="标签" prop="tag">
        <el-input v-model="form.tag"></el-input>
      </el-form-item>
      <el-form-item label="位置" prop="location">
        <el-input v-model="form.location"></el-input>
      </el-form-item>
      <el-form-item label="类别" prop="type">
        <el-select v-model="form.type" style="width: 100%;">
          <el-option label="支出" value="支出" />
          <el-option label="收入" value="收入" />
        </el-select>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="form.remark" type="textarea"></el-input>
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
        money: '',
        pay: '',
        type: 0,
        ptime: '',
        tag: '',
        location: ''
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        icon: [{ required: true, message: '请选择图标', trigger: 'blur' }]
      },
      loading: false,
      popover: {
        icon: false
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
        name: 'AddAccountTag',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 编辑提交
    editSubmit () {
      this.$http({
        name: 'UpdateccountTag',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
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
        name: 'GetAccountTag',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    timeFormat (val) {
      this.form.ptime = this.$moment(val).format('yyyy-MM-DD HH:mm:ss')
    }
  },
  created () {
    console.log(require('@/assets/json/pca-code.json'))
    if (this.id !== '') {
      this.listGet()
    } else {
      // 这里面对一些不同的需求做判断，如：
      // 新增时：密码不填 修改时：密码不必填
      // this.$set(this.rules, 'password', [{ required: true, message: '请输入用户密码', trigger: 'blur' }])
    }
  }
}
</script>

<style lang="scss">
</style>
