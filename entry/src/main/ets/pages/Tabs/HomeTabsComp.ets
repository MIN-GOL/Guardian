import { router } from '@kit.ArkUI'
import { PRIVACY_SETTINGS, PrivacySettings } from '../../common/constants'
import { showDevelopingTips } from '../../common/dev'

interface IconItem {
  title: ResourceStr
  icon: ResourceStr
  url: string
}

@Component
export struct HomeTabsComp {
  @StorageLink('topHeight') topHeight: number = 0

  build() {
    Scroll() {
      Column() {
        // 头部
        HomeHeader()
        // 入口
        HomeEntry()
        // 快捷方式
        HomeShortcut()
        // 工具
        HomeTool()
      }
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.white'))
    .padding({ top: this.topHeight })
  }
}

@Component
struct HomeHeader {
  build() {
    Row() {
      Image($r("app.media.home_logo"))
        .objectFit(ImageFit.Contain)
        .width(103)
        .height(32)
      Row({ space: 5 }) {
        Image($r("app.media.ic_weather_duoyun"))
          .objectFit(ImageFit.Contain)
          .width(24)
          .height(24)
          .onClick(() => {
            showDevelopingTips()
          })
      }
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct HomeEntry {
  build() {
    Row() {
      Image($r('app.media.ic_home_bozai'))
        .width(100)
        .height(122)
        .margin({ top: 10, left: 30, right: 30 })
      Column() {
        Text() {
          Span('4')
            .fontSize(40)
            .fontColor('#ff5e5d')
          Span(' 个可选安全项')
        }
        .fontSize(14)
        .fontColor($r('app.color.font'))

        Text('立即优化')
          .width(134)
          .height(32)
          .fontSize(14)
          .fontWeight(500)
          .fontColor($r('app.color.white'))
          .borderRadius(10)
          .textAlign(TextAlign.Center)
          .stateStyles({
            normal: {
              .opacity(1)
              .linearGradient({
                angle: 240,
                colors: [['#7ed9ff', 0], [$r('app.color.brand'), 1]]
              })
            },
            pressed: {
              .opacity(0.8)
            }
          })
          .onClick(() => {
            showDevelopingTips()
          })
      }
    }
    .width('100%')
    .height(122)
    .margin({
      bottom: 20
    })
    .borderRadius(16)
    .backgroundColor($r('app.color.white'))
    .shadow({
      offsetX: 0,
      offsetY: 2,
      radius: 16,
      color: '#BBE4E4E4',
    })
  }
}

@Component
struct HomeShortcut {
  // 监听 AppStorage 的数据变化，注意 @Watch 的书写位置
  @StorageLink(PRIVACY_SETTINGS) privacySettings: PrivacySettings = {}
  @State list: IconItem[] = [
    {
      title: '手机瘦身',
      icon: $r("app.media.ic_home_shortcut_sjss"),
      url: '/pages/Cleaner/CleanerIndexPage',
    },
    {
      title: '骚扰拦截',
      icon: $r('app.media.ic_home_shortcut_srlj'),
      url: '/'
    },
    {
      title: '隐私空间',
      icon: $r('app.media.ic_home_shortcut_yskj'),
      url: '/pages/Privacy/PrivacyIndexPage'
    },
    {
      title: '通讯录备份',
      icon: $r('app.media.ic_home_shortcut_txlbf'),
      url: '/pages/Contact/ContactIndexPage'
    },
    {
      title: '反诈中心',
      icon: $r('app.media.ic_home_shortcut_fzzx'),
      url: '/'
    },
    {
      title: '网络测速',
      icon: $r('app.media.ic_home_shortcut_wlcs'),
      url: '/'
    },
  ]

  async openShortcutPage(item: IconItem) {
    // 跳转页面
    if (item.url === '/') {
      showDevelopingTips()
    } else {
      router.pushUrl({ url: item.url.slice(1) })
    }
  }

  build() {
    GridRow({ gutter: 10, columns: 3 }) {
      ForEach(this.list, (item: IconItem, index: number) => {
        GridCol() {
          Column({ space: 10 }) {
            // 取消图片长按时间
            Image(item.icon)
              .width(44)
              .aspectRatio(1)
              .draggable(false)
            Text(item.title)
              .fontSize(14)
              .fontWeight(500)
              .fontColor($r('app.color.font'))
          }
          .width('100%')
          .height(100)
          .justifyContent(FlexAlign.Center)
          .borderRadius(10)
          .shadow({
            offsetX: 0,
            offsetY: 2,
            radius: 18,
            color: '#4DE4E4E4'
          })
          .onClick(() => {
            this.openShortcutPage(item)
          })
        }
      })
    }
  }
}

@Component
struct HomeTool {
  @State list: IconItem[] = [
  //{ name: '流量监控', icon: $r("app.media.ic_tools_lljk"), url: 'pages/Cellular/CellularIndexPage' },
    { title: '电池管家', icon: $r("app.media.ic_tools_dcgj"), url: '/pages/Battery/BatteryIndexPage' },
    { title: '硬件信息', icon: $r("app.media.ic_tools_yjxx"), url: '/pages/Hardware/HardwareIndexPage' },
    { title: '日历清理', icon: $r("app.media.ic_tools_rlql"), url: '/pages/Calendar/CalendarIndexPage' },
    { title: '照片压缩', icon: $r("app.media.ic_tools_zpys"), url: '/pages/Cleaner/Compress/CompressPhotoPage' },
    { title: '摄像头检测', icon: $r("app.media.ic_tools_sxtjc"), url: '/pages/Guard/Indoor/CheckCameraPage' },
    { title: '照片清理', icon: $r("app.media.ic_tools_zpql"), url: '/pages/Cleaner/CleanerSelectPage' },
    { title: '视频压缩', icon: $r("app.media.ic_tools_spys"), url: '/' },
    { title: '流量监控', icon: $r("app.media.ic_tools_lljk"), url: '/' },
    { title: '网络测速', icon: $r("app.media.ic_tools_wlcs"), url: '/' },
  ]

  build() {
    Column() {
      // 首页通用标题
      CommentTitle()
      // 网格布局
      GridRow({ columns: 3 }) {
        ForEach(this.list, (item: IconItem) => {
          GridCol() {
            Column({ space: 10 }) {
              Image(item.icon)
                .width(32)
                .aspectRatio(1)
              Text(item.title)
                .fontSize(12)
            }
            .height(80)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              if (item.url === '/') {
                showDevelopingTips()
              } else {
                router.pushUrl({ url: item.url.slice(1) })
              }
            })
          }
        })
      }
    }
  }
}

@Component
struct CommentTitle {
  build() {
    Row() {
      Text('实用工具')
        .fontColor($r('app.color.font'))
        .fontSize(16)
        .fontWeight(500)
      Row() {
        Text('更多')
          .fontColor($r('app.color.font_sub'))
          .fontSize(12)
          .margin({ left: 5 })
        Image($r('app.media.ic_public_arrow_right'))
          .width(12)
          .aspectRatio(1)
          .fillColor('#89939C')
      }
      .height(20)
      .padding({ left: 2, right: 2 })
      .borderRadius(20 / 2)
      .backgroundColor('#f5f7f9')
      .onClick(() => {
        router.pushUrl({ url: 'pages/Tools/ToolsIndexPage' })
      })
    }
    .width('100%')
    .padding({ top: 20, bottom: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}