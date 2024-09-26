import { router } from '@kit.ArkUI'

@Component
export struct GuardTabsComp {
  @StorageLink('topHeight') topHeight: number = 0
  @State navigationOpacity: number = 0
  private scroller: Scroller = new Scroller()

  build() {
    // 堆叠布局
    Stack({ alignContent: Alignment.Top }) {
      // 顶部标题
      Text('守护中心')
        .width('100%')
        .height(56 + this.topHeight)
        .textAlign(TextAlign.Center)
        .fontSize(18)
        .backgroundColor($r('app.color.white'))
        .fontWeight(500)
        .position({ x: 0, y: 0 })
        .zIndex(1)
        .opacity(this.navigationOpacity)
        .padding({ top: this.topHeight })
      Stack({ alignContent: Alignment.BottomEnd }) {
        // 滚动容器
        Scroll(this.scroller) {
          Column() {
            // 容器
            Column() {
              // 夜路守护 + 室内守护
              Row({ space: 10 }) {
                Stack({ alignContent: Alignment.TopStart }) {
                  Image('/common/images/GuardPage_bg_ylsh.png')
                    .layoutWeight(1)
                  Column() {
                    Text('夜路守护')
                      .fontSize(16)
                      .fontWeight(500)
                      .fontColor('#584fa7')
                    Text('立即开启')
                      .fontSize(10)
                      .fontColor('#9d96c7')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .padding(20)
                }
                .layoutWeight(1)
                .borderRadius(6)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/Guard/Outdoor/GuardNightPage' })
                })

                Stack({ alignContent: Alignment.TopStart }) {
                  Image('/common/images/GuardPage_bg_snsh.png')
                    .layoutWeight(1)
                  Column() {
                    Text('室内守护')
                      .fontSize(16)
                      .fontWeight(500)
                      .fontColor('#C97C2E')
                    Text('立即开启')
                      .fontSize(10)
                      .fontColor('#D6AE7E')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .padding(20)
                }
                .layoutWeight(1)
                .borderRadius(6)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/Guard/Indoor/IndoorIndexPage' })
                })
              }

              Text('个人防护工具箱')
                .fontSize(18)
                .fontWeight(500)
                .width('100%')
                .margin({ top: 50, bottom: 20 })

              // 个人防护工具箱
              Column() {
                Text('向亲友共享实时位置/行程')
                  .fontSize(14)
                  .fontWeight(500)
                  .fontColor($r('app.color.font'))
                Text('时刻被TA安心守护')
                  .fontSize(12)
                  .fontColor($r('app.color.font_sub'))
                  .layoutWeight(1)
                Row() {
                  Row({ space: 20 }) {
                    Image('/common/images/GuardPage_ic_wzfx.svg')
                      .width(20)
                      .aspectRatio(1)
                    Text('位置分享')
                      .fontSize(14)
                      .fontColor($r('app.color.font'))
                  }
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.Center)

                  Row({ space: 20 }) {
                    Image('/common/images/GuardPage_ic_xcfx.svg')
                      .width(20)
                      .aspectRatio(1)
                    Text('行程分享')
                      .fontSize(14)
                      .fontColor($r('app.color.font'))
                  }
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.Center)
                }
                .width('100%')
                .height(36)
                .borderRadius(10)
                .backgroundColor($r('app.color.white'))
              }
              .width('100%')
              .height(100)
              .margin({ bottom: 20 })
              .padding({
                left: 16,
                right: 16,
                top: 10,
                bottom: 10
              })
              .alignItems(HorizontalAlign.Start)
              .borderRadius(10)
              .backgroundImage('/common/images/GuardPage_bg_map.png')
              .backgroundImageSize(ImageSize.Cover)

              // 伪装来电
              Stack({ alignContent: Alignment.BottomEnd }) {
                Column() {
                  Text('伪装来电')
                    .fontSize(16)
                    .fontWeight(500)
                    .fontColor($r('app.color.font'))
                    .lineHeight(24)
                  Text('脱身好帮手')
                    .fontSize(12)
                    .fontColor($r('app.color.font'))
                    .margin({ top: 4, bottom: 4 })
                  Divider()
                    .width(20)
                    .height(2)
                    .linearGradient({
                      angle: 90,
                      colors: [['#FFF9F7', 0], ['#FE9878', 0.7], ['#FFC13F', 1]]
                    })
                }
                .width('100%')
                .height(100)
                .padding(15)
                .alignItems(HorizontalAlign.Start)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/Guard/Fake/FakeTelPage' })
                })

                Image('/common/images/GuardPage_tool_wzld.png')
                  .width(102)
                  .margin({ right: 10 })
              }
              .width('100%')
              .height(100)
              .margin({ bottom: 10 })
              .borderRadius(10)
              .backgroundColor('#feeae0')

