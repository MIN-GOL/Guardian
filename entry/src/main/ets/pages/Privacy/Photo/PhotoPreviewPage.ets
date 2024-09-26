import { NavigationTitleBuilder } from '../../../common/builders'

// 图片和视频文件关键信息
export interface PhotoItem {
  id: number
  media_uri: string // 媒体文件uri
  privacy_uri: string // 沙箱文件uri
  media_type: number // 媒体文件类型
  date_added: number // 添加日期
}

interface RouterParams {
  previewUri?: string
}

@Entry
@Component
struct PhotoPreviewPage {
  @State list: PhotoItem[] = []
  @State activePhotoUri: string = ''
  @State activeIndex: number = 0
  // 路由参数
  @State routerParams: RouterParams = {}
  private swiperController: SwiperController = new SwiperController()
  private scrollerController: Scroller = new Scroller()

  build() {
    Navigation() {
      Stack({ alignContent: Alignment.Bottom }) {
        Swiper(this.swiperController) {
          ForEach(this.list, (item: PhotoItem) => {
            // TODO: 共享元素转场
            Image(item.privacy_uri)
              .width('100%')
              .objectFit(ImageFit.Contain)
              .sharedTransition('sharedImage', { duration: 800, curve: Curve.Linear, delay: 100 })
          })
        }
        .indicator(false)
        .loop(false)
        .itemSpace(10)
        .index(this.activeIndex)
        .height('100%')
        .padding({ bottom: 138 })
        .onChange((index) => {
          this.activeIndex = index
        })

        // 底部操作栏
        Column({ space: 10 }) {
          // 小图区域
          Scroll(this.scrollerController) {
            Row({ space: 4 }) {
              ForEach(this.list, (item: PhotoItem, index: number) => {
                Image(item.privacy_uri)
                  .width(62)
                  .height(62)
                  .objectFit(ImageFit.Cover)
                  .autoResize(true)
                  .interpolation(ImageInterpolation.Medium)
                  .outline({ width: 1, color: this.activeIndex === index ? $r('app.color.brand') : Color.Transparent })
                  .onClick(() => {
                    this.activeIndex = index
                  })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBarWidth(0)
          .width('100%')
          .height(66)

          // 操作按钮
          Row({ space: 10 }) {
            Button('复制到相册')
              .type(ButtonType.Normal)
              .borderRadius(10)
              .backgroundColor($r('app.color.brand'))
              .layoutWeight(1)
              .onClick(() => {
                // TODO：复制到相册
              })
            Button('删除')
              .type(ButtonType.Normal)
              .borderRadius(10)
              .backgroundColor($r('app.color.danger'))
              .layoutWeight(1)
              .onClick(() => {
                // TODO：删除
              })
          }
          .width('100%')
          .padding({ left: 10, right: 10 })
        }
        .width('100%')
        .height(150)
        .backgroundColor('#80000000')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .height('100%')
    }
    .title(NavigationTitleBuilder(`${this.activeIndex + 1}/${this.list.length}`))
    .hideBackButton(true)
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .backgroundColor('#000')
  }
}