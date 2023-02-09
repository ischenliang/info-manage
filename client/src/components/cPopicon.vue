<template>
  <!-- 不设置title和content：然后设置下面的html代码，会显示在内容区 -->
  <div class="icon-body">
    <div style="width: 100%;margin-bottom: 8px;">
      <el-input v-model="name" placeholder="请输入图标名称" @input="filterIcons"></el-input>
    </div>
    <div class="icons-list">
      <template v-if="filters.length === 0">
        <span>暂无数据</span>
      </template>
      <template v-else v-for="(item, index) in filters">
        <div :key="index" @click="submit(item)" :class="item.value === icon ? 'active' : ''">
          <i :class="item.value" :title="item.value"></i>
          <span>{{ item.name }}</span>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import '@/assets/iconfont/iconfont.css'
export default {
  props: {
    icon: String,
    visible: Boolean,
    type: {
      type: String,
      default: 'menu'
    }
  },
  data () {
    return {
      name: '',
      icons: [],
      filters: []
    }
  },
  methods: {
    submit (row) {
      this.$emit('update:icon', row.value)
      this.$emit('update:visible', false)
      // 提交后应该将图标列表重置
      this.name = ''
      this.filterIcons()
    },
    filterIcons () {
      this.filters = this.icons.filter(item => {
        return item.name.indexOf(this.name) !== -1
      })
    }
  },
  created () {
    switch (this.type) {
      case 'menu':
        this.icons = [
          { name: '定位信息', value: 'el-icon-location-information' },
          { name: '删除', value: 'el-icon-delete' },
          { name: '首页', value: 'el-icon-s-home' },
          { name: '日期', value: 'el-icon-date' },
          { name: '权限', value: 'el-icon-lock' },
          { name: '文件夹', value: 'el-icon-folder' },
          { name: '文件夹(打开)', value: 'el-icon-folder-opened' },
          { name: '设置', value: 'el-icon-setting' },
          { name: '图片(实心)', value: 'el-icon-picture' },
          { name: '图片(空心)', value: 'el-icon-picture-outline' },
          { name: '上传1', value: 'el-icon-upload' },
          { name: '上传2', value: 'el-icon-upload2' },
          { name: '下载', value: 'el-icon-download' },
          { name: '相机(空心)', value: 'el-icon-camera' },
          { name: '相机(实心)', value: 'el-icon-camera-solid' },
          { name: '通知(实心)', value: 'el-icon-message-solid' },
          { name: '通知(空心)', value: 'el-icon-bell' },
          { name: '合作', value: 'el-icon-s-cooperation' },
          { name: '显示器', value: 'el-icon-s-platform' },
          { name: '折叠', value: 'el-icon-s-fold' },
          { name: '展开', value: 'el-icon-s-unfold' },
          { name: '销售', value: 'el-icon-s-marketing' },
          { name: '评论', value: 'el-icon-s-comment' },
          { name: '柱状图', value: 'el-icon-s-data' },
          { name: '网格', value: 'el-icon-s-grid' },
          { name: '菜单', value: 'el-icon-menu' },
          { name: '分享', value: 'el-icon-share' },
          { name: '三角_左', value: 'el-icon-caret-left' },
          { name: '三角_右', value: 'el-icon-caret-right' },
          { name: '三角_下', value: 'el-icon-caret-bottom' },
          { name: '三角_上', value: 'el-icon-caret-top' },
          { name: '打印', value: 'el-icon-printer' },
          { name: '备忘录', value: 'el-icon-notebook-1' },
          { name: '用户', value: 'el-icon-user' },
          { name: '用户(实心)', value: 'el-icon-user-solid' },
          { name: '标签', value: 'el-icon-collection-tag' },
          { name: '收藏', value: 'el-icon-collection' },
          { name: '排序', value: 'el-icon-s-order' },
          { name: '事项', value: 'el-icon-tickets' },
          { name: '接口', value: 'el-icon-s-operation' },
          { name: '指引', value: 'el-icon-position' },
          { name: '监控', value: 'el-icon-video-camera-solid' },
          { name: '服务', value: 'el-icon-service' },
          { name: '缓存', value: 'el-icon-data-line' },
          { name: '信息', value: 'el-icon-takeaway-box' },
          { name: '文档', value: 'el-icon-document' },
          { name: '印章', value: 'el-icon-s-check' },
          { name: '上传', value: 'el-icon-upload' },
          { name: '授权', value: 'el-icon-document-checked' }
        ]
        break
      case 'account':
        this.icons = [
          { name: '火车', value: 'billfont bill-train' },
          { name: '飞机', value: 'billfont bill-airplane' },
          { name: '公交车', value: 'billfont bill-bus' },
          { name: '地铁', value: 'billfont bill-subway' },
          { name: '缆车', value: 'billfont bill-telpher' },
          { name: '自行车', value: 'billfont bill-bike' },
          { name: '汽车', value: 'billfont bill-car' },
          { name: '小船', value: 'billfont bill-boat' },
          { name: '出租车', value: 'billfont bill-taxi' },
          { name: '大船', value: 'billfont bill-ship' },
          { name: '收费站', value: 'billfont bill-stop' },
          { name: '轻轨', value: 'billfont bill-c-ar' },
          { name: '钢琴', value: 'billfont bill-gangqin' },
          { name: '笔记本', value: 'billfont bill-benzi' },
          { name: '便利贴', value: 'billfont bill-bianlitie' },
          { name: '博士帽', value: 'billfont bill-boshimao' },
          { name: '尺子', value: 'billfont bill-chizhi' },
          { name: '调色盘', value: 'billfont bill-tiaosepan' },
          { name: '地球仪', value: 'billfont bill-diqiuyi' },
          { name: '订书器', value: 'billfont bill-dingshuqi' },
          { name: '黑板', value: 'billfont bill-heiban' },
          { name: '钢笔', value: 'billfont bill-gangbi' },
          { name: '奖牌', value: 'billfont bill-jiangpai' },
          { name: '计算器', value: 'billfont bill-jisuanqi' },
          { name: '化学仪器', value: 'billfont bill-shiyan' },
          { name: '课桌', value: 'billfont bill-kezhuo' },
          { name: '铅笔', value: 'billfont bill-qianbi' },
          { name: '三角尺', value: 'billfont bill-sanjiaochi' },
          { name: '书包', value: 'billfont bill-shubao' },
          { name: '水彩笔', value: 'billfont bill-shuicaibi' },
          { name: '图书', value: 'billfont bill-shu' },
          { name: '橡皮檫', value: 'billfont bill-xiangpicha' },
          { name: '医生', value: 'billfont bill-yisheng' },
          { name: 'CT检查', value: 'billfont bill-ct' },
          { name: '药丸', value: 'billfont bill-yaowan' },
          { name: '注射器', value: 'billfont bill-zhusheqi' },
          { name: '救护车', value: 'billfont bill-jiuhuche' },
          { name: '病床', value: 'billfont bill-bingchuang' },
          { name: '听诊器', value: 'billfont bill-tingzhenqi' },
          { name: '牙科', value: 'billfont bill-yake' },
          { name: '吊水', value: 'billfont bill-diaoshui' },
          { name: '手术刀', value: 'billfont bill-shoushudao' },
          { name: '药片', value: 'billfont bill-yaopian' },
          { name: '口罩', value: 'billfont bill-kouzhao' },
          { name: '手术剪', value: 'billfont bill-shoushujian' },
          { name: '体温计', value: 'billfont bill-tiwenji' },
          { name: '轮椅', value: 'billfont bill-lunyi' },
          { name: '医疗箱', value: 'billfont bill-yiliaoxiang' },
          { name: '咖啡', value: 'billfont bill-kafei' },
          { name: '茶', value: 'billfont bill-cha' },
          { name: '饮料', value: 'billfont bill-yinliao' },
          { name: '冰激凌', value: 'billfont bill-bingjiling' },
          { name: '汉堡', value: 'billfont bill-hanbao1' },
          { name: '啤酒', value: 'billfont bill-pijiu' },
          { name: '蛋糕', value: 'billfont bill-dangao' },
          { name: '榴莲', value: 'billfont bill-liulian' },
          { name: '苹果', value: 'billfont bill-pingguo' },
          { name: '梨子', value: 'billfont bill-lizi' },
          { name: '桃子', value: 'billfont bill-taozi' },
          { name: '菠萝蜜', value: 'billfont bill-boluomi' },
          { name: '椰子', value: 'billfont bill-yezi' },
          { name: '哈密瓜', value: 'billfont bill-hamigua' },
          { name: '西瓜', value: 'billfont bill-xigua' },
          { name: '橙子', value: 'billfont bill-cheng' },
          { name: '雪梨', value: 'billfont bill-xueli' },
          { name: '柠檬', value: 'billfont bill-ningmeng' },
          { name: '草莓', value: 'billfont bill-caomei' },
          { name: '菠萝', value: 'billfont bill-boluo' },
          { name: '樱桃', value: 'billfont bill-yingtao' },
          { name: '奇异果', value: 'billfont bill-qiyiguo' },
          { name: '香蕉', value: 'billfont bill-xiangjiao' },
          { name: '葡萄', value: 'billfont bill-lvtao' },
          { name: '蔬菜', value: 'billfont bill-shucai' },
          { name: '牛肉', value: 'billfont bill-niurou' },
          { name: '热狗', value: 'billfont bill-regou' },
          { name: '鱼', value: 'billfont bill-yu' },
          { name: '鸡蛋', value: 'billfont bill-jidan' },
          { name: '火锅', value: 'billfont bill-huoguo' },
          { name: '饭团', value: 'billfont bill-fantuan' },
          { name: '汉堡', value: 'billfont bill-hanbao' },
          { name: '面条', value: 'billfont bill-mian' },
          { name: '面条', value: 'billfont bill-miantiao' },
          { name: '饺子', value: 'billfont bill-jiaozi' },
          { name: '米饭', value: 'billfont bill-fan' },
          { name: '烤鸡', value: 'billfont bill-kaoji' },
          { name: '中餐', value: 'billfont bill-zhongcan' },
          { name: '烤鱼', value: 'billfont bill-kaoyu' },
          { name: '烤串', value: 'billfont bill-kaochuan' },
          { name: '西餐', value: 'billfont bill-xican' },
          { name: '积木', value: 'billfont bill-jimu' },
          { name: '耳机', value: 'billfont bill-erji' },
          { name: '话筒', value: 'billfont bill-huatong' },
          { name: '毽子', value: 'billfont bill-jianzi' },
          { name: '气球', value: 'billfont bill-qiqiu' },
          { name: '水枪', value: 'billfont bill-shuiqiang' },
          { name: '围棋', value: 'billfont bill-weiqi' },
          { name: '排球', value: 'billfont bill-paiqiu' },
          { name: '滑雪', value: 'billfont bill-huaxue' },
          { name: '保龄球', value: 'billfont bill-baolingqiu' },
          { name: '电影', value: 'billfont bill-kandianying' },
          { name: '划船', value: 'billfont bill-huachuan' },
          { name: '桌球', value: 'billfont bill-zhuoqiu' },
          { name: '溜冰鞋', value: 'billfont bill-liubing' },
          { name: '棒球', value: 'billfont bill-bangqiu' },
          { name: '爬山', value: 'billfont bill-dengshan' },
          { name: '飞镖', value: 'billfont bill--feibiao' },
          { name: '篮球', value: 'billfont bill-lanqiu' },
          { name: '羽毛球', value: 'billfont bill-yumaoqiu' },
          { name: '橄榄球', value: 'billfont bill-ganlanqiu' },
          { name: '足球', value: 'billfont bill-zuqiu' },
          { name: '扑克牌', value: 'billfont bill-pukepai' },
          { name: '旋转木马', value: 'billfont bill-xuanzhuanmuma' },
          { name: '象棋', value: 'billfont bill-xiangqi' },
          { name: '游泳', value: 'billfont bill-youyong' },
          { name: '乒乓球', value: 'billfont bill-pingpangqiu' },
          { name: '游戏', value: 'billfont bill-youxi' },
          { name: '猪肉', value: 'billfont bill-zhurou' },
          { name: '烤箱', value: 'billfont bill-kaoxiang' },
          { name: '冰箱', value: 'billfont bill-bingxiang' },
          { name: '吹风机', value: 'billfont bill-chuifengji' },
          { name: '电饭锅', value: 'billfont bill--' },
          { name: '洗衣机', value: 'billfont bill-xiyiji' },
          { name: '空调', value: 'billfont bill-kongtiao' },
          { name: '微波炉', value: 'billfont bill-weibolu' },
          { name: '灯泡', value: 'billfont bill-dengpaoB' },
          { name: '衣帽架', value: 'billfont bill-yimaojia' },
          { name: '矮凳', value: 'billfont bill-aideng' },
          { name: '茶几', value: 'billfont bill-chaji' },
          { name: '茶桌', value: 'billfont bill-chazhuo' },
          { name: '衣柜', value: 'billfont bill-yigui2' },
          { name: '餐边柜', value: 'billfont bill-canbiangui' },
          { name: '床', value: 'billfont bill-chuang' },
          { name: '单椅', value: 'billfont bill-danyi' },
          { name: '床头柜', value: 'billfont bill-chuangtougui2' },
          { name: '电视柜', value: 'billfont bill-dianshigui1' },
          { name: '花架', value: 'billfont bill-huajia' },
          { name: '多宝格', value: 'billfont bill-duobaoge' },
          { name: '屏风', value: 'billfont bill-pingfeng' },
          { name: '挂架', value: 'billfont bill-guajia' },
          { name: '书桌', value: 'billfont bill-shuzhuo' },
          { name: '书架', value: 'billfont bill-shujia1' },
          { name: '罗汉床', value: 'billfont bill-luohanchuang' },
          { name: '台灯', value: 'billfont bill-taideng1' },
          { name: '梳妆台', value: 'billfont bill-shuzhuangtai' },
          { name: '玄关柜', value: 'billfont bill-xuanguangui' },
          { name: '电脑桌', value: 'billfont bill-diannaozhuo' },
          { name: '台灯', value: 'billfont bill-taideng' },
          { name: '烫衣板', value: 'billfont bill-tangyiban' },
          { name: '圆椅', value: 'billfont bill-yuanyi' },
          { name: '书架', value: 'billfont bill-shujia' },
          { name: '洗漱台', value: 'billfont bill-xishutai' },
          { name: '老板椅', value: 'billfont bill-laobanyi' },
          { name: '橱柜', value: 'billfont bill-chugui' },
          { name: '浴缸', value: 'billfont bill-yugang' },
          { name: '马桶', value: 'billfont bill-matong' },
          { name: '洗衣板', value: 'billfont bill-xiyiban' },
          { name: '床头柜', value: 'billfont bill-chuangtougui' },
          { name: '化妆镜', value: 'billfont bill-huazhuangjing' },
          { name: '洗手液', value: 'billfont bill-xishuiye' },
          { name: '化妆台', value: 'billfont bill-huazhuangtai' },
          { name: '衣柜', value: 'billfont bill-yigui' },
          { name: '洗水台', value: 'billfont bill-xishuitai' },
          { name: '电视柜', value: 'billfont bill-dianshigui' },
          { name: '电脑桌', value: 'billfont bill-diannaozhuo1' },
          { name: '客厅桌', value: 'billfont bill-ketingzhuo' },
          { name: '落地灯', value: 'billfont bill-ladideng' },
          { name: '椅子', value: 'billfont bill-yizi' },
          { name: '书柜', value: 'billfont bill-shugui' },
          { name: '双人床', value: 'billfont bill-shuangrenchuang' },
          { name: '书椅', value: 'billfont bill-shuyi' },
          { name: '移动式客厅桌', value: 'billfont bill-yidongshiketingzhuo' },
          { name: '洗水台', value: 'billfont bill-xishuitai1' },
          { name: '厨房', value: 'billfont bill-chufang' },
          { name: '电脑桌', value: 'billfont bill-diannaozhuo2' },
          { name: '冲凉间', value: 'billfont bill-chongliangjian' },
          { name: '床头柜', value: 'billfont bill-chuangtougui1' },
          { name: '椅子', value: 'billfont bill-yizi1' },
          { name: '柜子', value: 'billfont bill-guizi' },
          { name: '落地钟', value: 'billfont bill-ladizhong' },
          { name: '沙发', value: 'billfont bill-shafa' },
          { name: '洗手台', value: 'billfont bill-xishoutai' },
          { name: '大床', value: 'billfont bill-dachuang1' },
          { name: '时钟', value: 'billfont bill-shizhong' },
          { name: '装饰', value: 'billfont bill-zhuangshi' },
          { name: '大门', value: 'billfont bill-damen' },
          { name: '扶手楼梯', value: 'billfont bill-fushoulouti' },
          { name: '椅子', value: 'billfont bill-yizi2' },
          { name: '沙发', value: 'billfont bill-shafa1' },
          { name: '衣架', value: 'billfont bill-yijia' },
          { name: '装饰台', value: 'billfont bill-zhuangshitai' },
          { name: '衣柜', value: 'billfont bill-yigui1' },
          { name: '盆景', value: 'billfont bill-penjing' },
          { name: '地毯', value: 'billfont bill-ditan' },
          { name: '窗台', value: 'billfont bill-chuangtai' }
        ]
        break
    }
    this.filters = this.icons
  }
}
</script>

<style lang="scss">
.icon-body{
  display: flex;
  height: 290px;
  flex-direction: column;
  .icons-list{
    width: 100%;
    height: 242px;
    display: flex;
    flex-wrap: wrap;
    align-content: flex-start;
    overflow: auto;
    > span {
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      color: rgba($color: #000000, $alpha: 0.5);
    }
    > div {
      width: 86px;
      height: 60px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      border-right: 1px solid #eee;
      border-bottom: 1px solid #eee;
      cursor: pointer;
      &:nth-child(1),
      &:nth-child(2),
      &:nth-child(3),
      &:nth-child(4),
      &:nth-child(5),
      &:nth-child(6){
        border-top: 1px solid #eee;
      }
      &:nth-child(6n + 1) {
        border-left: 1px solid #eee;
      }
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
        color: rgba(0, 0, 0, 0.5);
      }
    }
    > div.active {
      background: #69c0e8;
      color: #fff;
      > span {
        color: #fff;
      }
    }
  }
}
</style>
