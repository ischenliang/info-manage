<template>
  <div class="app-page" style="padding: 12px 15px 12px 15px;">
    <div class="toolbar">
      <el-page-header
        @back="$router.push({ path: '/info/memory/list' })"
        :content="'备忘录详情'" />
      <c-flex-auto />
    </div>
    <div class="table memory">
      <div class="memory-header">
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
              <span :key="index">
                <span>{{ item }}</span>
                <span v-if="index < memory.tag.length - 1" class="memory-separator">|</span>
              </span>
            </template>
          </div>
          <div class="memory-line">
            重要性：<el-rate v-model="memory.priority" disabled show-score text-color="#ff9900" score-template="{value}" />
          </div>
        </div>
      </div>
      <div class="memory-content">
        <article v-html="setContent()"></article>
      </div>
      <div class="memory-footer">
        <article>
          <div class="memory-line">
            <el-tag
              v-for="(item, index) in memory.tag"
              :key="index"
              size="small"
              effect="plain">{{ item }}</el-tag>
          </div>
          <div class="memory-line"><span>备忘录作者</span>: {{ memory.uid }}</div>
          <div class="memory-line"><span>版权</span>: {{ `©${ $moment().format('YYYY') } by 作者` }}</div>
        </article>
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
        this.memory = res.data
        this.memory.tag = res.data.tag.split(',')
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
  .memory-header {
    background-image: url('https://cdn.jsdelivr.net/gh/helinghands/cdn/img/default_top13.jpg');
    min-height: 150px;
    width: 100%;
    background-repeat: no-repeat;
    padding: 10px 50px;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    overflow: hidden;
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
        .memory-separator{
          margin: 0 0.25rem;
        }
      }
    }
  }
  .memory-content{
    padding: 20px;
    article {
      width: 100%;
      border-radius: 8px;
      padding: 20px 30px;
      min-height: 400px;
      background-color: #fff;
    }
  }
  .memory-footer{
    padding: 0 20px;
    article {
      position: relative;
      margin: 10px 0 0.5rem;
      padding: 0.5rem 0.8rem;
      border: 1px solid #ccc;
      transition: box-shadow 0.3s ease-in-out;
      .memory-line{
        min-height: 28px;
        font-size: 14px;
        color: #4c4948;
        .el-tag {
          margin-right: 10px;
          border-radius: 10px;
          &:last-child{
            margin-right: 0;
          }
        }
      }
    }
  }
}
</style>
