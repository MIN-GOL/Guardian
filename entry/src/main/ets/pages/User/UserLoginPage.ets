import { BASE_URL, LOGIN_INFO, LoginInfoResponse } from '../../common/constants'


@Entry
@Component
struct UserLoginPage {
  // 用户信息持久化
  @StorageLink(LOGIN_INFO) loginInfo: LoginInfoResponse = {}
  // 手机号
  @State phoneNumber: string = '131234567890'
  // 短信验证码
  @State verifyCode: string = ''
  // 显示半模态转场结构
  @State isShowSheet: boolean = false
  // 用于更新验证码的时间戳
  @State timestamp: number = Date.now()
  // 图形验证码
  @State graphicCode: string = ''
  // 倒计时数值
  @State count: number = 0
  // 倒计时定时器
  private intervalID: number = -1

  // 半模态转场
  @Builder
  SheetBuilder() {
    Column() {
      Text('图形验证码')
        .fontSize(16)
        .fontColor($r('app.color.font'))
        .margin({ top: 20, bottom: 50 })

      Column({ space: 20 }) {
        Row({ space: 10 }) {
          TextInput({ placeholder: '图形验证码' })
            .fontSize(14)
            .height(42)
            .layoutWeight(1)
            .maxLength(4)
            .onChange((value) => {
              this.graphicCode = value
            })
            .onSubmit(() => {
              // TODO:提交图形验证码
            })
          Image(`${BASE_URL}/code/graphic?phone=${this.phoneNumber}&bizType=${1}&timestamp=${this.timestamp}`)
            .width(108)
            .height(42)
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              this.timestamp = Date.now()
            })
        }

        Button("提交")
          .height(42)
          .backgroundColor($r('app.color.brand'))
          .width('100%')
          .enabled(this.graphicCode.length > 0)
          .onClick(() => {
            // TODO:提交图形验证码
          })
      }
    }
    .padding({ left: 30, right: 30 })
    .width('100%')
    .height('100%')
  }

  build() {
    Navigation() {
      Column() {
        Row({ space: 30 }) {
          Text('验证码登录')
            .fontSize(22)
            .fontWeight(500)
            .fontColor($r('app.color.font'))
        }
        .width('100%')

        Column({ space: 10 }) {
          TextInput({ placeholder: '请输入手机号', text: this.phoneNumber })
            .type(InputType.PhoneNumber)
            .maxLength(12)
            .fontSize(14)
            .height(50)
            .backgroundColor(Color.Transparent)
            .border({ width: { bottom: 1 }, color: $r('app.color.border'), radius: 0 })
            .padding(0)
            .onChange((value) => {
              this.phoneNumber = value
            })

          Stack({ alignContent: Alignment.End }) {
            TextInput({ placeholder: '请输入验证码', text: this.verifyCode })
              .type(InputType.Number)
              .maxLength(6)
              .fontSize(14)
              .height(50)
              .backgroundColor(Color.Transparent)
              .border({ width: { bottom: 1 }, color: $r('app.color.border'), radius: 0 })
              .padding(0)
              .onChange((value) => {
                this.verifyCode = value
              })
            if (this.count > 0) {
              Text(this.count + '秒后重发')
                .fontSize(14)
                .fontColor($r('app.color.font_sub'))
            } else {
              Text('获取验证码')
                .fontSize(14)
                .fontColor($r('app.color.brand'))
                .enabled(this.phoneNumber.length > 0)
                .onClick(() => {
                  this.isShowSheet = true
                })
            }
          }
        }
        .margin({ top: 40, bottom: 40 })

        Column({ space: 20 }) {
          Button('登录')
            .backgroundColor($r('app.color.brand'))
            .height(42)
            .width('100%')
            .enabled(this.phoneNumber.length > 0 && this.verifyCode.length > 0)
            .onClick(() => {
              // TODO:登录表单提交
            })

          Text('仅用于IT培训教学使用，为保障您的个人信息安全请勿向平台录入任何个人敏感信息（如手机号、身份证号等）！')
            .fontSize(14)
            .width('100%')
            .fontColor($r('app.color.danger'))
            .margin({ top: 50 })
        }
      }
      .padding({ left: 30, right: 30, top: 30 })
      .width('100%')
      .height('100%')
    }
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .bindSheet($$this.isShowSheet, this.SheetBuilder(), {
      // 半模态转场,屏幕高度一半，无法修改关闭图标样式
      detents: [SheetSize.MEDIUM],
      backgroundColor: $r('app.color.white')
    })
  }
}

