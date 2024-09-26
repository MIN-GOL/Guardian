
/** 备份记录 */
export interface HistoryItem {
  createTime: string;
  id: string;
  phoneType: string;
  contactsNum: number;
}

interface ListGroupItem {
  date: string
  list: HistoryItem []
}

@Entry
@Component
struct ContactHistoryPage {
  @State isShowSheet: boolean = false
  @State list: HistoryItem[] = []
  @State activeItem: HistoryItem | null = null
  @State groupList: ListGroupItem[] = []

  @Builder
  ListHeaderBuilder(year: string) {
    Row() {
      Text(year)
        .fontSize(14)
        .fontWeight(500)
        .fontColor($r('app.color.font_sub'))
    }
    .backgroundColor($r('app.color.background'))
    .width('100%')
    .height(40)
    .padding({ left: 20, right: 20 })
  }

  @Builder
  swipeActionEndBuilder(id: string) {
    Row() {
      Button('删除')
        .type(ButtonType.Normal)
        .backgroundColor($r('app.color.danger'))
        .fontColor('#fff')
        .height('100%')
        .aspectRatio(1)
        .onClick(() => {
          // TODO: 删除
        })
    }
  }

  @Builder
  SheetBuilder() {
    Column() {
      // 底部弹出层 - 默认隐藏
      Column() {
        Text('查看详情')
          .SheetItem()
          .onClick(() => {
            // TODO: 查看详情
          })
        Text('恢复（替换本机通讯录）')
          .SheetItem()
          .onClick(() => {
            this.isShowSheet = false
            // TODO: 恢复（替换本机通讯录）
          })
        Text('删除')
          .SheetItem($r('app.color.danger'))
          .onClick(() => {
            this.isShowSheet = false
            // TODO: 删除
          })
        Text('取消')
          .SheetItem($r('app.color.font2'))
          .border({ width: 0 })
          .onClick(() => {
            this.isShowSheet = false
          })
      }
      .backgroundColor('#fff')
      .width('100%')
      .borderRadius(24)
      .padding({ left: 15, right: 15 })
    }
    .padding({
      left: 15,
      right: 15,
      bottom: 20,
      top: 20
    })
  }

  build() {
    Navigation() {
      List() {
        ForEach(this.list, (item: HistoryItem) => {
          ListItem() {
            Column({ space: 5 }) {
              Row() {
                Text(item.createTime)
                  .fontSize(16)
                  .fontColor($r('app.color.font'))
                Image($r('app.media.ic_arrow_right_small'))
                  .width(22)
                  .aspectRatio(1)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Text('联系人 ' + item.contactsNum)
                  .fontSize(12)
                  .fontColor($r('app.color.font_sub'))
                Text(item.phoneType)
                  .fontSize(12)
                  .fontColor($r('app.color.font_sub'))
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .height(72)
            .justifyContent(FlexAlign.Center)
            .padding({ left: 20, right: 20 })
            .onClick(() => {
              // 打开面板
            })
          }
          .swipeAction({
            end: this.swipeActionEndBuilder(item.id)
          })
        })
      }
      .divider({
        strokeWidth: 1,
        color: $r('app.color.border'),
        startMargin: 15,
        endMargin: 15
      })
      .sticky(StickyStyle.Header)
      .width('100%')
      .height('100%')
    }
    .title('通讯录备份历史')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .bindSheet($$this.isShowSheet, this.SheetBuilder(), {
      detents: [SheetSize.FIT_CONTENT],
      backgroundColor: Color.Transparent,
      showClose: false
    })
  }
}

@Extend(Text)
function SheetItem(fontColor: ResourceColor = $r('app.color.brand')) {
  .fontSize(16)
  .fontWeight(500)
  .height(50)
  .width('100%')
  .textAlign(TextAlign.Center)
  .fontColor(fontColor)
  .border({ width: { bottom: 1 }, color: $r('app.color.border') })
}
