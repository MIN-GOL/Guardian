import { router } from '@kit.ArkUI'

@Entry
@Component
struct GuardIndoorIndexPage {
  build() {
    Navigation() {
      Column() {
        // 波仔
        Stack() {
          Column() {
            Text('Hi,我是护护~')
              .fontSize(14)
              .fontWeight(500)
              .fontColor($r('app.color.font'))
              .margin({ bottom: 4 })
            Text('独自在家，外卖/快递上门，假音变男声，伪装非单身~')
              .fontSize(12)
              .fontColor($r('app.color.font'))
              .lineHeight(18)
          }
          .alignItems(HorizontalAlign.Start)
          .width(216)
          .height(72)
          .borderRadius(10)
          .padding({ left: 15, right: 15, top: 10 })
          .linearGradient({
            angle: 0,
            colors: [['#FFFCFCFC', 0], ['#BDFDC182', 1]]
          })
          .position({ x: 0, y: 50 })
          .zIndex(1)

          Image('/common/images/GuardIndoorPage_bozai.png')
            .width(122)
        }
        .width('100%')
        .alignContent(Alignment.BottomEnd)

        // 底部列表
        Column({ space: 10 }) {
          Row() {
            Text('入室警报器，出差/旅行必备')
              .fontSize(16)
              .fontWeight(500)
              .fontColor($r('app.color.font'))
            Column() {
              Image('/common/images/GuardIndoorPage_ic01.png')
                .width(62)
            }
            .height('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('100%')
          .height(72)
          .backgroundColor('#fff')
          .padding({ left: 15, right: 20 })
          .justifyContent(FlexAlign.SpaceBetween)
          .borderRadius(10)
          .onClick(() => {
            router.pushUrl({ url: 'pages/Guard/Indoor/IndoorCheckMovePage' })
          })

          Row() {
            Text('摄像头检测，保护个人隐私')
              .fontSize(16)
              .fontWeight(500)
              .fontColor($r('app.color.font'))
            Column() {
              Image('/common/images/GuardIndoorPage_ic02.png')
                .width(62)
            }
            .height('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('100%')
          .height(72)
          .backgroundColor('#fff')
          .padding({ left: 15, right: 20 })
          .justifyContent(FlexAlign.SpaceBetween)
          .borderRadius(10)
          .onClick(() => {
            router.pushUrl({ url: 'pages/Guard/Indoor/CheckCameraPage' })
          })

          Row() {
            Text('快递/外卖上门，伪装男声')
              .fontSize(16)
              .fontWeight(500)
              .fontColor($r('app.color.font'))
            Column() {
              Image('/common/images/GuardIndoorPage_ic03.png')
                .width(62)
            }
            .height('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('100%')
          .height(72)
          .backgroundColor('#fff')
          .padding({ left: 15, right: 20 })
          .justifyContent(FlexAlign.SpaceBetween)
          .borderRadius(10)
          .onClick(() => {
            router.pushUrl({ url: 'pages/Guard/Fake/FakeVoicePage' })
          })
        }
      }
      .height('100%')
      .justifyContent(FlexAlign.End)
      .padding({ left: 20, right: 20, bottom: 100 })
    }
    .backgroundImage('/common/images/GuardIndoorPage_bg.png')
    .backgroundImageSize(ImageSize.Cover)
  }
}