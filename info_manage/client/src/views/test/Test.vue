<template>
  <div class="app-page">
    <c-json-excel :name="'GetUsers'" :fields="fields" />
  </div>
</template>

<script>
export default {
  data () {
    return {
      fields: {
        用户名称: 'username',
        用户密码: 'password',
        用户头像: 'avatar',
        用户昵称: 'nickname',
        用户状态: 'status',
        创建时间: 'ctime',
        用户备注: 'remark',
        用户角色: {
          field: 'ur',
          callback: value => {
            const role = []
            value.forEach(item => {
              role.push(item.name)
            })
            return role.join('、')
          }
        }
      }
    }
  }
}
</script>

<style>

</style>
