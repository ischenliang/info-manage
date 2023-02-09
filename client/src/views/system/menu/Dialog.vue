<template>
  <el-dialog
    :title="id === '' ? '新增' : '编辑'"
    :visible.sync="visible"
    :close-on-click-modal="false"
    :before-close="close"
    :append-to-body="true"
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
      <el-form-item label="上级菜单" prop="pid">
        <el-input v-model="form.pid" v-popover:popover_pid readonly></el-input>
        <el-popover
          ref="popover_pid"
          placement="bottom-start"
          width="560"
          trigger="focus"
          :offset="0"
          v-model="popover.pid">
          <c-popmenu :id.sync="form.pid" :visible.sync="popover.pid"  />
        </el-popover>
      </el-form-item>
      <div class="form-inline">
        <el-form-item label="菜单组件" prop="component">
          <el-input v-model="form.component"></el-input>
        </el-form-item>
        <el-form-item label="显示顺序" prop="order">
          <el-input-number v-model="form.order" :min="1" :max="10" style="width: 100%;"></el-input-number>
        </el-form-item>
      </div>
      <el-form-item label="菜单图标" prop="icon">
        <el-input v-model="form.icon"  v-popover:popover_icon readonly></el-input>
        <el-popover
          ref="popover_icon"
          placement="bottom-start"
          width="560"
          trigger="focus"
          :offset="0"
          v-model="popover.icon">
          <c-popicon :icon.sync="form.icon" :visible.sync="popover.icon" />
        </el-popover>
      </el-form-item>
      <el-form-item label="菜单类型" prop="type">
        <el-select v-model="form.type" style="width: 100%;">
          <el-option :value="1" label="目录" />
          <el-option :value="2" label="菜单" />
        </el-select>
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
import { mapActions } from 'vuex'
import { parseRoutes, routes, resetRouter } from '@/router/index.js'
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
        component: 'Layout',
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
      // 控制popover的状态
      popover: {
        icon: false,
        pid: false
      }
    }
  },
  methods: {
    ...mapActions({
      setUser: 'user/SET_MENUS'
    }),
    close () {
      this.$emit('update:visible', false)
      this.$emit('update:id', '')
    },
    // 新增提交
    addSubmit () {
      // 删除this.form.pid属性
      if (this.form.pid === '') {
        delete this.form.pid
      }
      this.$http({
        name: 'AddMenu',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 编辑提交
    editSubmit () {
      this.$http({
        name: 'UpdateMenu',
        requireAuth: true,
        data: this.form
      }).then(res => {
        this.$emit('submit')
        this.close()
        this.$notify.success(res.data.msg)
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    // 提交中间件
    submit () {
      this.$refs.form.validate(async valid => {
        if (valid) {
          if (this.id === '' || this.id === undefined) {
            this.addSubmit()
          } else {
            this.editSubmit()
          }
          // 重置路由并更新路由
          resetRouter()
          const dynamicRoutes = await this.setUser(routes) // 注意：要将静态路由拼接到menus中
          const routelist = parseRoutes(dynamicRoutes)
          routelist.push({ path: '*', redirect: '/404' })
          this.$router.addRoutes(routes.concat(...routelist))
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
        this.form = res.data.data
        // 后期这里使用ajax获取后台的icons
        // this.list.icons = [{ value: '三全鲜食（北新泾店）', address: '长宁区新渔路144号' }]
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
</style>
