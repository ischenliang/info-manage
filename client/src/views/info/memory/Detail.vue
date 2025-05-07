<template>
  <div class="app-page" style="padding: 0px;">
    <div class="table memory">
      <div class="memory-header">
          <div class="left-top">
            <el-button type="primary" icon="el-icon-back" size="mini" @click="$router.push({ path: '/info/memory/list' })">返回</el-button>
          </div>
        <div class="memory-title">{{ memory.name }}</div>
        <div class="memory-meta">
          <div class="memory-line">
            <span>发表于 {{ memory.ctime }}</span>
            <span class="memory-separator">|</span>
            <span>更新于 {{ memory.mtime }}</span>
          </div>
          <div class="memory-line">
            标签：
            <template v-for="(item, index) in memory.tag">
              <el-tag :key="index" size="mini" type="success">{{ item }}</el-tag>
            </template>
          </div>
          <div class="memory-line">
            排序值：{{ memory.priority }}
          </div>
        </div>
      </div>
      <div class="memory-content markdown-body">
        <article v-html="setContent()"></article>
      </div>
    </div>
    <c-back-up :container="'table'" :top="200" />
  </div>
</template>

<script>
import cBackUp from '../../../components/cBackUp.vue'
export default {
  components: { cBackUp },
  name: 'MemoryDetail',
  computed: {
    id () {
      return this.$route.params.id ? this.$route.params.id : ''
    }
  },
  data () {
    return {
      memory: {}
    }
  },
  methods: {
    // 获取数据
    listGet () {
      // 获取数据....
      this.$http({
        name: 'GetMemory',
        requireAuth: true,
        paths: [this.id]
      }).then(res => {
        this.memory = res.data.data
        this.memory.tag = res.data.data.tag.split(',')
      }).catch(error => {
        this.$notify.error(error)
      })
    },
    setContent () {
      switch (this.memory.type) {
        case 1:
          return this.memory.content
        case 2:
          return this.memory.text
      }
    }
  },
  created () {
    this.listGet()
  }
}
</script>

<style lang="scss">
.memory {
  background: #f0f2f5 !important;
  padding: 1px !important;
  display: flex;
  flex-direction: column;
  &::-webkit-scrollbar {
    display: none;
  }
  .memory-header {
    flex-shrink: 0;
    background-image: url('./images/banner.jpg');
    min-height: 200px;
    width: 100%;
    background-repeat: no-repeat;
    padding: 10px 50px;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    overflow: hidden;
    position: relative;
    .left-top {
      position: absolute;
      top: 10px;
      left: 20px;
    }
    .memory-title{
      font-size: 22px;
      margin-bottom: 0.4rem;
      line-height: 1.5;
      -webkit-line-clamp: 3;
      display: -webkit-box;
      overflow: hidden;
      -webkit-box-orient: vertical;
      color: #fff;
    }
    .memory-meta{
      .memory-line{
        min-height: 26px;
        color: #fff;
        font-size: 14px;
        display: flex;
        flex-wrap: wrap;
        .el-tag {
          margin-left: 5px;
        }
      }
    }
  }
  .memory-content{
    padding: 20px;
    flex: 1;
    overflow: auto;
    article {
      width: 100%;
      min-height: 100%;
      border-radius: 8px;
      padding: 20px 30px;
      min-height: 400px;
      background-color: #fff;
    }
  }
}
</style>
