import { contact } from '@kit.ContactsKit'

export interface DuplicateGroupItem {
  fullName: string
  list: contact.Contact[]
}

@Entry
@Component
struct ContactMergePage {
  @State list: DuplicateGroupItem[] = []
  @State unMergeList: number[] = []
  dialogController: CustomDialogController = new CustomDialogController({
    builder: MergeContactDialog(),
    autoCancel: true,
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Navigation() {
      List() {
        ForEach(this.list, (item: DuplicateGroupItem, index: number) => {
          ListItem() {
            Column() {
              ForEach(item.list, (item2: contact.Contact) => {
                Row({ space: 10 }) {
                  Image($r('app.media.ic_public_avatar'))
                    .width(36)
                    .aspectRatio(1)
                  Column({ space: 5 }) {
                    Text(item2.name?.fullName)
                      .fontSize(16)
                      .fontColor($r('app.color.font'))
                    Text(item2.phoneNumbers?.[0].phoneNumber)
                      .fontSize(14)
                      .fontColor($r('app.color.font_sub'))
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .border({ width: { bottom: 1 }, color: $r('app.color.border') })
                .height(66)
              })
              Row({ space: 20 }) {
                Button('不合并')
                  .type(ButtonType.Normal)
                  .height(42)
                  .borderRadius(10)
                  .backgroundColor($r('app.color.background'))
                  .fontColor($r('app.color.danger'))
                  .layoutWeight(1)
                  .onClick(() => {
                    // 不合并
                  })
                Button('合并')
                  .type(ButtonType.Normal)
                  .height(42)
                  .borderRadius(10)
                  .backgroundColor($r('app.color.background'))
                  .fontColor($r('app.color.brand'))
                  .layoutWeight(1)
                  .onClick(() => {
                    // 合并
                  })
              }
              .margin({ top: 20 })
            }
            .padding(15)
            .width('100%')
            .height(230)
            .borderRadius(6)
            .shadow({
              offsetX: 0,
              offsetY: 3,
              radius: 4,
              color: '#0F000000'
            })
          }
          .margin({ left: 15, right: 15, bottom: 15 })
          .visibility(this.unMergeList.includes(index) ? Visibility.Hidden : Visibility.Visible)
        })
      }
      .height('100%')
      .width('100%')
    }
    .title('联系人合并')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}


@CustomDialog
struct MergeContactDialog {
  controller?: CustomDialogController
  fullName?: string = ''
  onCancel?: () => void
  onConfirm?: () => void

  aboutToAppear() {

  }

  build() {
    Column() {
      Column({ space: 10 }) {
        Column({ space: 5 }) {
          Text('姓名（单选）')
            .fontSize(14)
            .fontColor($r('app.color.font_sub'))
          Row() {
            Radio({ group: 'fullName', value: '1' })
            Text('帐号')
              .fontSize(16)
              .fontColor($r('app.color.font2'))
          }

          Row() {
            Radio({ group: 'fullName', value: '2' })
            Text('帐号2')
              .fontSize(16)
              .fontColor($r('app.color.font2'))
          }
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 5 }) {
          Text('电话（可多选）')
            .fontSize(14)
            .fontColor($r('app.color.font_sub'))
          Row() {
            Checkbox({ name: 'fullName' })
            Text('帐号')
              .fontSize(16)
              .fontColor($r('app.color.font2'))
          }

          Row() {
            Checkbox({ name: 'fullName' })
            Text('帐号2')
              .fontSize(16)
              .fontColor($r('app.color.font2'))
          }
        }
        .alignItems(HorizontalAlign.Start)

        Row({ space: 20 }) {
          Button('取消')
            .fontSize(16)
            .fontColor($r('app.color.font'))
            .backgroundColor($r('app.color.white'))
            .height(42)
            .layoutWeight(1)
            .onClick(() => {
              this.controller?.close()
              this.onCancel?.()
            })
          Button('确定')
            .fontSize(16)
            .fontColor($r('app.color.white'))
            .backgroundColor($r('app.color.brand'))
            .height(42)
            .layoutWeight(1)
            .onClick(() => {
              this.controller?.close()
              this.onConfirm?.()
            })
        }
      }
      .width('100%')
      .borderRadius(24)
      .padding(20)
      .backgroundColor($r('app.color.background2'))
      .alignItems(HorizontalAlign.Start)
    }
    .padding(20)
  }
}