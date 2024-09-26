import { router } from '@kit.ArkUI'
import { CellRowArrowComp, CellRowSwitchComp, DividerComp, TitleDividerComp } from '../../common/components'
import { PRIVACY_SETTINGS, PrivacySettings } from '../../common/constants'
import { showDevelopingTips } from '../../common/dev'

interface Item {
  icon: ResourceStr
  name: string
  count: number
  url: string
}

@Entry
@Component
struct PrivacySettingsPage {
  // 获取隐私空间设置
  @StorageLink(PRIVACY_SETTINGS) privacySettings: PrivacySettings = {}
  @State isOpenUserAuthLock: boolean = false
  @State isOpenAntiCracking: boolean = false
  @State list: Item[] = [
    {
      icon: $r('app.media.ic_recorder'),
      name: '录音',
      count: 0,
      url: 'pages/Privacy/Recorder/RecorderIndexPage'
    },
    {
      icon: $r('app.media.ic_notebook'),
      name: '笔记',
      count: 0,
      url: 'pages/Privacy/Note/NoteIndexPage'
    },
    {
      icon: $r('app.media.ic_password_notebook'),
      name: '密码本',
      count: 0,
      url: 'pages/Privacy/Codebook/CodebookIndexPage'
    },
  ]

  build() {
    Navigation() {
      Column() {
        TitleDividerComp({ title: '支持更多类型', fontSize: 12 })

        Row() {
          ForEach(this.list, (item: Item) => {
            Column({ space: 10 }) {
              Image(item.icon)
                .width(30)
                .aspectRatio(1)
              Text(item.name)
                .fontSize(14)
                .fontColor($r('app.color.font'))
              Text(item.count.toString())
                .fontSize(14)
                .fontColor($r('app.color.font_sub'))
            }
            .onClick(() => {
              if (item.url === '/') {
                return showDevelopingTips()
              }
              router.pushUrl({ url: item.url })
            })
          })
        }
        .backgroundColor($r('app.color.white'))
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Top)
        .width('100%')
        .height(130)
        .padding({ top: 32 })

        DividerComp()

        Column() {
          CellRowArrowComp({
            title: this.privacySettings.patternPassword ? '修改手势密码' : '创建手势密码',
            rightText: this.privacySettings.patternPassword ? '' : '未创建',
            rightTextColor: $r('app.color.font_sub'),
          })
            .onClick(() => {
              router.pushUrl({ url: 'pages/Privacy/Auth/AuthPatternLockSettingsPage' })
            })
          CellRowArrowComp({ title: '密码保护问题' })
            .onClick(() => {
              router.pushUrl({ url: 'pages/Privacy/Auth/AuthProtectPage' })
            })
          CellRowSwitchComp({ title: '启用指纹或面容ID解锁', isOn: this.isOpenUserAuthLock })
        }

        DividerComp()
        Column({ space: 10 }) {
          CellRowSwitchComp({ title: '防破解', isOn: this.isOpenAntiCracking })
          Text('输错密码3次，隐私空问锁定1小时')
            .fontSize(12)
            .fontColor($r('app.color.font_sub'))
            .width('100%')
            .padding({ left: 20, right: 20 })
        }
      }
      .backgroundColor('#F7F7F7')
      .height('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM]) // 扩展安全区域的方向
    }
    .title('隐私空间设置')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}