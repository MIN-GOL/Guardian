import { router } from '@kit.ArkUI'
import { NavigationTitleBuilder } from '../../common/builders'
import { LOGIN_INFO } from '../../common/constants'
import { themeManager } from '../../manager'

/** 登录响应 */
export interface LoginInfo {
  accessToken?: string;
  avatar?: string;
  nickname?: string;
  renewalToken?: string;
}

interface Item {
  icon: Resource
  name: string
  url: string
}


@Entry
@Component
struct ContactIndexPage {
  // 同步持久化的用户信息
  @StorageLink(LOGIN_INFO) loginInfo: LoginInfo = {};
  @State progress: number = 0
  private intervalID: number = -1

  onPageShow() {
    themeManager.settingStatusBarWhite()
  }

  onPageHide() {
    themeManager.settingStatusBarBlack()
  }

  @Builder
  NavigationMenus() {
    Row() {
      Image($r("app.media.ic_public_settings"))
        .width(20)
        .aspectRatio(1)
        .onClick(() => {
          router.pushUrl({ url: 'pages/Contact/ContactSettingsPage' })
        })
    }
    .height('100%')
    .padding({ right: 25 })
  }

  build() {
    Navigation() {
      Image($r('app.media.ic_contact_large_circle'))
        .height(200)
        .margin({ top: 100 })
      Column({ space: 20 }) {
        if (this.progress > 0) {
          Text(`${this.progress === 100 ? '成功' : '正在'}备份到云端`)
            .fontSize(16)
            .fontColor('#fff')
          Text(this.progress + '%')
            .fontSize(40)
            .fontColor('#fff')
        } else {
          if (this.loginInfo.accessToken) {
            Text('检测异常联系人，保证通讯录健康')
              .fontSize(16)
              .fontColor('#fff')
            Button('立即查看')
              .type(ButtonType.Normal)
              .backgroundColor('#fff')
              .fontColor($r('app.color.brand'))
              .borderRadius(10)
              .height(28)
              .onClick(() => {
                router.pushUrl({ url: 'pages/Contact/ContactOptimizePage' })
              })
          } else {
            Text('登录帐号，开启通讯录安全备份')
              .fontSize(16)
              .fontColor('#fff')
            Button('立即登录')
              .type(ButtonType.Normal)
              .backgroundColor('#fff')
              .fontColor($r('app.color.brand'))
              .borderRadius(10)
              .height(28)
              .onClick(() => {
                router.pushUrl({ url: 'pages/User/UserLoginPage' })
              })
          }
        }
      }
      .height(180)
      .justifyContent(FlexAlign.Center)

      Column() {
        GridRow({ columns: 3 }) {
          // 备份
          GridCol() {
            Column({ space: 10 }) {
              Image($r('app.media.ic_contact_bf'))
                .height(38)
              Text('备份')
                .fontSize(14)
                .fontColor($r('app.color.font'))
            }
            .onClick(() => {
              // TODO: 通讯录备份
            })
          }

          // 恢复
          GridCol() {
            Column({ space: 10 }) {
              Image($r('app.media.ic_contact_hf'))
                .height(38)
              Text('恢复')
                .fontSize(14)
                .fontColor($r('app.color.font'))
            }
            .onClick(() => {
              // 通讯录备份
              router.pushUrl({ url: 'pages/Contact/ContactHistoryPage' })
            })
          }

          // 优化
          GridCol() {
            Column({ space: 10 }) {
              Image($r('app.media.ic_contact_yh'))
                .height(38)
              Text('优化')
                .fontSize(14)
                .fontColor($r('app.color.font'))
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/Contact/ContactOptimizePage' })
            })
          }
        }
      }
      .layoutWeight(1)
      .padding({ top: 40 })
      .backgroundColor('#fff')
    }
    .title(NavigationTitleBuilder('通讯录备份'))
    .hideBackButton(true)
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .menus(this.NavigationMenus())
    .linearGradient({
      angle: 180,
      colors: [['#0A59F7', 0], ['#60D3FF', 0.65], ['#ffffff', 0.9], ['#ffffff', 1]]
    })
  }
}