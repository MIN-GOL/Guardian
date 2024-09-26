import { router } from '@kit.ArkUI'
import dayjs from 'dayjs'
import { themeManager } from '../../../manager'

interface ButtonItem {
  name: string
  icon: Resource
}

@Entry
@Component
struct FakeTelPage {
  @State isAnswering: boolean = false
  @State count: number = 0
  @State buttonList: ButtonItem[] = [
    { name: '静音', icon: $r('app.media.ic_fake_tel_jy') },
    { name: '拨号键盘', icon: $r('app.media.ic_fake_tel_bhjp') },
    { name: '免提', icon: $r('app.media.ic_fake_tel_mt') },
    { name: '添加通话', icon: $r("app.media.ic_fake_tel_tjth") },
    { name: '视频通话', icon: $r("app.media.ic_fake_tel_spth") },
    { name: '通讯录', icon: $r('app.media.ic_fake_tel_txl') },
  ]
  private intervalID: number = -1

  onPageShow() {
    themeManager.settingStatusBarWhite()
  }

  onPageHide() {
    themeManager.settingStatusBarBlack()
  }

  build() {
    Navigation() {
      Column() {
        // 顶部
        Column({ space: 10 }) {
          Text('亲爱的')
            .fontSize(32)
            .fontColor('#fff')
          Text(this.isAnswering ? dayjs()
            .startOf('day')
            .second(this.count)
            .format('mm:ss') : '中国移动')
            .fontSize(16)
            .fontColor('#fff')
        }

        // 占剩余空间
        Blank()
        // 是否接听
        if (this.isAnswering) {
          GridRow({ columns: 3 }) {
            ForEach(this.buttonList, (item: ButtonItem) => {
              GridCol() {
                Column({ space: 10 }) {
                  Image(item.icon)
                    .height(72)
                  Text(item.name)
                    .fontSize(14)
                    .fontColor('#fff')
                }
                .width('100%')
                .padding(10)
              }
            })
          }
          .padding({ left: 20, right: 20 })

          // 挂电话
          Image($r('app.media.ic_fake_tel_gd'))
            .width(72)
            .margin({ top: 100, bottom: 50 })
            .onClick(() => {
              router.back()
            })
        } else {
          Column({ space: 40 }) {
            Row() {
              Column({ space: 6 }) {
                Image($r('app.media.ic_fake_tel_txw'))
                  .height(28)
                Text('提醒我')
                  .fontSize(14)
                  .fontColor('#fff')
              }

              Column({ space: 6 }) {
                Image($r('app.media.ic_fake_tel_fxx'))
                  .height(28)
                Text('发消息')
                  .fontSize(14)
                  .fontColor('#fff')
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceAround)

            Row() {
              // 挂断
              Column({ space: 6 }) {
                Image($r("app.media.ic_fake_tel_gd"))
                  .height(60)
                Text('挂断')
                  .fontSize(14)
                  .fontColor('#fff')
              }
              .onClick(() => {
                router.back()
              })

              // 接听
              Column({ space: 6 }) {
                Image($r("app.media.ic_fake_tel_jt"))
                  .height(60)
                Text('接听')
                  .fontSize(14)
                  .fontColor('#fff')
              }
              .onClick(() => {
                // TODO: 接听
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceAround)
          }
        }
      }
      .height('100%')
      .padding({ top: 50, bottom: 50 })
    }
    .hideTitleBar(true)
    .linearGradient({
      angle: 180,
      colors: [['#132631', 0], ['#173749', 0.25], ['#183E52', 0.5], ['#273046', 0.75], ['#162634', 1]]
    })
  }
}