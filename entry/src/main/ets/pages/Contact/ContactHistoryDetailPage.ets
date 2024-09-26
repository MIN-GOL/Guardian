import { contact } from '@kit.ContactsKit'

interface RouterParams {
  id?: string
}

@Entry
@Component
struct ContactHistoryDetailPage {
  @State list: contact.Contact[] = []
  @State contactsNum: number = 0
  @State createTime: string = ''
  @State routerParams: RouterParams = {}

  @Builder
  ListHeaderBuilder(date: string, count: number) {
    Row() {
      Text(date + ' 备份')
        .fontSize(14)
        .fontWeight(500)
        .fontColor($r('app.color.font_sub'))
      Text() {
        Span(count.toString())
          .fontSize(13)
          .fontColor($r('app.color.brand'))
          .fontWeight(500)
        Span(' 个联系人')
      }
      .fontColor($r('app.color.font_sub'))
      .fontSize(12)
    }
    .backgroundColor($r('app.color.background'))
    .width('100%')
    .height(40)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 20, right: 20 })
  }

  build() {
    Navigation() {
      List() {
        ListItemGroup({ header: this.ListHeaderBuilder(this.createTime, this.contactsNum) }) {
          ForEach(this.list, (item: contact.Contact) => {
            ListItem() {
              Row() {
                Text(item.name?.fullName || '(无姓名)')
                  .fontSize(16)
                  .fontColor($r('app.color.font'))
                Text(item.phoneNumbers?.[0].phoneNumber || '(无号码)')
                  .fontSize(16)
                  .fontColor($r('app.color.brand'))
              }
              .width('100%')
              .height(45)
              .padding({ left: 20, right: 20 })
              .justifyContent(FlexAlign.SpaceBetween)
              .onClick(() => {
                // TODO: 复制手机号
              })
            }
          })
        }
        .divider({
          strokeWidth: 1,
          color: $r('app.color.border'),
          startMargin: 20,
          endMargin: 20
        })
      }
      .width('100%')
      .height('100%')
    }
    .title('通讯录历史详情')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}