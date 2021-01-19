<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :destroy-on-close="true">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px" label-position="top">
      <div class="form-inline">
        <el-form-item label="菜单名称" prop="name">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="菜单路由" prop="path">
          <el-input v-model="form.path"></el-input>
        </el-form-item>
      </div>
      <div class="form-inline">
        <el-form-item label="菜单组件" prop="component">
          <el-input v-model="form.component"></el-input>
        </el-form-item>
        <el-form-item label="显示顺序" prop="order">
          <el-input-number v-model="form.order" :min="1" :max="10" style="width: 100%;"></el-input-number>
        </el-form-item>
      </div>
      <el-form-item label="菜单图标" prop="icon">
        <el-input v-model="form.icon" v-popover:popover_icon readonly></el-input>
        <el-popover
          ref="popover_icon"
          placement="bottom-start"
          width="560"
          trigger="focus"
          :offset="0"
          v-model="popover.icon">
          <!-- 不设置title和content：然后设置下面的html代码，会显示在内容区 -->
          <div class="icon-body">
            <div>
              <i class="el-icon-delete"></i>
              <span>哇哈哈哈</span>
            </div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
          </div>
        </el-popover>
      </el-form-item>
      <div class="form-inline">
        <el-form-item label="菜单状态" prop="status">
          <el-radio v-model="form.status" :label="true">启用</el-radio>
          <el-radio v-model="form.status" :label="false">禁用</el-radio>
        </el-form-item>
        <el-form-item label="显示在菜单栏" prop="visible">
          <el-radio v-model="form.visible" :label="true">显示</el-radio>
          <el-radio v-model="form.visible" :label="false">不显示</el-radio>
        </el-form-item>
        <el-form-item label="是否外链" prop="is_frame">
          <el-radio v-model="form.is_frame" :label="true">是</el-radio>
          <el-radio v-model="form.is_frame" :label="false">否</el-radio>
        </el-form-item>
      </div>
      <el-form-item label="菜单类型" prop="type">
        <el-select v-model="form.type" style="width: 100%;">
          <el-option :value="1" label="目录" />
          <el-option :value="2" label="菜单" />
        </el-select>
      </el-form-item>
      <el-form-item label="上级菜单" prop="pid">
        <el-input v-model="form.pid" v-popover:popover_pid readonly></el-input>
        <el-popover
          ref="popover_pid"
          placement="bottom-start"
          width="560"
          trigger="focus"
          :offset="0">
          <div style="height: 200px;">
            <p>这是一段内容这是一段内容确定删除吗？</p>
          </div>
        </el-popover>
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
        name: '',
        path: '',
        component: '/Layout',
        type: 1,
        visible: true,
        status: true,
        icon: 'el-icon-location-information',
        remark: '',
        pid: '',
        is_frame: false,
        order: 1
      },
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        path: [{ required: true, message: '请输入路由', trigger: 'blur' }],
        component: [{ required: true, message: '请输入组件路径', trigger: 'blur' }]
      },
      // 存放所有里面用到的列表数据
      list: {
        icons: [
          { name: '首页', value: 'el-icon-s-home' },
          { name: '日期', value: 'el-icon-date' },
          { name: '权限', value: 'el-icon-lock' },
          { name: '文件夹(关闭)', value: 'el-icon-folder' },
          { name: '文件夹(打开)', value: 'el-icon-folder-opened' },
          { name: '设置', value: 'el-icon-setting' }
        ]
      },
      // 控制popover的状态
      popover: {
        icon: false,
        pid: false
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
        name: 'AddRole',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
      }).catch(error => {
        this.$notify.error(error.message)
      })
    },
    // 编辑提交
    editSubmit () {
      this.$http({
        name: 'UpdateRole',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.msg)
      }).catch(error => {
        this.$notify.error(error.message)
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
        name: 'GetMenu',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.form = res.data
        // 后期这里使用ajax获取后台的icons
        this.list.icons = [{ value: '三全鲜食（北新泾店）', address: '长宁区新渔路144号' }]
      }).catch(error => {
        this.$notify.error(error.message)
      })
    },
    // queryString:搜索的数据 cb：回调函数
    querySearch (queryString, cb) {
      cb(this.list.icons)
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
.icon-body{
  display: flex;
  height: 200px;
  flex-wrap: wrap;
  overflow: auto;
  border: 1px solid #eee;
  > div {
    width: 88px;
    height: 60px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    border-right: 1px solid #eee;
    border-bottom: 1px solid #eee;
    > i {
      font-size: 30px;
    }
    > span {
      display: block;
      width: 100%;
      height: 20px;
      line-height: 20px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      text-align: center;
      font-size: 12px;
    }
  }
}
</style>
