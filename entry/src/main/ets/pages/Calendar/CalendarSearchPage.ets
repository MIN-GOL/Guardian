import { calendarManager } from '@kit.CalendarKit';
import dayjs from 'dayjs';
import { NavigationTitleBuilder } from '../../common/builders';
import { TitleDividerComp } from '../../common/components/TitleDividerComp';
import { themeManager } from '../../manager';


@Entry
@Component
struct CalendarSearchPage {
  @State list: calendarManager.Event[] = []
  @State searchText: string = ''
  @State activeEvent: calendarManager.Event | null = null
  @State isShowSheet: boolean = false
  @State isEditing: boolean = false
  @State selectedNames: string[] = []

  onPageShow() {
    themeManager.settingStatusBarWhite()
  }

  onPageHide() {
    themeManager.settingStatusBarBlack()
  }

  @Builder
  NavigationMenus() {
    Row() {
      Text(this.isEditing ? '完成' : '清理')
        .fontSize(16)
        .fontColor($r('app.color.white'))
        .onClick(() => {
          this.isEditing = !this.isEditing
        })
        .visibility(this.list.length > 0 ? Visibility.Visible : Visibility.None)
    }
    .height('100%')
    .padding({ right: 25 })
  }

  @Builder
  ListHeader() {
    TitleDividerComp({ title: '相关日历' })
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
        // 顶部搜索框
        Row() {
          Search({ placeholder: '在这里输入日历关键词', value: this.searchText })
            .margin(0)
            .backgroundColor($r('app.color.white'))
            .borderRadius(10)
            .onChange((value) => {
              this.searchText = value
            })
            .onSubmit(() => {
              // TODO：搜索日程
            })
        }
        .padding({
          left: 15,
          right: 15,
          bottom: 20,
          top: 20
        })

        // 搜索结果
        Column() {
          List() {
            ListItemGroup({ header: this.ListHeader() }) {
              ForEach(this.list, (item: calendarManager.Event) => {
                ListItem() {
                  Row() {
                    Checkbox({ name: item.id?.toString() })
                      .visibility(this.isEditing ? Visibility.Visible : Visibility.None)
                    Text(item.title)
                      .fontSize(14)
                      .fontColor($r('app.color.font2'))
                      .layoutWeight(1)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Text(dayjs(item.endTime)
                      .format('YYYY.MM.DD'))
                      .fontSize(14)
                      .fontColor($r('app.color.font_sub'))
                  }
                  .height(40)
                  .padding({ left: 15, right: 15 })
                  .onClick(() => {
                    // 打开日程详情
                    this.isShowSheet = true
                    this.activeEvent = item
                  })
                }
              })
            }
            .divider({
              strokeWidth: 1,
              color: $r('app.color.border'),
              startMargin: 15,
              endMargin: 15
            })
          }
          .sticky(StickyStyle.Header)
          .width('100%')
          .height('100%')
          .visibility(this.list.length > 0 ? Visibility.Visible : Visibility.Hidden)
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor($r('app.color.white'))

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
        .visibility(this.isEditing && this.list.length > 0 ? Visibility.Visible : Visibility.None)
      }
      .height('100%')
    }
    .title(NavigationTitleBuilder('日历搜索'))
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .hideBackButton(true)
    .menus(this.NavigationMenus())
    .linearGradient({
      angle: 180,
      colors: [[$r('app.color.brand'), 0], [$r('app.color.brand_light'), 0.3], [$r('app.color.white'), 0.3]]
    })
    .bindSheet($$this.isShowSheet, this.SheetBuilder(), {
      showClose: false
    })
  }
}