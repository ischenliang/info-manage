// 系统默认提供角色，禁止对其操作
export const defaultRoles = ['admin', 'guest']

// 禁止操作提示
export function showDisableMessage (_this) {
  return _this.$notify.warning('admin和guest角色是默认角色，禁止操作！')
}