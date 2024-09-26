import { router } from '@kit.ArkUI'
import { PRIVACY_SETTINGS, PrivacySettings } from '../../../common/constants'

@Entry
@Component
struct AuthPatternLockPage {
  // 获取 AppStorage 的数据
  @StorageLink(PRIVACY_SETTINGS) privacySettings: PrivacySettings = {}
  // 输入的密码
  @State inputPasswords: number[] = []
  // 错误提示语
  @State errorMessage: string = ''
  // 错误输入次数
  @State errorInputCount: number = 0
  // 是否允许操作
  @State isEnable: boolean = true
  // 定时器，用于清空提示文案
  private timeoutID: number = -1
  // 图形密码控制器
  private patternLockController: PatternLockController = new PatternLockController()

  build() {
    Column() {
      // 标题
      Navigation() {
        // Column() {
        //   Text('patternPassword：' + this.privacySettings.patternPassword)
        //   Text('passwords：' + encryptMD5(this.inputPasswords.toString()))
        // }

        Column({ space: 20 }) {
          Column({ space: 10 }) {
            // 请输入密码
            Text(this.isEnable ? '请输入密码' : '隐私空间已锁定')
              .fontSize(16)
              .fontColor($r('app.color.font'))
            if (this.errorMessage) {
              Text(this.errorMessage)
                .fontSize(12)
                .fontColor($r('app.color.danger'))
            } else {
              Text('输入密码进入隐私空间')
                .fontSize(12)
                .fontColor($r('app.color.font_sub'))
            }
          }

          PatternLock(this.patternLockController)
            .sideLength(320)// 宽高
            .circleRadius(12)// 圆点半径
            .pathStrokeWidth(10)// 线宽度
            .regularColor('#ffd9d9d9')// 未选中圆点色
            .activeColor('#800a59f7')// 经过圆点色
            .selectedColor(this.errorMessage && this.inputPasswords.length !== 0 ? '#ffff5e5d' : '#ff0a59f7')// 选中圆点色
            .pathColor(this.errorMessage && this.inputPasswords.length !== 0 ? '#ccff5e5d' : '#cc0a59f7')// 线颜色
            .enabled(this.isEnable)
            .onDotConnect(() => {
              // 密码输入选中宫格圆点时触发该回调
              clearTimeout(this.timeoutID)
            })
            .onPatternComplete((input: number[]) => {
              // TODO：密码输入结束时触发该回调
            })

          Row({ space: 20 }) {
            Text('忘记密码')
              .fontSize(14)
              .fontColor($r('app.color.font2'))
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/Privacy/Auth/ForgetPasswordPage',
                })
              })
          }
        }
        .padding({ top: 140 })
      }
      .title('隐私空间')
      .titleMode(NavigationTitleMode.Mini)
      .mode(NavigationMode.Stack)
      .hideTitleBar(false)
    }
    .height('100%')
  }
}