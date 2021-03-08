<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <div class="form-inline">
        <el-form-item label="金额" prop="money">
          <el-input-number v-model="form.money" style="width: 100%" :precision="2"/>
        </el-form-item>
        <el-form-item label="类别" prop="type">
          <el-select v-model="form.type" style="width: 100%;" @change="tagsGet">
            <el-option label="支出" :value="0" />
            <el-option label="收入" :value="1" />
          </el-select>
        </el-form-item>
      </div>
      <div class="form-inline">
        <el-form-item label="支付方式" prop="pay">
          <el-select v-model="form.pay" style="width: 100%;" filterable>
            <el-option label="支付宝" value="支付宝" />
            <el-option label="微信" value="微信" />
            <el-option label="银行卡" value="银行卡" />
            <el-option label="现金" value="现金" />
            <el-option label="信用卡" value="信用卡" />
          </el-select>
        </el-form-item>
        <el-form-item label="付款时间" prop="ptime">
          <el-date-picker v-model="form.ptime" type="datetime" placeholder="选择付款时间" style="width: 100%;" format="yyyy-MM-dd HH:mm:ss" @change="timeFormat" />
        </el-form-item>
      </div>
      <el-form-item label="标签" prop="tag">
        <el-select v-model="form.tag" placeholder="请选择" style="width: 100%;" clearable filterable :loading="tagLoading">
          <el-option
            v-for="(item, index) in tags"
            :key="index"
            :label="item.name"
            :value="item.id">
            <span style="float: left">{{ item.name }}</span>
            <span style="float: right; color: #8492a6; font-size: 20px">
              <i :class="item.icon"></i>
            </span>
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="位置" prop="location.code">
        <el-cascader
          v-model="form.location.code"
          :options="options"
          filterable
          clearable
          style="width: 100%;"
          popper-class="c-cascader"
          @change="handleChange"/>
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
const citys = require('@/assets/json/pca-code.json')
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
        money: 0,
        pay: '',
        type: 0,
        ptime: '',
        tag: '',
        location: {
          city: [],
          code: []
        }
      },
      rules: {
        money: [{ required: true, message: '请输入金额', trigger: 'blur' }],
        pay: [{ required: true, message: '请选择支付方式', trigger: 'blur' }],
        'location.code': [{ required: true, message: '请选择位置', trigger: 'blur' }],
        ptime: [{ required: true, message: '请选择付款时间', trigger: 'blur' }],
        tag: [{ required: true, message: '请选择标签', trigger: 'blur' }]
      },
      loading: false,
      popover: {
        icon: false
      },
      options: JSON.parse(JSON.stringify(citys)),
      tags: [],
      tagLoading: false
    }
  },
  methods: {
    close () {
      this.$emit('update:visible', false)
      this.$emit('update:id', '')
    },
    // 新增提交
    addSubmit () {
      const tag = this.tags.find(item => {
        return item.id === this.form.tag
      })
      const account = JSON.parse(JSON.stringify(this.form))
      account.tag = {
        name: tag.name,
        icon: tag.icon
      }
      this.$http({
        name: 'AddAccount',
        requireAuth: true,
        data: account
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
      const tag = this.tags.find(item => {
        return item.id === this.form.tag
      })
      const account = JSON.parse(JSON.stringify(this.form))
      account.tag = {
        name: tag.name,
        icon: tag.icon
      }
      this.$http({
        name: 'UpdateAccount',
        requireAuth: true,
        data: account
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
        name: 'GetAccount',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data
        return this.$http({
          name: 'GetAccountTags',
          requireAuth: true,
          params: {
            page: 1,
            size: 10000,
            type: this.form.type === 1,
            sort: 'order',
            order: 'asc'
          }
        })
      }).then(res => {
        const tag = res.data.data.find(item => {
          return item.name === this.form.tag.name
        })
        if (tag) {
          this.form.tag = tag.id
        } else {
          this.form.tag = ''
        }
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 时间格式化
    timeFormat (val) {
      this.form.ptime = this.$moment(val).format('yyyy-MM-DD HH:mm:ss')
    },
    // 城市回调
    handleChange (value) {
      const location = []
      this.options.forEach(province => {
        if (province.value === value[0]) {
          location.push(province.label)
          province.children.forEach(city => {
            if (city.value === value[1]) {
              location.push(city.label)
              city.children.forEach(area => {
                if (area.value === value[2]) {
                  location.push(area.label)
                }
              })
            }
          })
        }
      })
      this.form.location.city = location
    },
    // 获取标签
    tagsGet () {
      this.tagLoading = true
      this.$http({
        name: 'GetAccountTags',
        requireAuth: true,
        params: {
          page: 1,
          size: 10000,
          type: this.form.type === 1,
          sort: 'order',
          order: 'asc'
        }
      }).then(res => {
        this.tags = res.data.data
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.tagLoading = false
      })
    }
  },
  created () {
    this.tagsGet()
    if (this.id !== '') {
      this.listGet()
    }
  }
}
</script>

<style lang="scss">
.c-cascader{
  width: 560px;
  .el-cascader-menu {
    width: 100%;
  }
}
</style>
