import Vue from 'vue'
import {
  Button,
  Form,
  Loading,
  Input,
  FormItem,
  Message,
  Container,
  Scrollbar,
  Header,
  Aside,
  Main,
  Menu,
  MenuItem,
  Submenu,
  Tree,
  Dialog,
  Table,
  TableColumn,
  Dropdown,
  DropdownMenu,
  DropdownItem,
  Tabs,
  TabPane,
  Select,
  Option,
  Breadcrumb,
  BreadcrumbItem,
  Pagination,
  MessageBox,
  Tooltip,
  Timeline,
  TimelineItem,
  Steps,
  Step,
  Transfer,
  Row,
  Col,
  Card,
  Avatar,
  Progress,
  Autocomplete,
  InputNumber,
  Tag,
  Checkbox,
  CheckboxButton,
  DatePicker,
  TimeSelect,
  TimePicker,
  CheckboxGroup,
  Switch,
  Divider,
  PageHeader,
  Drawer,
  Notification,
  Upload,
  Alert,
  Slider,
  Collapse,
  CollapseItem,
  Radio,
  Link,
  Popover
} from 'element-ui'

Vue.use(Button)
Vue.use(Form)
Vue.use(Input)
Vue.use(FormItem)
Vue.use(Container)
Vue.use(Header)
Vue.use(Aside)
Vue.use(Main)
Vue.use(Menu)
Vue.use(MenuItem)
Vue.use(Submenu)
Vue.use(Tree)
Vue.use(Dialog)
Vue.use(Table)
Vue.use(TableColumn)
Vue.use(Loading)
Vue.use(Dropdown)
Vue.use(DropdownMenu)
Vue.use(DropdownItem)
Vue.use(Tabs)
Vue.use(TabPane)
Vue.use(Select)
Vue.use(Option)
Vue.use(Breadcrumb)
Vue.use(BreadcrumbItem)
Vue.use(Pagination)
Vue.use(Tooltip)
Vue.use(Timeline)
Vue.use(TimelineItem)
Vue.use(Steps)
Vue.use(Step)
Vue.use(Transfer)
Vue.use(Row)
Vue.use(Col)
Vue.use(Card)
Vue.use(Avatar)
Vue.use(Tag)
Vue.use(Autocomplete)
Vue.use(Progress)
Vue.use(InputNumber)
Vue.use(Checkbox)
Vue.use(CheckboxButton)
Vue.use(CheckboxGroup)
Vue.use(DatePicker)
Vue.use(TimeSelect)
Vue.use(TimePicker)
Vue.use(Switch)
Vue.use(Scrollbar)
Vue.use(Divider)
Vue.use(PageHeader)
Vue.use(Drawer)
Vue.use(Upload)
Vue.use(Alert)
Vue.use(Slider)
Vue.use(Collapse)
Vue.use(CollapseItem)
Vue.use(Radio)
Vue.use(Link)
Vue.use(Popover)
// 将Message挂在到Vue原型链上,使得每个Vue的实例都能访问
Vue.prototype.$message = {
  success: function (message = '成功的提示消息', duration = 1000, showClose = false) {
    return Message({
      type: 'success',
      showClose: showClose, // 可关闭
      message: message,
      duration: duration
    })
  },
  error: function (message = '错误的提示消息', duration = 1000, showClose = false) {
    return Message({
      type: 'error',
      showClose: showClose,
      message: message,
      duration: duration
    })
  },
  warning: function (message = '错误的提示消息', duration = 1000, showClose = false) {
    return Message({
      type: 'warning',
      showClose: showClose,
      message: message,
      duration: duration
    })
  },
  info: function (message = '错误的提示消息', duration = 1000, showClose = false) {
    return Message({
      type: 'info',
      showClose: showClose,
      message: message,
      duration: duration
    })
  }
}
Vue.prototype.$confirm = {
  success: function (message = '默认提示信息内容?', title = '提示') {
    return MessageBox.confirm(message, title, {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'success'
    })
  },
  error: function (message = '默认提示信息内容?', title = '提示') {
    return MessageBox.confirm(message, title, {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'error'
    })
  },
  warning: function (message = '默认提示信息内容?', title = '提示') {
    return MessageBox.confirm(message, title, {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
  },
  info: function (message = '默认提示信息内容?', title = '提示') {
    return MessageBox.confirm(message, title, {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'info'
    })
  }
}
Vue.prototype.$notify = {
  success: function (message = '成功的提示消息', duration = 1000, position = 'top-right', title = '成功') {
    return Notification({
      title: title,
      message: message,
      type: 'success',
      duration: duration,
      position: position
    })
  },
  error: function (message = '错误的提示消息', duration = 1000, position = 'top-right', title = '错误') {
    return Notification({
      title: title,
      message: message,
      type: 'error',
      duration: duration,
      position: position
    })
  },
  info: function (message = '消息的提示消息', duration = 1000, position = 'top-right', title = '消息') {
    return Notification({
      title: title,
      message: message,
      type: 'info',
      duration: duration,
      position: position
    })
  },
  warning: function (message = '警告的提示消息', duration = 1000, position = 'top-right', title = '警告') {
    return Notification({
      title: title,
      message: message,
      type: 'warning',
      duration: duration,
      position: position
    })
  }
}
Vue.prototype.$alert = {
  success: function (message = '成功消息提示', title = '消息提示') {
    return MessageBox.alert(message, title, {
      confirmButtonText: '确定',
      type: 'success'
    })
  },
  error: function (message = '错误消息提示', title = '消息提示') {
    return MessageBox.alert(message, title, {
      confirmButtonText: '确定',
      type: 'error'
    })
  },
  warning: function (message = '警告消息提示', title = '消息提示') {
    return MessageBox.alert(message, title, {
      confirmButtonText: '确定',
      type: 'warning'
    })
  },
  info: function (message = '默认消息提示', title = '消息提示') {
    return MessageBox.alert(message, title, {
      confirmButtonText: '确定',
      type: 'info'
    })
  }
}
