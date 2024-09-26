import { router } from '@kit.ArkUI'
import { contact } from '@kit.ContactsKit'
import { NavigationTitleBuilder } from '../../common/builders'
import { themeManager } from '../../manager'

export interface DuplicateGroupItem {
  fullName: string
  list: contact.Contact[]
}

@Entry
@Component
struct ContactOptimizePage {
  // 联系人
  @State contacts: contact.Contact[] = []
  // 群组
  @State groups: contact.Group[] = []
  // 联系人信息完整度数量
  @State unknownContacts: contact.Contact[] = []
  // 重复联系人编组
  @State duplicateGroups: DuplicateGroupItem[] = []

  onPageShow() {
    themeManager.settingStatusBarWhite()
  }

  onPageHide() {
    themeManager.settingStatusBarBlack()
  }

  build() {
    Navigation() {
      Row() {
        Image($r('app.media.ic_contact_small'))
          .width(50)
          .aspectRatio(1)
        Row({ space: 30 }) {
          Column() {
            Text(this.contacts.length.toString())
              .fontSize(32)
              .fontColor('#fff')
            Text('联系人')
              .fontSize(16)
              .fontColor('#fff')
          }

          Divider()
            .vertical(true)
            .strokeWidth(1)
            .color('#5effffff')
            .height(39)

          Column() {
            Text(this.groups.length.toString())
              .fontSize(32)
              .fontColor('#fff')
            Text('群组')
              .fontSize(16)
              .fontColor('#fff')
          }
        }
      }
      .width('100%')
      .height(150)
      .padding({ left: 40, right: 40 })
      .justifyContent(FlexAlign.SpaceBetween)

      // 内容区域
      Column({ space: 10 }) {
        CellRow({
          icon: $r('app.media.ic_contact_cflxr'),
          title: '重复联系人',
          desc: '发现 - 组重复联系人',
          empty: '未发现重复联系人',
          count: this.duplicateGroups.length,
          type: 'Button',
          url: 'pages/Contact/ContactMergePage'
        })
        CellRow({
          icon: $r('app.media.ic_contact_lxrwzd'),
          title: '联系人信息完整度',
          desc: '发现 - 个联系人信息缺失',
          empty: '未发现联系人信息缺失',
          count: this.unknownContacts.length,
          type: 'Button',
          url: 'pages/Contact/ContactUnknownPage'
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor($r('app.color.background'))
    }
    .title(NavigationTitleBuilder('通讯录优化'))
    .hideBackButton(true)
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .linearGradient({
      angle: 180,
      colors: [['#0A59F7', 0], ['#60D3FF', 0.3], ['#f7f7f7', 0.9], ['#f7f7f7', 1]]
    })
  }
}

@Component
struct CellRow {
  @Prop count: number = 0
  icon: ResourceStr = ''
  title: string = ''
  desc: string = ''
  empty: string = ''
  type: 'Button' | 'Switch' = 'Button'
  isOn?: boolean
  url?: string

  build() {
    Row({ space: 15 }) {
      Image(this.icon)
        .width(36)
        .aspectRatio(1)
      Column({ space: 5 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.font'))
        Text() {
          if (this.count > 0) {
            Span(this.desc.split('-')[0])
            Span(this.count.toString())
              .fontColor($r('app.color.brand'))
            Span(this.desc.split('-')[1])
          } else {
            Span(this.empty)
          }
        }
        .fontSize(12)
        .fontColor($r('app.color.font_sub'))
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.type === 'Switch') {
        Toggle({ type: ToggleType.Switch, isOn: this.isOn })
      } else if (this.type === 'Button' && this.count > 0) {
        Button('立即清理')
          .type(ButtonType.Normal)
          .height(28)
          .fontSize(14)
          .fontWeight(500)
          .backgroundColor($r('app.color.brand'))
          .borderRadius(10)
          .onClick(() => {
            // 立即清理
            if (this.url) {
              router.pushUrl({ url: this.url })
            }
          })
      }
    }
    .width('100%')
    .height(76)
    .backgroundColor('#fff')
    .padding({ left: 20, right: 20 })
  }
}