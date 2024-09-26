import { contact } from '@kit.ContactsKit';

interface Item {
  id: string
  avatar?: ResourceStr
  name: string
  tel: string
}

@Entry
@Component
struct ContactUnknownPage {
  @State list: contact.Contact[] = []

  @Builder
  swipeActionEndBuilder(key: string) {
    Row() {
      Button('删除')
        .type(ButtonType.Normal)
        .backgroundColor($r('app.color.danger'))
        .fontColor('#fff')
        .height('100%')
        .aspectRatio(1)
        .onClick(async () => {
          // TODO：删除异常联系人
        })
    }
  }

  build() {
    Navigation() {
      if (this.list.length) {
        List() {
          ForEach(this.list, (item: contact.Contact) => {
            ListItem() {
              Row({ space: 10 }) {
                Image(item.portrait?.uri || $r('app.media.ic_public_avatar'))
                  .width(36)
                  .aspectRatio(1)
                Text(item.name?.fullName || '无姓名')
                  .fontSize(16)
                  .fontColor('#444F57')
                  .layoutWeight(1)
                Text(item.phoneNumbers?.[0].phoneNumber || '（无号码）')
                  .fontSize(14)
                  .fontColor($r('app.color.font_sub'))
              }
              .height(70)
              .width('100%')
              .padding({ left: 20, right: 20 })
            }
            .swipeAction({
              end: this.swipeActionEndBuilder(item.key)
            })
          })
        }
        .width('100%')
        .height('100%')
        .divider({
          strokeWidth: 1,
          color: $r('app.color.border'),
          startMargin: 20 + 36 + 10,
          endMargin: 20
        })
      } else {
        Text('恭喜你，已清理所有异常联系人')
          .fontSize(14)
          .padding({ top: 20 })
      }
    }
    .title('无姓名或无号码联系人')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}