              // 集合
              Grid() {
                // 伪装声音
                GridItem() {
                  Stack({ alignContent: Alignment.BottomEnd }) {
                    Column() {
                      Text('伪装声音')
                        .fontSize(16)
                        .fontWeight(500)
                        .fontColor($r('app.color.font'))
                        .margin({ top: 4, bottom: 4 })
                      Divider()
                        .width(20)
                        .height(2)
                        .linearGradient({
                          angle: 90,
                          colors: [['#FBFBFF', 0], ['#BD9CFF', 0.7], ['#8BACFF', 1]]
                        })
                    }
                    .width('100%')
                    .height('100%')
                    .padding({ top: 15, left: 15 })
                    .alignItems(HorizontalAlign.Start)

                    Image('/common/images/GuardPage_tool_wzsy.png')
                      .height(120)
                      .margin({ right: 20 })
                  }
                  .width('100%')
                  .height('100%')
                  .onClick(() => {
                    router.pushUrl({ url: 'pages/Guard/Fake/FakeVoicePage' })
                  })
                }
                .rowStart(1)
                .rowEnd(3)
                .borderRadius(10)
                .linearGradient({
                  angle: 180,
                  colors: [['#EDEEFF', 0], ['#D3E9FD', 1]]
                })

                GridItem() {
                  Stack({ alignContent: Alignment.BottomEnd }) {
                    Column() {
                      Text('虚拟警报器')
                        .fontSize(16)
                        .fontWeight(500)
                        .fontColor($r('app.color.font'))
                        .margin({ top: 4, bottom: 4 })
                      Divider()
                        .width(20)
                        .height(2)
                        .linearGradient({
                          angle: 90,
                          colors: [['#FBFBFF', 0], ['#fe948d', 1]]
                        })
                    }
                    .width('100%')
                    .height('100%')
                    .padding({ top: 15, left: 15 })
                    .alignItems(HorizontalAlign.Start)

                    Image('/common/images/GuardPage_tool_xnjbq.png')
                      .height(75)
                      .margin({ right: 20 })
                  }
                  .width('100%')
                  .height('100%')
                }
                .rowStart(1)
                .rowEnd(2)
                .borderRadius(10)
                .linearGradient({
                  angle: 185,
                  colors: [['#F0FBE3', 0], ['#FCEDDE', 1]]
                })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/Guard/Alarm/CountdownPage'
                  })
                })

                GridItem() {
                  Stack({ alignContent: Alignment.BottomEnd }) {
                    Column() {
                      Text('手机防移动')
                        .fontSize(16)
                        .fontWeight(500)
                        .fontColor($r('app.color.font'))
                        .margin({ top: 4, bottom: 4 })
                      Divider()
                        .width(20)
                        .height(2)
                        .linearGradient({
                          angle: 90,
                          colors: [['#DCF1FF', 0], ['#5BD0FF', 0.7], ['#7F82F8', 1]]
                        })
                    }
                    .width('100%')
                    .height('100%')
                    .padding({ top: 15, left: 15 })
                    .alignItems(HorizontalAlign.Start)

                    Image('/common/images/GuardPage_tool_sjfyd.png')
                      .height(110)
                      .margin({ right: 20 })
                  }
                  .width('100%')
                  .height('100%')
                }
                .rowStart(3)
                .rowEnd(5)
                .borderRadius(10)
                .linearGradient({
                  angle: -5,
                  colors: [['#D8E5FF', 0], ['#DEF5FF', 1]]
                })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/Guard/Indoor/IndoorCheckMovePage'
                  })
                })

                GridItem() {
                  Stack({ alignContent: Alignment.BottomEnd }) {
                    Column() {
                      Text('摄像头检测')
                        .fontSize(16)
                        .fontWeight(500)
                        .fontColor($r('app.color.font'))
                        .margin({ top: 4, bottom: 4 })
                      Divider()
                        .width(20)
                        .height(2)
                        .linearGradient({
                          angle: 90,
                          colors: [['#FBFBFF', 0], ['#fe948d', 1]]
                        })
                    }
                    .width('100%')
                    .height('100%')
                    .padding({ top: 15, left: 15 })
                    .alignItems(HorizontalAlign.Start)

                    Image('/common/images/GuardPage_tool_sxtjc.png')
                      .height(76)
                      .margin({ right: 20 })
                  }
                  .width('100%')
                  .height('100%')
                }
                .rowStart(4)
                .rowEnd(5)
                .borderRadius(10)
                .linearGradient({
                  angle: 185,
                  colors: [['#F0FBE3', 0], ['#FCEDDE', 1]]
                })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/Guard/Indoor/CheckCameraPage' })
                })

              }
              .columnsTemplate('1fr 1fr')
              .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
              .width('100%')
              .height(100 * 3)
              .rowsGap(10)
              .columnsGap(10)
            }
            .width('100%')
            .padding({ left: 20, right: 20 })

          }
          .justifyContent(FlexAlign.Start)
          .width('100%')
          .padding({ top: 200, bottom: 20 })
          .backgroundImage('/common/images/GuardPage_bg_banner.png')
          .backgroundImageSize({ width: '100%' })

        }
        .scrollBarWidth(0)
        .align(Alignment.Top)
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)
        .width('100%')
        .height('100%')
        .onWillScroll(() => {
          // 获取当前的滚动偏移量
          const scrollTop = this.scroller.currentOffset()
            .yOffset
          // 0 和 1 是透明度的临界点
          this.navigationOpacity = Math.max(0, Math.min(1, scrollTop / 100))
        })

        // 紧急联系人
        Image($r('app.media.ic_guard_contact'))
          .width(94)
          .aspectRatio(1)
          .margin({ bottom: 80 })
          .onClick(() => {
            // 跳转到紧急联系人页
            router.pushUrl({ url: 'pages/Guard/EmergencyContactPage' })
          })
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor($r('app.color.white'))
  }
}