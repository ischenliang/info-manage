<template>
  <div class="app-page">
    <div class="toolbar">
      <el-page-header
        @back="$router.push({ path: '/info/memory/list' })"
        :content="id === '' ? '新增备忘录' : '更新备忘录'" />
      <c-flex-auto />
      <el-button
        type="success"
        size="medium"
        @click="submit"
        :loading="loading">保存</el-button>
      <el-button
        type="danger"
        size="medium"
        @click="$router.push({ path: '/info/memory/list' })">取消</el-button>
    </div>
    <div class="table" style="padding: 10px 20px;">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
        <div class="form-inline">
          <el-form-item label="名称" prop="name">
            <el-input v-model="form.name"/>
          </el-form-item>
          <el-form-item label="排序值" prop="priority">
            <el-input-number v-model="form.priority" :precision="2" :min="0"></el-input-number>
            <span style="margin-left: 5px;color: #8c8c8c;">值越小越靠前</span>
          </el-form-item>
        </div>
        <el-form-item label="标签" prop="tag" class="form-item-tags">
          <c-tags-input
            v-model="form.tag"
            :repeat="false"
            :type="'warning'"
            :theme="'dark'"
            :focus="false"
            :placeholder="'按enter键创建'" />
        </el-form-item>
        <el-form-item label="备忘录内容" prop="content" class="rich-text" style="position: relative;">
          <el-button type="info" size="mini" class="rich-text-btn" @click="toggleEditor">
            {{ form.type === 1 ? '富文本' : 'Markdown' }}
          </el-button>
          <c-quill-editor
            v-if="form.type === 1"
            v-model="form.content"
            :text.sync="form.text"
            style="height: 500px;" />
          <c-mavon-editor
            v-if="form.type === 2"
            v-model="form.content"
            :text.sync="form.text"
            style="height: 530px;" />
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MemoryDialog',
  data () {
    return {
      form: {
        name: '',
        tag: [],
        priority: 0,
        content: '',
        text: '',
        type: 1
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        tag: [{ required: true, message: '请输入标签', trigger: 'blur' }],
        priority: [
          { required: true, message: '请选择重要性' },
          { type: 'number', message: '重要性必须为number' }
        ]
      },
      loading: false
    }
  },
  computed: {
    id () {
      return this.$route.params.id ? this.$route.params.id : ''
    }
  },
  methods: {
    // 新增提交
    addSubmit () {
      const data = JSON.parse(JSON.stringify(this.form))
      data.tag = data.tag.join(',')
      this.$http({
        name: 'AddMemory',
        requireAuth: true,
        data: data
      }).then(res => {
        this.$notify.success(res.data.msg)
        this.$router.push({ path: '/info/memory/list' })
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
      this.$http({
        name: 'UpdateMemory',
        requireAuth: true,
        data: data
      }).then(res => {
        this.$notify.success(res.data.msg)
        this.$router.push({ path: '/info/memory/list' })
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 提交
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
    // 切换富文本
    toggleEditor () {
      if (this.form.type === 1) {
        this.form.type = 2
      } else if (this.form.type === 2) {
        this.form.type = 1
      }
    },
    // 获取数据
    listGet () {
      // 获取数据....
      this.$http({
        name: 'GetMemory',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data.data
        this.form.tag = res.data.data.tag.split(',')
      }).catch(error => {
        this.$notify.error(error)
      })
    }
  },
  created () {
    if (this.id !== '') {
      this.listGet()
    }
  }
}
</script>

<style lang="scss">
  .form-item-tags {
    .el-form-item__content {
      line-height: 0 !important;
    }
  }
  .c-input{
    border: 1px solid #DCDFE6;
    height: 40px;
    border-radius: 4px;
    display: flex;
    align-items: center;
    padding: 0 15px;
  }
  .rich-text{
    position: relative;
    .rich-text-btn{
      position: absolute;
      top: -28px;
      right: 0;
      border-radius: 0 !important;
    }
  }
</style>
