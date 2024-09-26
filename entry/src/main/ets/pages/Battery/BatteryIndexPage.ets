import { NavigationTitleBuilder } from '../../common/builders'
import { themeManager } from '../../manager'

@Entry
@Component
struct BatteryIndexPage {
  // 电池百分比
  @State batterySOC: number = 0
  // 电量消耗速率（假设1%每0.24小时）
  @State consumptionRate: number = 0.24
  // 剩余小时
  @State remainingHours: number = 0
  // 剩余分钟
  @State remainingMinutes: number = 0

  onPageShow() {
    themeManager.settingStatusBarWhite()
  }

  onPageHide() {
    themeManager.settingStatusBarBlack()
  }

  // TODO：计算剩余可用时间（剩余电量乘以消耗速率）

  build() {
    Navigation() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Column({ space: 15 }) {
          // 剩余电池
          Column({ space: 4 }) {
            Row()
              .width(28)
              .height(12)
              .backgroundColor($r('app.color.white'))
              .borderRadius({ topLeft: 6, topRight: 6 })
            Column() {
              Column() {
                Text(this.batterySOC + '%')
                  .fontSize(32)
                  .fontColor($r('app.color.brand'))
              }
              .height(this.batterySOC + '%')
              .width('100%')
              .backgroundColor($r('app.color.white'))
              .borderRadius(6)
              .justifyContent(FlexAlign.Center)
            }
            .width(132)
            .height(186)
            .border({ width: 4, color: $r('app.color.white'), radius: 6 })
            .padding(4)
            .justifyContent(FlexAlign.End)
          }

          Text('预计可用')
            .fontSize(24)
            .fontColor($r('app.color.white'))

          // 剩余时间
          Text() {
            Span(this.remainingHours.toString()
              .padStart(2, '0'))
              .fontSize(100)
            Span('小时')
            Span(this.remainingMinutes.toString()
              .padStart(2, '0'))
              .fontSize(100)
            Span('分钟')
          }
          .fontSize(18)
          .fontColor($r('app.color.white'))
        }
        .alignItems(HorizontalAlign.Start)
      }
      .height('100%')
      .padding({ bottom: 40 })
    }
    .title(NavigationTitleBuilder('电池管家'))
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .hideBackButton(true)
    .linearGradient({
      angle: 180,
      colors: [[$r('app.color.brand'), 0], [$r('app.color.brand_light'), 1]]
    })
  }
}