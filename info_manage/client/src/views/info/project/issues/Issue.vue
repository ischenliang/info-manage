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
            <el-form-item label="任务描述" prop="content" class="rich-text" style="position: relative;">
              <c-mavon-editor
                v-model="form.content"
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
            <el-form-item label="优先级" prop="name">
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
          </el-form>
        </div>
        <div class="pagination">
          <el-button type="primary" size="medium" @click="submit">保存</el-button>
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
        content: '',
        text: ''
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        tag: [{ required: true, message: '请输入标签', trigger: 'blur' }],
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
      ]
    }
  },
  methods: {
    handleClose (done) {
      done()
      this.$emit('update:drawer', !this.drawer)
    },
    cancle () {
      this.$emit('update:drawer', !this.drawer)
    },
    submit () {}
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
