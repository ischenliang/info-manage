export default {
  Layout: () => import('@/views/Layout'),
  MonitorJobList: () => import('@/views/monitor/job/List'),
  MonitorServerList: () => import('@/views/monitor/server/List'),
  MonitorCacheList: () => import('@/views/monitor/cache/List')
}
