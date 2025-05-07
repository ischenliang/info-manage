<template>
  <el-card>
    <!-- 标题 -->
    <div slot="header" class="card-title-box">
      <span class="el-card-title">我的日程</span>
      <div class="choice-month-btn">
        <i class="iconfont icon-left" @click="handlePrevMonth"></i>
        <span class="btn-title">{{ headOptions.date }}</span>
        <i class="iconfont icon-right" @click="handleNextMonth"></i>
      </div>
    </div>
    <!-- 星期 -->
    <div class="date-week-text">
      <span
        v-for="(item, itemIndex) in week"
        :key="itemIndex"
        class="week-text-item"
      >
        {{ item }}
      </span>
    </div>
    <!-- 日期 -->
    <div class="date-day-text">
      <span
        :class="[
          { 'month-class': !isCurrentMonth(item.date) },
          { todayBg: isCurrentDay(item.date) }
        ]"
        class="day-text-item"
        v-for="(item, dayIndex) in visibleCalendar"
        :key="dayIndex"
      >
        {{ item.day }}</span
      >
    </div>
    <!-- 内容 -->
    <div class="work-content-box">
      <div class="work-item">
        <i class="iconfont icon-time-circle"></i>
        <span class="time-item">15:30-17:30</span>
        <span class="content-item">文本内容文本内容文本内容</span>
      </div>
      <div class="work-item">
        <i class="iconfont icon-time-circle"></i>
        <span class="time-item">15:30-17:30</span>
        <span class="content-item">文本内容文本内容文本内容</span>
      </div>
      <div class="work-item">
        <i class="iconfont icon-time-circle"></i>
        <span class="time-item">15:30-17:30</span>
        <span class="content-item">文本内容文本内容文本内容</span>
      </div>
    </div>
  </el-card>
</template>

<script>
import * as utils from '@/assets/js/calendar'

export default {
  props: {
    index: {
      type: Number,
      default: 0
    }
  },
  data () {
    const { year, month, day } = utils.getNewDate(new Date())
    return {
      headOptions: {
        date: ''
      },
      week: ['日', '一', '二', '三', '四', '五', '六'],
      time: { year, month, day },
      calendarList: []
    }
  },
  methods: {
    // 是否是当前月
    isCurrentMonth (date) {
      const { year: currentYear, month: currentMonth } = utils.getNewDate(
        utils.getDate(this.time.year, this.time.month, 1)
      )
      const { year, month } = utils.getNewDate(date)
      return currentYear === year && currentMonth === month
    },
    // 是否是今天
    isCurrentDay (date) {
      const {
        year: currentYear,
        month: currentMonth,
        day: currentDay
      } = utils.getNewDate(new Date())
      const { year, month, day } = utils.getNewDate(date)
      return (
        currentYear === year && currentMonth === month && currentDay === day
      )
    },
    // 点击回到今天
    handleToday () {
      this.time = utils.getNewDate(new Date())
      this.headOptions.date = `${this.time.year} 年 ${utils.englishMonth(
        this.time.month
      )} 月`
    },
    // 上一个月
    handlePrevMonth () {
      const prevMonth = utils.getDate(this.time.year, this.time.month, 1)
      prevMonth.setMonth(prevMonth.getMonth() - 1)
      this.time = utils.getNewDate(prevMonth)
      this.headOptions.date = `${this.time.year} 年 ${utils.englishMonth(
        this.time.month
      )} 月`
    },
    // 下一个月
    handleNextMonth () {
      const nextMonth = utils.getDate(this.time.year, this.time.month, 1)
      nextMonth.setMonth(nextMonth.getMonth() + 1)
      this.time = utils.getNewDate(nextMonth)
      this.headOptions.date = `${this.time.year} 年 ${utils.englishMonth(
        this.time.month
      )} 月`
    }
  },
  computed: {
    visibleCalendar () {
      const calendatArr = []
      const { year, month } = utils.getNewDate(
        utils.getDate(this.time.year, this.time.month, 1)
      )
      const currentFirstDay = utils.getDate(year, month, 1)

      // 获取当前月第一天星期几
      const weekDay = currentFirstDay.getDay()
      const startTime = currentFirstDay - (weekDay - 1) * 24 * 60 * 60 * 1000

      let monthDayNum
      if (weekDay === 5 || weekDay === 6) {
        monthDayNum = 42
      } else {
        monthDayNum = 35
      }

      for (let i = 0; i < monthDayNum; i++) {
        calendatArr.push({
          date: new Date(startTime + i * 24 * 60 * 60 * 1000),
          year: year,
          month: month + 1,
          day: new Date(startTime + i * 24 * 60 * 60 * 1000).getDate(),
          clickDay: false
        })
      }
      return calendatArr
    }
  },
  created () {
    this.handleToday()
    this.calendarList = this.visibleCalendar
  },
  mounted () {
    this.$emit('finished', this.index)
  }
}
</script>

<style>
.el-card {
  height: 100%;
}
.el-icon-close {
  font-size: 1.2em;
  cursor: pointer;
}
.el-card-title {
  font-weight: bold;
}
.card-title-box {
  position: relative;
}
.choice-month-btn {
  display: inline;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.btn-title {
  margin: 0 15px;
  cursor: pointer;
}
.icon-left,
.icon-right {
  cursor: pointer;
}
/* 主体区域 */
.date-week-text {
  display: grid;
  grid-template-columns: repeat(7, 14.2%);
  grid-template-rows: repeat(5);
  font-size: 12px;
}
.week-text-item {
  display: grid;
  height: 40px;
  align-items: center;
  justify-items: center;
}
.date-day-text {
  display: grid;
  grid-template-columns: repeat(7, 14.2%);
  grid-template-rows: repeat(5);
  font-size: 12px;
  border-bottom: 1px solid #ebeef5;
  margin-bottom: 10px;
}
.day-text-item {
  display: grid;
  height: 40px;
  align-items: center;
  justify-items: center;
  cursor: pointer;
  position: relative;
}
/* 今天背景 */
.todayBg::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border: 2px solid #396aff;
  width: 35px;
  height: 35px;
  border-radius: 50%;
}
.todayBg::before {
  content: '';
  position: absolute;
  top: 80%;
  left: 50%;
  transform: translate(-50%, -80%);
  width: 5px;
  height: 5px;
  border-radius: 50%;
  background-color: #396aff;
}
/* 非本月灰度 */
.month-class {
  color: #ccc;
}
/* 内容列表 */
.work-content-box {
  display: grid;
  grid-template-columns: repeat(1, 100%);
}
.work-item {
  display: grid;
  grid-template-columns: 0.5fr 2fr 4fr;
  height: 40px;
  line-height: 40px;
}
.work-item i {
  color: #7682a8;
}
.work-item .time-item {
  margin-right: 20px;
  color: #7682a8;
  font-size: 14px;
}
.work-item .content-item {
  color: #424e5c;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
</style>
