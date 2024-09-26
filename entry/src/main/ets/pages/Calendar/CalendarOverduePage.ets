import { calendarManager } from '@kit.CalendarKit';
import dayjs from 'dayjs';
import { TitleDividerComp } from '../../common/components/TitleDividerComp';

// 日程信息
interface GroupItem {
  year: string
  list: calendarManager.Event[]
}

@Entry
@Component
struct CalendarOverduePage {
  @State list: calendarManager.Event[] = []
  @State activeEvent: calendarManager.Event | null = null
  @State groupList: GroupItem[] = []
  @State isEditing: boolean = false
  @State isShowSheet: boolean = false
  @State selectedNames: string[] = []

  @Builder
  NavigationMenus() {
    Row() {
      Text(this.isEditing ? '完成' : '清理')
        .fontSize(16)
        .fontColor($r('app.color.font'))
        .onClick(() => {
          this.isEditing = !this.isEditing
        })
    }
    .height('100%')
    .padding({ right: 25 })
  }

  @Builder
  ListHeader(title: string) {
    TitleDividerComp({ title: title })
  }

  @Builder
  swipeActionEnd(id: number) {
    Row() {
      Button("删除")
        .type(ButtonType.Normal)
        .height('100%')
        .fontSize(14)
        .backgroundColor($r('app.color.danger'))
        .onClick(() => {
          // TODO：删除
        })
    }
    .height('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  SheetBuilder() {
    Column({ space: 20 }) {
      if (this.activeEvent) {
        Column({ space: 10 }) {
          Text(this.activeEvent.title)
            .fontSize(18)
            .fontColor($r('app.color.font'))
            .textAlign(TextAlign.Center)
          Text(this.activeEvent.description)
            .fontSize(16)
            .fontColor($r('app.color.font2'))
            .textAlign(TextAlign.Center)
        }

        Text() {
          Span(dayjs(this.activeEvent.startTime)
            .format('YYYY.MM.DD ddd HH:mm'))
          Span('\n至 ')
          Span(dayjs(this.activeEvent.endTime)
            .format('YYYY.MM.DD ddd HH:mm'))
        }
        .fontSize(14)
        .fontColor($r('app.color.font_sub'))
        .textAlign(TextAlign.Center)
        .lineHeight(25)
      }
    }
    .width('100%')
    .height('100%')
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Navigation() {
      Column() {
        List() {
          ForEach(this.groupList, (item: GroupItem) => {
            ListItemGroup({ header: this.ListHeader(item.year) }) {
              ForEach(item.list, (event: calendarManager.Event) => {
                ListItem() {
                  Row() {
                    Checkbox({ name: event.id?.toString() })
                      .shape(CheckBoxShape.CIRCLE)
                      .visibility(this.isEditing ? Visibility.Visible : Visibility.None)
                    Text(event.title)
                      .fontSize(14)
                      .fontColor($r('app.color.font2'))
                      .layoutWeight(1)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .padding({ right: 20 })
                    Text(dayjs(event.endTime)
                      .format('YYYY.MM.DD'))
                      .fontSize(14)
                      .fontColor($r('app.color.font_sub'))
                  }
                  .height(40)
                  .padding({ left: 15, right: 15 })
                  .onClick(() => {
                    this.isShowSheet = true
                    this.activeEvent = event
                  })
                }
                .swipeAction({
                  end: {
                    builder: () => { this.swipeActionEnd(event.id) }
                  }
                })
              })
            }
            .divider({
              strokeWidth: 1,
              color: $r('app.color.border'),
              startMargin: 15,
              endMargin: 15
            })
          })
        }
        .sticky(StickyStyle.Header)
        .width('100%')
        .height('100%')
        .layoutWeight(1)

        Row({ space: 10 }) {
          Column() {
            // 多选框群组
            CheckboxGroup()
              .onChange((event) => {
                this.selectedNames = event.name
              })
            Text('全选')
              .fontSize(12)
              .fontColor($r('app.color.font2'))
          }

          Button('删除')
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .borderRadius(10)
            .backgroundColor($r('app.color.danger'))
            .enabled(this.selectedNames.length > 0)
            .onClick(() => {
              // TODO：批量删除
            })
        }
        .height(76)
        .padding({ left: 20, right: 20 })
        .width('100%')
        .backgroundColor($r('app.color.white'))
        .border({ width: { top: 1 }, color: $r('app.color.border') })
        .visibility(this.isEditing ? Visibility.Visible : Visibility.None)
      }
    }
    .title('过期日程')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .menus(this.NavigationMenus())
    .bindSheet($$this.isShowSheet, this.SheetBuilder(), {
      backgroundColor: Color.White,
      showClose: false
    })
  }
}