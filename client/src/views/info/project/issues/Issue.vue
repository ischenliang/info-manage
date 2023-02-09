<template>
  <el-drawer
    title="我是标题"
    :visible="drawer"
    :with-header="false"
    direction="rtl"
    size="600px"
    :before-close="handleClose">
      <div class="app-page" style="padding: 0;">
        <div class="table" style="overflow: hidden auto;">
          <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
            <el-form-item label="任务名称" prop="name">
              <el-input v-model="form.name"/>
            </el-form-item>
            <el-form-item label="任务描述" prop="description" class="rich-text" style="position: relative;">
              <c-mavon-editor
                v-model="form.description"
                :text.sync="form.text"
                style="height: 460px;" />
            </el-form-item>
            <el-form-item label="任务标签"  prop="tag">
              <el-select v-model="form.tag" multiple filterable placeholder="标签" style="width: 100%;">
                <el-option
                  v-for="(item, index) in tags"
                  :key="index"
                  :label="item.name"
                  :value="item.name">
                  <div class="form-tags">
                    <span :style="{background: item.color}"></span>
                    <span>{{ item.name }}</span>
                  </div>
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="优先级" prop="priority">
              <el-select v-model="form.priority" filterable placeholder="优先级" style="width: 100%;">
                <el-option
                  v-for="(item, index) in prioritys"
                  :key="index"
                  :label="item.name"
                  :value="item.value">
                  <div class="form-tags">
                    <span :style="{background: item.color}"></span>
                    <span>{{ item.name }}</span>
                  </div>
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" filterable placeholder="任务状态" style="width: 100%;">
                <el-option
                  v-for="(item, index) in statuses"
                  :key="index"
                  :label="item.name"
                  :value="item.value">
                  <div class="form-tags">
                    <span :style="{color: item.color}" :class="item.icon"></span>
                    <span>{{ item.name }}</span>
                  </div>
                </el-option>
              </el-select>
            </el-form-item>
          </el-form>
        </div>
        <div class="pagination" style="justify-content: flex-start;">
          <el-button v-if="this.id" type="danger" size="medium" @click="itemDelete">删除</el-button>
          <c-flex-auto />
          <el-button type="primary" size="medium" @click="submit" :loading="loading">保存</el-button>
          <el-button type="danger" size="medium" @click="cancle">取消</el-button>
        </div>
      </div>
  </el-drawer>
</template>

<script>
export default {
  props: {
    drawer: Boolean,
    id: {
      type: String,
      default: ''
    },
    pid: String
  },
  data () {
    return {
      form: {
        name: '',
        tag: [],
        priority: 1,
        description: '',
        text: '',
        pid: '',
        status: 1
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        tag: [{ required: true, message: '请输入标签', trigger: 'blur' }],
        status: [{ required: true, message: '请选择状态', trigger: 'blur' }],
        priority: [
          { required: true, message: '请选择重要性' },
          { type: 'number', message: '重要性必须为number' }
        ]
      },
      tags: [
        { name: 'bug', color: '#DB2828' },
        { name: 'duplicate', color: '#767676' },
        { name: 'enhancement', color: '#F2711C' },
        { name: 'feature', color: '#B5CC18' },
        { name: 'invalid', color: '#1B1C1D' },
        { name: 'question', color: '#00B5AD' },
        { name: 'wontfix', color: '#6435C9' }
      ],
      prioritys: [
        { name: '重要', value: 5, color: 'rgb(239, 0, 22)' },
        { name: '主要', value: 4, color: 'rgb(255, 143, 0)' },
        { name: '次要', value: 3, color: 'rgb(0, 138, 255)' },
        { name: '不重要', value: 2, color: 'rgb(115, 224, 111)' },
        { name: '无优先级', value: 1, color: 'rgb(176, 176, 176)' }
      ],
      statuses: [
        { name: '代办的', value: 1, color: 'rgb(140, 146, 164)', icon: 'el-icon-bangzhu' },
        { name: '进行中', value: 2, color: 'rgb(0, 89, 128)', icon: 'el-icon-video-pause' },
        { name: '已完成', value: 3, color: 'rgb(75, 175, 80)', icon: 'el-icon-circle-check' },
        { name: '已拒绝', value: 0, color: 'rgb(236, 0, 25)', icon: 'el-icon-circle-close' }
      ],
      loading: false
    }
  },
  methods: {
    // 关闭
    handleClose (done) {
      done()
      this.$emit('update:drawer', !this.drawer)
    },
    // 取消
    cancle () {
      this.$emit('update:drawer', !this.drawer)
    },
    // 新增提交
    addSubmit () {
      const data = JSON.parse(JSON.stringify(this.form))
      data.tag = data.tag.join(',')
      this.$http({
        name: 'AddProjectIssue',
        requireAuth: true,
        data: data
      }).then(res => {
        this.$notify.success(res.data.msg)
        this.$emit('update:drawer', !this.drawer)
        this.$emit('submit')
      }).catch(error => {
        this.$notify.error(error)
      }).finally(() => {
        this.loading = false
      })
    },
    // 更新提交
    editSubmit () {
      const data = JSON.parse(JSON.stringify(this.form))
      data.tag = data.tag.join(',')
      this.$http({
        name: 'UpdateProjectIssue',
        requireAuth: true,
        data: data
      }).then(res => {
        this.$notify.success(res.data.msg)
        this.$emit('update:drawer', !this.drawer)
        this.$emit('submit')
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
    // 获取任务详情
    itemGet () {
      this.$http({
        name: 'GetProjectIssue',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data.data
        this.form.tag = this.form.tag.split(',')
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 删除
    itemDelete () {
      this.$confirm.warning('此操作将永久删除该数据, 是否继续?', '提示').then(() => {
        this.$http({
          name: 'DeleteProjectIssue',
          requireAuth: true,
          paths: [this.id]
        }).then(res => {
          this.$notify.success(res.data.msg)
          this.$emit('update:drawer', !this.drawer)
          this.$emit('submit')
        }).catch(error => {
          this.$notify.error(error)
        })
      }).catch(() => {})
    }
  },
  created () {
    this.form.pid = this.pid
    if (this.id) {
      this.itemGet()
    }
  }
}
</script>

<style lang="scss">
  .el-drawer:focus {
    outline: none;
  }
  .el-drawer__title:focus {
    outline: none;
  }
  .el-drawer__title span:focus {
    outline: none;
  }
  .el-drawer__body {
    padding: 10px;
    overflow: auto;
  }
  .form-tags {
    display: flex;
    align-items: center;
    span:first-child {
      width: 14px;
      height: 14px;
      border-radius: 50%;
      margin-right: 10px;
    }
  }
</style>
