import { router } from '@kit.ArkUI'
import dayjs from 'dayjs'
import { EmptyTipsComp } from '../../../common/components'

// 隐私笔记
interface NoteItem {
  id: number | null
  title: string
  content: string
  date_added: number
}

@Entry
@Component
struct NoteIndexPage {
  // 笔记列表
  @State list: NoteItem[] = []

  @Builder
  swipeActionEnd(id: number) {
    Row() {
      Button("删除")
        .type(ButtonType.Normal)
        .height('100%')
        .aspectRatio(1)
        .backgroundColor('#FF5E5D')
        .onClick(() => {
          // TODO：删除
        })
    }
    .height('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  build() {
    Navigation() {
      Stack({ alignContent: Alignment.Bottom }) {
        if (this.list.length) {
          Column() {
            List() {
              ForEach(this.list, (item: NoteItem) => {
                ListItem() {
                  Row() {
                    Column() {
                      Text(item.title)
                        .fontSize(16)
                        .fontColor($r('app.color.font2'))
                      Text(dayjs(item.date_added)
                        .format('YYYY年MM月DD日'))
                        .fontSize(12)
                        .fontColor($r('app.color.font_sub'))
                        .lineHeight(25)
                    }
                    .alignItems(HorizontalAlign.Start)

                    Column() {
                      Image($r('app.media.ic_arrow_right_small'))
                        .width(22)
                        .aspectRatio(1)
                    }
                    .justifyContent(FlexAlign.Center)
                    .height('100%')
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween)
                  .padding({ left: 15, right: 15 })
                  .onClick(() => {
                    router.pushUrl({ url: 'pages/Privacy/Note/NoteFormPage', params: { id: item.id } })
                  })
                }
                .height(72)
                .transition({ type: TransitionType.Delete, opacity: 0 })
                .swipeAction({
                  end: {
                    builder: () => { this.swipeActionEnd(item.id) },
                    onAction: () => {
                      animateTo({ duration: 1000 }, () => {
                        // TODO：侧滑删除
                      })
                    },
                    actionAreaDistance: 56,
                  },
                  edgeEffect: SwipeEdgeEffect.None
                })
              })
              // 底部占位
              ListItem()
                .height(126)
            }
            // 每行之间的分界线
            .divider({
              strokeWidth: 1,
              color: $r('app.color.border'),
              startMargin: 15,
              endMargin: 15
            })
            .width('100%')
            .height('100%')
          }
          .height('100%')
        } else {
          EmptyTipsComp({ title: '您还没有任何笔记\n点击下面的按钮开始创建' })
        }

        Column() {
          Image($r("app.media.ic_circle_note"))
            .width(56)
            .aspectRatio(1)
            .onClick(() => {
              router.pushUrl({ url: 'pages/Privacy/Note/NoteFormPage' })
            })
        }
        .width('100%')
        .height(126)
        .justifyContent(FlexAlign.Center)
        .padding({ left: 15, right: 15 })
      }
      .height('100%')
    }
    .title('笔记')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}